class ServiceApp < SitePrism::Page
  def load
    puts "Visiting form: #{self.url}"
    super
  end
end
