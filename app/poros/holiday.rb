class Holiday
  attr_reader :date, :name

  def initialize(data)
    @date = data[:date]
    @name = data[:localName]
  end

  def format_date
    Date.parse(@date).strftime('%B %d, %Y')
  end
end