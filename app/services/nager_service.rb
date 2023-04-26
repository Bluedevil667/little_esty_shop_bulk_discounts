require 'httparty'
require 'json'

class NagerService

  def holidays
    get_url('https://date.nager.at/api/v3/NextPublicHolidays/US')
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)[0..2]
  end
end