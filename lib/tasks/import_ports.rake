namespace :import do
  task ports: :environment do
    require "net/ftp"
    require "rubygems/package"
    require "zlib"
    require "fileutils"
    require "pry"

    server = "ftp.usa.openbsd.org"
    root = "pub/OpenBSD"
    tgz = "ports.tar.gz"

    ftp = Net::FTP.new(server)
    ftp.login
    ftp.chdir(root)

    # Get the latest OpenBSD version
    latest_release = ftp.nlst
    latest_release = latest_release.grep(/\d/)
    latest_release = latest_release.max

    unless File.exists?(tgz)
      puts "Downloading #{ server }/#{ root }/#{ tgz }..."
      ftp.chdir(latest_release)
      ftp.getbinaryfile(tgz)
    end

    unless File.exists?("ports")
      puts "Extracting..."

      # https://gist.github.com/sinisterchipmunk/1335041/5be4e6039d899c9b8cca41869dc6861c8eb71f13
      io = Zlib::GzipReader.open(tgz)

      def untar(io, destination)
        Gem::Package::TarReader.new io do |tar|
          tar.each do |tarfile|
            destination_file = File.join destination, tarfile.name
              
            if tarfile.directory?
              FileUtils.mkdir_p destination_file
            else
              destination_directory = File.dirname(destination_file)
              FileUtils.mkdir_p destination_directory unless File.directory?(destination_directory)

              puts destination_file

              File.open destination_file, "wb" do |f|
                f.print tarfile.read
              end
            end
          end
        end
      end

      untar(io, ".")

      # Remove unneeded folders
      FileUtils.rm_rf(Dir.glob("ports/CVS"))
      FileUtils.rm_rf(Dir.glob("ports/*/CVS"))
    end

    categories = Dir.glob("ports/*").each { |category_path|
      if File.directory? category_path
        category = File.basename(category_path)

        new_category = Category.create!(
          name: category
        )

        if new_category.valid?
          puts "Category #{ new_category.name } OK"
        end

        ports = Dir.glob("ports/#{ new_category.name }/*").each { |port_path|
          if File.directory? port_path
            port = File.basename(port_path)

            # Get description, summary and URL
            description = "#{ port_path }/pkg/DESCR"
            build_script = "#{ port_path }/Makefile"

            if File.exist?(description)
              description = File.read(description)
            end

            if File.exist?(build_script)
              summary = File.readlines(build_script).find { |line| line =~ /^COMMENT/ }
              url = File.readlines(build_script).find { |line| line =~ /^HOMEPAGE/ }

              if summary
                summary = summary.gsub(/COMMENT=\t/, "")
                summary = summary.rstrip!
              end

              if url
                url = url.gsub(/HOMEPAGE=\t/, "")
                url = url.rstrip!
              end
            end

            new_port = Port.create(
              category: Category.find_by_name(category),
              name: port,
              summary: summary,
              url: url,
              description: description
            )

            if new_port.valid?
              puts "Port #{ category }/#{ new_port.name } OK"
            end
          end
        }
      end
    }
  end
end

