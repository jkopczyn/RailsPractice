require 'rails_helper'

feature "the signup process" do
  before(:each) do
    visit(new_user_url)
  end

  it "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do
    before(:each) do
      visit(new_user_url)
    end

    it "shows username on the homepage after signup" do
      fill_in('Username', with: 'IAmACat')
      fill_in('Password', with: 'catcat')

      click_button('Sign Up')
      expect(page).to have_content("IAmACat")
    end

  end

end

feature "logging in" do
  before(:each) do
    visit(new_user_url)

    fill_in('Username', with: 'IAmACat')
    fill_in('Password', with: 'catcat')

    click_button('Sign Up')
    click_button('Sign Out')
  end

  it "shows username on the homepage after login" do
    fill_in('Username', with: 'IAmACat')
    fill_in('Password', with: 'catcat')
    click_button('Sign In')

    expect(page).to have_content("IAmACat")
  end

end

feature "logging out" do
  it "begins with logged out state" do
    visit(users_url)
    expect(page).to have_button("Sign In")
    expect(page).not_to have_content("cat")
  end

  it "doesn't show username on the homepage after logout" do
    visit(new_user_url)

    fill_in('Username', with: 'IAmACat')
    fill_in('Password', with: 'catcat')

    click_button('Sign Up')
    click_button('Sign Out')

    expect(page).to have_button("Sign In")
    expect(page).not_to have_content("IAmACat")

  end

end
