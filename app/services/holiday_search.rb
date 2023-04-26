class HolidaySearch
  def holidays
    service.holidays.map do |data|
      Holiday.new(data)
    end
  end

  def service
    NagerService.new
  end
end