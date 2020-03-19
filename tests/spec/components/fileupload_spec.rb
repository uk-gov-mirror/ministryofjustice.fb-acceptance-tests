require 'capybara/rspec'
require 'spec_helper'

describe 'File Upload' do
  it 'Renders File Upload components' do
    visit 'http://components-fileupload-app:3000'
    click_on 'Start'

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - First'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - First - hint text'

    # fileupload
    attach_file('auto_name__1[1]', 'spec/fixtures/files/1.jpg')
    continue

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Second - hint text'

    # fileupload
    attach_file('auto_name__2[1]', 'spec/fixtures/files/2.jpg')
    continue

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Third - hint text'

    # fileupload
    attach_file('fileupload-third[1]', 'spec/fixtures/files/3.jpg')
    continue

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Fourth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Fourth - hint text'

    # fileupload
    attach_file('auto_name__4[1]', 'spec/fixtures/files/1.jpg')
    add_another_file

    # fileupload
    attach_file('auto_name__4[1]', 'spec/fixtures/files/2.jpg')
    add_another_file

    # fileupload
    attach_file('auto_name__4[1]', 'spec/fixtures/files/3.jpg')
    continue

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Fifth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Fifth'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Fifth - hint text'

    # fileupload
    attach_file('auto_name__5[1]', 'spec/fixtures/files/1.jpg')
    add_another_file

    # fileupload
    attach_file('auto_name__5[1]', 'spec/fixtures/files/2.jpg')
    add_another_file

    # fileupload
    attach_file('auto_name__5[1]', 'spec/fixtures/files/3.jpg')
    continue

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Sixth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Sixth'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Sixth - hint text'

    # fileupload
    attach_file('fileupload-sixth[1]', 'spec/fixtures/files/1.jpg')
    add_another_file

    # fileupload
    attach_file('fileupload-sixth[1]', 'spec/fixtures/files/2.jpg')
    add_another_file

    # fileupload
    attach_file('fileupload-sixth[1]', 'spec/fixtures/files/3.jpg')
    continue

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Upload - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Upload - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: '1.jpg (1.34MB)'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Upload - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Upload - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: '2.jpg (1.34MB)'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Upload - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Upload - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: '3.jpg (1.34MB)'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Upload - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Upload - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: /1\.jpg \(1\.34MB\)\s*2\.jpg \(1\.34MB\)\s*3\.jpg \(1\.34MB\)/

    expect(page).to have_selector 'h2:nth-of-type(5)', text: 'Upload - Fifth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__key', text: 'Upload - Fifth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__value', text: /1\.jpg \(1\.34MB\)\s*2\.jpg \(1\.34MB\)\s*3\.jpg \(1\.34MB\)/

    expect(page).to have_selector 'h2:nth-of-type(6)', text: 'Upload - Sixth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(6) .govuk-summary-list__key', text: 'Upload - Sixth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(6) .govuk-summary-list__value', text: /1\.jpg \(1\.34MB\)\s*2\.jpg \(1\.34MB\)\s*3\.jpg \(1\.34MB\)/

    ########################################
    #                                      #
    #   CHANGE                             #
    #                                      #
    ########################################

    # Change
    find('.govuk-summary-list:nth-of-type(6) .govuk-summary-list__actions a').click

    ########################################
    #                                      #
    #   REMOVE                             #
    #                                      #
    ########################################

    # Remove
    find('.govuk-summary-list .govuk-summary-list__row:nth-of-type(3) button[name="removeFile"]').click

    # fileupload
    attach_file('fileupload-sixth[1]', 'spec/fixtures/files/4.jpg')
    continue

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(6)', text: 'Upload - Sixth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(6) .govuk-summary-list__key', text: 'Upload - Sixth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(6) .govuk-summary-list__value', text: /1\.jpg \(1\.34MB\)\s*2\.jpg \(1\.34MB\)\s*4\.jpg \(1\.34MB\)/

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Sixth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Sixth'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Sixth - hint text'
    back

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Fifth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Fifth'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Fifth - hint text'
    back

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Fourth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Fourth - hint text'
    back

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Third - hint text'
    back

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Second - hint text'
    back

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - First'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - First - hint text'
    back

    ########################################
    #                                      #
    #   START                              #
    #                                      #
    ########################################

    click_on 'Start'

    ########################################
    #                                      #
    #   FORWARD                            #
    #                                      #
    ########################################

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - First'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - First - hint text'

    ########################################
    #                                      #
    #   REMOVE                             #
    #                                      #
    ########################################

    # Remove
    find('.govuk-summary-list .govuk-summary-list__row:nth-of-type(1) button[name="removeFile"]').click

    # fileupload
    attach_file('auto_name__1[1]', 'spec/fixtures/files/1.jpg')
    continue

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Second - hint text'

    ########################################
    #                                      #
    #   REMOVE                             #
    #                                      #
    ########################################

    # Remove
    find('.govuk-summary-list .govuk-summary-list__row:nth-of-type(1) button[name="removeFile"]').click

    # fileupload
    attach_file('auto_name__2[1]', 'spec/fixtures/files/2.jpg')
    continue

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Third - hint text'

    ########################################
    #                                      #
    #   REMOVE                             #
    #                                      #
    ########################################

    # Remove
    find('.govuk-summary-list .govuk-summary-list__row:nth-of-type(1) button[name="removeFile"]').click

    # fileupload
    attach_file('fileupload-third[1]', 'spec/fixtures/files/3.jpg')
    continue

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Fourth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Fourth - hint text'

    ########################################
    #                                      #
    #   REMOVE                             #
    #                                      #
    ########################################

    # Remove
    find('.govuk-summary-list .govuk-summary-list__row:nth-of-type(3) button[name="removeFile"]').click

    # fileupload
    attach_file('auto_name__4[1]', 'spec/fixtures/files/1.jpg')
    continue

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Fifth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Fifth'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Fifth - hint text'

    ########################################
    #                                      #
    #   REMOVE                             #
    #                                      #
    ########################################

    # Remove
    find('.govuk-summary-list .govuk-summary-list__row:nth-of-type(3) button[name="removeFile"]').click

    # fileupload
    attach_file('auto_name__5[1]', 'spec/fixtures/files/2.jpg')
    continue

    # fileupload
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Sixth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Upload - Sixth'
    expect(page).to have_selector '.govuk-hint', text: 'Upload - Sixth - hint text'

    ########################################
    #                                      #
    #   REMOVE                             #
    #                                      #
    ########################################

    # Remove
    find('.govuk-summary-list .govuk-summary-list__row:nth-of-type(3) button[name="removeFile"]').click

    # fileupload
    attach_file('fileupload-sixth[1]', 'spec/fixtures/files/3.jpg')
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Upload - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Upload - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Upload - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: '1.jpg (1.34MB)'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Upload - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Upload - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: '2.jpg (1.34MB)'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Upload - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Upload - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: '3.jpg (1.34MB)'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Upload - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Upload - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: /1\.jpg \(1\.34MB\)\s*2\.jpg \(1\.34MB\)\s*1\.jpg \(1\.34MB\)/

    expect(page).to have_selector 'h2:nth-of-type(5)', text: 'Upload - Fifth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__key', text: 'Upload - Fifth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__value', text: /1\.jpg \(1\.34MB\)\s*2\.jpg \(1\.34MB\)\s*2\.jpg \(1\.34MB\)/

    expect(page).to have_selector 'h2:nth-of-type(6)', text: 'Upload - Sixth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(6) .govuk-summary-list__key', text: 'Upload - Sixth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(6) .govuk-summary-list__value', text: /1\.jpg \(1\.34MB\)\s*2\.jpg \(1\.34MB\)\s*3\.jpg \(1\.34MB\)/

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Upload - Confirmation'
  end

  def back
    find('.govuk-back-link').click
  end

  def continue
    click_on 'Continue'
  end

  def add_another_file
    click_on 'Add another file'
  end
end
