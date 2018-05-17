require 'rails_helper'

RSpec.feature "Ask specific user", type: :feature do
  let(:bob)       { create :confirmed_user, username: "Bob"}
  let!(:ted)       { create :confirmed_user, username: "Ted" }
  let!(:category) { create :category }

  scenario "Bob asks Ted a question from the new question page" do
    visit new_user_session_path
    fill_in 'Login', with: bob.username
    fill_in 'Password', with: '12345678'
    click_button 'Log in'

    visit new_question_path
    fill_in 'Title', with: "Am I doing this right?"
    select category.name, from: 'question_category_id'
    select ted.username, from: 'question_intended_respondent_id'
    fill_in 'question_body', with: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget justo non risus sodales sollicitudin in sit amet enim."
    fill_in 'question_tag_list', with: "testing"
    click_button 'Add question'

    expect(page).to have_selector("h3.title", text: "Am I doing this right?")
    expect(Question.last.intended_respondent_id).to eql(ted.id)
  end

  scenario "Bob clicks 'Ask this user' on Ted's profile" do
    visit new_user_session_path
    fill_in 'Login', with: bob.username
    fill_in 'Password', with: '12345678'
    click_button 'Log in'

    visit user_path(ted)
    click_link 'Ask me a question'

    expect(page).to have_select('question_intended_respondent_id', selected: ted.username)
  end
end
