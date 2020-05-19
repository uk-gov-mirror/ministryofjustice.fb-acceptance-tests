class FeaturesSaveAndReturnApp < ServiceApp
  set_url ENV.fetch('FEATURES_SAVE_AND_RETURN_APP')

  element :start_button, :button, 'Start'
  element :continue_work_on_a_saved_form_button, 'p a[href="/return"]'
  element :save_and_come_back_later_button, 'button[name="setupReturn"]'
  element :continue_button, :button, 'Continue'
  element :email_field, :field, 'Email address'
  element :email_error_summary, '.govuk-error-summary a[href="#return_start_email"]'
  element :email_error_message, '.govuk-error-message'
  element :continue_with_this_form_button, :link, 'Continue with this form'
  element :back_link, :link, 'Back'

  element :usn_field, :field, 'Unique submission number (USN)'

  def has_sign_in_link?
    page.has_selector? 'h1', text: 'Get a sign-in link'
  end

  def has_email_message?(message)
    page.has_selector?('h1 + p', text: message)
  end
end
