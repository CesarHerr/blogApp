require 'rails_helper'

describe "Visit the 'users' show page", type: :feature do
  before :each do
    @user1 = User.create(
      name: 'Nick Jhons',
      photo: 'https://randomuser.me/api/portraits/men/51.jpg',
      bio: 'I am a software engineer with more than 3 years of experience on web development.'
    )
    Post.create(id: 1, author: @user1, title: 'Post 1 for user 1', text: 'This is the content of Post 1 for user 1')
    Post.create(id: 2, author: @user1, title: 'Post 2 for user 1', text: 'This is the content of Post 2 for user 1')
    Post.create(id: 3, author: @user1, title: 'Post 3 for user 1', text: 'This is the content of Post 3 for user 1')
    Post.create(id: 4, author: @user1, title: 'Post 4 for user 1', text: 'This is the content of Post 4 for user 1')

    visit user_path(@user1.id)
  end

  it 'should show the profile picture' do
    expect(page).to have_selector('img')
    expect(page).to have_css('img[src="https://randomuser.me/api/portraits/men/51.jpg"]')
  end

  it 'should show the username on the page' do
    expect(page).to have_content 'Nick Jhons'
  end

  it 'should show the number of posts on the page' do
    expect(page).to have_content 'Number of posts: 4'
  end

  it "should show the user's bio on the page" do
    expect(page).to have_content 'I am a software engineer with more than 3 years of experience on web development.'
  end

  it 'should display recent 3 posts by the user' do
    expect(page).to have_content('Post #4')
    expect(page).to have_content('Post #3')
    expect(page).to have_content('Post #2')
  end

  it "should show  a button that lets view all of a user's posts" do
    expect(page).to have_selector('button')
    expect(page).to have_content "User's posts"
  end

  it "When click a user's post, should redirects to that post's show page" do
    click_link 'Post #4'
    expect(page).to have_current_path(user_post_path(@user1, 4))
  end

  it 'Click on each username should redirect to the show page of users' do
    click_link "User's posts"
    expect(page).to have_current_path(user_posts_path(@user1))
  end
end
