require_relative "../spec_helper"

describe FioAPI::List do
  before(:each) do
    @list = FioAPI::List.new
  end

  it "should set request with uri for date range" do
    date_from = Date.new(2011,1,1)
    date_to = Date.new(2012,11,25)
    url = "https://www.fio.cz/ib_api/rest/periods/#{FioAPI.token}/#{date_from}/#{date_to}/transactions.json"
    @list.by_date_range(date_from, date_to).request.uri.to_s.should eq url
  end

  it "should set request with uri for listing_id and year" do
    year = 2012
    id = "12345"
    url = "https://www.fio.cz/ib_api/rest/by-id/#{FioAPI.token}/#{year}/#{id}/transactions.json"
    @list.by_listing_id_and_year(id, year).request.uri.to_s.should eq url
  end

  it "should set request with uri from last fetch" do
    url = "https://www.fio.cz/ib_api/rest/last/#{FioAPI.token}/transactions.json"
    @list.from_last_fetch.request.uri.to_s.should eq url
  end

  it "should set request with uri to set last fetch id" do
    id = "12345"
    url = "https://www.fio.cz/ib_api/rest/set-last-id/#{FioAPI.token}/#{id}/"
    @list.set_last_fetch_id(id).request.uri.to_s.should eq url
  end

  it "should set request with uri to set last date" do
    date = Date.new(2012,11,25)
    url = "https://www.fio.cz/ib_api/rest/set-last-date/#{FioAPI.token}/#{date}/"
    @list.set_last_fetch_date(date).request.uri.to_s.should eq url
  end

end
