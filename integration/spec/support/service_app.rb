class ServiceApp < SitePrism::Page
  element :start_button, :button, 'Start'
  element :continue_button, :button, 'Continue'

  def load(expansion_or_html = {}, &block)
    puts "Visiting form: #{self.url}"
    super
  end
end
