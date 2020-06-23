class ComponentsExitPageApp < ServiceApp
  set_url ENV.fetch('COMPONENTS_EXIT_PAGE_APP')

  element :yes_field, :radio_button, 'Yes', visible: false
  element :no_field, :radio_button, 'No', visible: false
  element :tell_me_your_idea_field, :field, 'Tell me your idea'

  def change_first_answer_link
    change_links.first
  end
end
