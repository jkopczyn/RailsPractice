require 'rails_helper'

def signup!(user)
  user.save!
  login!(user)
  user
end

def login!(user)
  visit(new_session_url)

  fill_in('Username', with: user.username)
  fill_in('Password', with: user.password)

  click_button('Sign In')
end


feature 'creating goals' do
  before(:each) do
    user = build(:user)
    signup!(user)
    visit(new_user_goal_url(user.id))
  end

  it 'has a page for creating goals' do
    expect(page).to have_content("Create New Goal")
    expect(page).to have_button("Create Goal")
  end

  it 'create goal with all fields' do
    goal = build(:goal)
    fill_in('Content', with: goal.content)
    fill_in('Title', with: goal.title)
    click_button("Create Goal")
    expect(page).to have_content(goal.content)
    expect(page).to have_content(goal.title)
  end

  it 'goal requires content' do
    goal = build(:goal, content:'')
    fill_in('Content', with: goal.content)
    fill_in('Title', with: goal.title)
    click_button("Create Goal")
    expect(page).to have_content("Content can't be blank")
  end

  it 'goal requires title' do
    goal = build(:goal, title:'')
    fill_in('Content', with: goal.content)
    fill_in('Title', with: goal.title)
    click_button("Create Goal")
    expect(page).to have_content("Title can't be blank")
  end
end

feature 'viewing goals' do
  before(:each) do
    @user = build(:user)
    signup!(@user)

    @other_user = build(:user, username: "other_user")
    signup!(@other_user)

    @private_goal = build(:goal, { private: true,
                                 title: "Be Awesome!",
                                 content: "Don\'t forget" })
    @private_goal.save!
    @public_goal = build(:goal, private: false)
    @public_goal.save!

    login!(@user)
  end

  it "shows user's goals on user's page" do
    visit(user_url(@user))
    expect(page).to have_content("Goals")
    expect(page).to have_content(@private_goal.title)
    expect(page).to have_content(@public_goal.content)
  end

  it 'allows a user to view their own public goals' do
    visit(user_goal_url(@user, @public_goal))
    expect(page).to have_content(@public_goal.title)
    expect(page).to have_content(@public_goal.content)
  end

  it 'allows a user to view their own private goals' do
    visit(user_goal_url(@user, @private_goal))
    expect(page).to have_content(@private_goal.title)
    expect(page).to have_content(@private_goal.content)
  end

  it 'shows only public goals on another user\'s page' do
    login!(@other_user)
    visit(user_url(@user))

    expect(page).to have_content("Goals")
    expect(page).not_to have_content(@private_goal.title)
    expect(page).not_to have_content(@private_goal.content)

    expect(page).to have_content(@public_goal.title)
    expect(page).to have_content(@public_goal.content)
  end

  it 'allows a user to view someone else\'s public goals' do
    login!(@other_user)
    visit(user_goal_url(@user, @public_goal))
    expect(page).to have_content(@public_goal.title)
    expect(page).to have_content(@public_goal.content)
  end

  it 'does not allow a user to view someone else\'s private goals' do
    login!(@other_user)
    visit(user_goal_url(@user, @private_goal))
    expect(page).not_to have_content(@private_goal.title)
    expect(page).not_to have_content(@private_goal.content)
  end
end

feature 'updating goals' do
  before(:each) do
    @user = build(:user)
    signup!(@user)

    @other_user = build(:user, username: "other_user")
    signup!(@other_user)

    @private_goal = build(:goal, private: true)
    @private_goal.save!
    @public_goal = build(:goal, private: false)
    @public_goal.save!

    login!(@user)

  end

  it 'allows a user to change their own goals' do
    login!(@user)
    visit(user_goal_url(@user, @public_goal))
    click_link("Edit")

    expect(page).to have_content("Editing Goal")

    find_field('Content').value.should eq @public_goal.content
    find_field('Title').value.should eq @public_goal.title

    fill_in('Content', with: "HIHIHI")
    fill_in('Title', with: "Do Good Things")
    click_button("Revise Goal")
    expect(page).not_to have_content("Editing Goal")

    #Necessary to ensure it was an edit, not a new
    visit(user_goal_url(@user, @public_goal))
    expect(page).to have_content("HIHIHI")
    expect(page).to have_content("Do Good Things")
  end

  it 'does not allow a user to change anyone else\'s goals' do
    login!(@other_user)
    visit(user_goal_url(@user, @public_goal))

    expect(page).not_to have_link("Edit")

    visit(edit_user_goal_url(@user, @public_goal))
    expect(page).not_to have_content("Editing Goal")
  end
end

feature 'removing goals' do
  before(:each) do
    @user = build(:user)
    signup!(@user)

    @other_user = build(:user, username: "other_user")
    signup!(@other_user)

    @private_goal = build(:goal, { private: true,
                                 title: "Be Awesome!",
                                 content: "Don\'t forget" })
    @private_goal.save!
    @public_goal = build(:goal, private: false)
    @public_goal.save!

    login!(@user)
  end

  it 'allows a user to delete their own goals' do
    visit(user_goal_url(@user, @public_goal))
    click_button("Delete")

    expect(page).to have_content("Goals")
    expect(page).to have_content(@user.username)
    expect(page).not_to have_content(@public_goal.content)
    expect(page).not_to have_content(@public_goal.title)
  end

  it 'does not allow a user to delete anyone else\'s goals' do
    login!(@other_user)
    visit(user_goal_url(@user, @public_goal))
    expect(page).not_to have_button("Delete")
  end
end
