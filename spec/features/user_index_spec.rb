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
end
