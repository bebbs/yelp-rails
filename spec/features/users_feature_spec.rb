require 'rails_helper'

context "user not signed in and on the homepage" do
  it "should see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).to have_link('Sign in')
    expect(page).to have_link('Sign up')
  end

  it "should not see 'sign out' link" do
    visit('/')
    expect(page).not_to have_link('Sign out')
  end
end

context "user signed in on the homepage" do

  before do
    sign_up_and_in('abc@123.com', 'password1', 'password1')
  end

  it "should see 'sign out' link" do
    visit('/')
    expect(page).to have_link('Sign out')
  end

  it "should not see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
  end
end

context "user limits" do

  it "A user must be logged in to create restaurants" do
    visit '/'
    click_link 'Add a restaurant'
    expect(page).to have_content 'sign up before continuing'
  end

  it 'Users can only delete restaurants which they\'ve created' do
    visit '/'
    sign_up_and_in('abc@123.com', 'password1', 'password1')
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    click_link 'Sign out'
    sign_up_and_in('baduser@123.com', 'password1', 'password1')
    click_link 'Delete KFC'
    expect(page).to have_content 'You can only delete restaurants you have added'
    expect(page).to have_content 'Reviews for KFC'
  end

    it 'Users can only edit restaurants which they\'ve created' do
    visit '/'
    sign_up_and_in('abc@123.com', 'password1', 'password1')
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    click_link 'Sign out'
    sign_up_and_in('baduser@123.com', 'password1', 'password1')
    click_link 'Edit KFC'
    expect(page).to have_content 'You can only edit restaurants you have added'
    expect(page).to have_content 'Reviews for KFC'
  end



end












