require 'rails_helper'

describe "Visit the users' index page", type: :feature do
  before :each do
    @user1 = User.create(name: 'Nick Jhons', photo: 'https://randomuser.me/api/portraits/men/51.jpg', bio: 'I am a software engineer with more than 3 years of experience on web development.')
    @user2 = User.create(name: 'Jenna Lenz', photo: 'https://randomuser.me/api/portraits/women/54.jpg', bio: 'My name is Jenna Lenz, I am a Frontend Developer with a vast experience on React and Angular frameworks.')
  end

  it "should show the username of all the users listed on the page" do
    visit users_path
    expect(page).to have_content 'Nick Jhons'
    expect(page).to have_content 'Jenna Lenz'
  end

  it 'should show the profile picture for each user' do
    visit users_path

    expect(page).to have_selector('img')

    expect(page).to have_css('img[src="https://randomuser.me/api/portraits/men/51.jpg"]')
    expect(page).to have_css('img[src="https://randomuser.me/api/portraits/women/54.jpg"]')
  end

  it "should show the number of posts each user has written" do
    Post.create(author: @user1, title: 'Post 1 for user 1', text: 'This is the content of Post 1 for user 1')
    Post.create(author: @user1, title: 'Post 2 for user 1', text: 'This is the content of Post 2 for user 1')
    Post.create(author: @user1, title: 'Post 3 for user 1', text: 'This is the content of Post 3 for user 1')

    Post.create(author: @user2, title: 'Post 1 for user 2', text: 'This is the content of Post 1 for user 2')
    Post.create(author: @user2, title: 'Post 2 for user 2', text: 'This is the content of Post 2 for user 2')

    user3 = User.create(name: 'Louis Smith')
    Post.create(author: user3, title: 'Post 1 for user 3', text: 'This is the content of Post 1 for user 3')

    user4 = User.create(name: 'Gerard Ford')
    Post.create(author: user4, title: 'Post 1 for user 4', text: 'This is the content of Post 1 for user 4')
    
    visit users_path

    expect(page).to have_content 'Number of posts: 3'
    expect(page).to have_content 'Number of posts: 2'
    expect(page).to have_content 'Number of posts: 1'
    expect(page).to have_content 'Number of posts: 0'
  end

  it "Click on each username should redirect to the show page of users" do
    visit users_path

    click_link 'Nick Jhons'

    expect(page).to have_current_path (user_path(@user1))
  end
end
