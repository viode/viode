require 'rails_helper'

RSpec.feature "User Auth", type: :feature do
  let(:user) { create :confirmed_user }

  scenario "User sign up" do
    visit new_user_registration_path
    expect(current_path).to eq '/register'

    fill_in 'Username', with: 'user'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content(
      'A message with a confirmation link has been sent to your email address.
      Please follow the link to activate your account.'
    )
  end

  scenario "User sign in" do
    visit new_user_session_path
    expect(current_path).to eq '/login'

    fill_in 'Login', with: user.username
    fill_in 'Password', with: '12345678'
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end
end
