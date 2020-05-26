class ComponentsDateApp < ServiceApp
  set_url ENV.fetch('COMPONENTS_DATE_APP')

  element :day_field, :field, 'Day'
  element :month_field, :field, 'Month'
  element :year_field, :field, 'Year'

  elements :error_messages, '.govuk-error-summary__list'

  def error_summary
    self.error_messages.map(&:text)
  end
end
