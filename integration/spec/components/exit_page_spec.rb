describe 'Exit page' do
  let(:form) { ComponentsExitPageApp.new }

  before do
    form.load
    form.start_button.click
  end

  context 'when I answer a page that goes to an exit page' do
    it 'then I should be redirect to the exit page' do
      form.yes_field.choose
      form.continue_button.click

      expect(form.text).to include('Sorry - exit page')
      expect(form.text).to include('You are not eligible')
    end
  end

  context 'when my answer does not go to an exit page' do
    it 'then I should continue the journey' do
      form.no_field.choose
      form.continue_button.click

      form.tell_me_your_idea_field.set('Foobar')
      form.continue_button.click

      expect(form).to be_in_summaries_page
      form.send_application_button.click
      expect(form.text).to include('Thank you')
    end
  end

  context 'when I change my answer that goes to an exit page' do
    it 'then I should be redirect to the exit page' do
      form.no_field.choose
      form.continue_button.click

      form.tell_me_your_idea_field.set('Wow')
      form.continue_button.click

      expect(form).to be_in_summaries_page

      form.change_first_answer_link.click
      form.yes_field.choose
      form.continue_button.click
      expect(form.text).to_not include('Check your answers')
      expect(form.text).to include('Sorry - exit page')
      expect(form.text).to include('You are not eligible')
    end
  end
end
