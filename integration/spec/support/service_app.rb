class ServiceApp < SitePrism::Page
  def load(expansion_or_html = {}, &block)
    puts "Visiting form: #{self.url}"
    super
  end
end
