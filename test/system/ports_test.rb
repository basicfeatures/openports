require "application_system_test_case"

class PortsTest < ApplicationSystemTestCase
  setup do
    @port = ports(:one)
  end

  test "visiting the index" do
    visit ports_url
    assert_selector "h1", text: "Ports"
  end

  test "should create port" do
    visit ports_url
    click_on "New port"

    fill_in "Category", with: @port.category_id
    fill_in "Description", with: @port.description
    fill_in "Name", with: @port.name
    fill_in "Summary", with: @port.summary
    fill_in "Url", with: @port.url
    click_on "Create Port"

    assert_text "Port was successfully created"
    click_on "Back"
  end

  test "should update Port" do
    visit port_url(@port)
    click_on "Edit this port", match: :first

    fill_in "Category", with: @port.category_id
    fill_in "Description", with: @port.description
    fill_in "Name", with: @port.name
    fill_in "Summary", with: @port.summary
    fill_in "Url", with: @port.url
    click_on "Update Port"

    assert_text "Port was successfully updated"
    click_on "Back"
  end

  test "should destroy Port" do
    visit port_url(@port)
    click_on "Destroy this port", match: :first

    assert_text "Port was successfully destroyed"
  end
end
