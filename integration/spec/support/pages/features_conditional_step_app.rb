class FeaturesConditionalSteps < ServiceApp
  set_url ENV.fetch('FEATURES_CONDITIONAL_STEPS_APP')

  element :first_option, :radio_button, 'One', visible: false
  element :second_option, :radio_button, 'Two', visible: false

  element :a_field, :checkbox, 'A', visible: false
  element :b_field, :checkbox, 'B', visible: false
  element :c_field, :checkbox, 'C', visible: false

  element :email_field, :field, 'Email'
  element :number_field, :field, 'Number'
  element :text_field, :field, 'Text'

  element :section_heading, '.fb-sectionHeading'
  elements :summary_answers, '.govuk-summary-list'

  [
    :first_answer,
    :second_answer,
    :third_answer,
    :fourth_answer,
    :fifth_answer
  ].each_with_index do |method_name, index|
    define_method method_name do
      summary_answers[index].text
    end
  end
end
