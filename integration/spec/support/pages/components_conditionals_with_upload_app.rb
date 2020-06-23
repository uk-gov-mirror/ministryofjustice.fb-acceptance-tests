class ComponentsConditionalsWithUploadApp < ServiceApp
  set_url ENV.fetch('COMPONENTS_UPLOAD_WITH_CONDITIONAL_APP')

  element :start_button, :button, 'Start'
  element :back_link, :link, 'Back'
  element :tuesday_today_yes,
          :radio_button,
          'Yes',
          name: 'tuesday_today',
          visible: false,
          option: 'yes'
  element :tuesday_today_no,
          :radio_button,
          'No',
          name: 'tuesday_today',
          visible: false,
          option: 'no'
  element :confirm_upload_field, :radio_button, 'Yes, add this upload', visible: false
  element :continue_button, :button, 'Continue'

  def change_tuesday_answer_link
    change_links.first
  end

  def in_summaries_page?
    headings.map(&:text).include?('Check your answers')
  end

  def tuesday_today_summary_text
    summaries.first.text
  end

  def uploaded_file_summary_text
    summaries.last.text
  end
end
