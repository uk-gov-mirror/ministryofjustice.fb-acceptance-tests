class ServiceApp < SitePrism::Page
  element :start_button, :button, 'Start'
  element :continue_button, :button, 'Continue'
  elements :summaries, 'dl .govuk-summary-list__value'
  elements :headings, '.govuk-heading-xl'
  elements :change_links, '.govuk-summary-list__actions a.govuk-link'
  element :send_application_button, :button, 'Accept and send application'

  def load(expansion_or_html = {}, &block)
    puts "Visiting form: #{self.url}"
    super
  end

  def in_summaries_page?
    headings.map(&:text).include?('Check your answers')
  end
end
