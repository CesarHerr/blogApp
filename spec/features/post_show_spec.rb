require 'rails_helper'

describe "Visit the 'users' show page", type: :feature do
  before :each do
    @user1 = User.create(
      name: 'Nick Jhons',
      photo: 'https://randomuser.me/api/portraits/men/51.jpg',
      bio: 'I am a software engineer with more than 3 years of experience on web development.'
    )

    user2 = User.create(name: 'César', photo: 'www.google.cl', bio: 'I am a software engineer ...')
    user3 = User.create(name: 'Freddy', photo: 'www.google.com', bio: 'I am a software engineer too...')
    @post1 = Post.create(id: 1, author: @user1, title: 'Post 1 for user 1', text: 'Content of Post 1 for user 1')

    Comment.create(post: @post1, author: @user1, text: 'Comment 1 for post 1')
    Comment.create(post: @post1, author: user2, text: 'Comment 2 for post 1')
    Comment.create(post: @post1, author: user3, text: 'Comment 3 for post 1')

    Like.create(post: @post1, author: @user1)

    visit user_post_path(@user1.id, @post1.id)
  end

  it "should show a post's title on the page" do
    expect(page).to have_content 'Post 1 for user 1'
  end

  it 'should show who wrote the post' do
    expect(page).to have_content 'Nick Jhons'
  end

  it 'should show how many comments it has.' do
    expect(page).to have_content 'Comments: 3'
  end

  it 'should show how many likes it has.' do
    expect(page).to have_content 'Likes: 1'
  end

  it 'should show the post body.' do
    expect(page).to have_content 'Content of Post 1 for user 1'
  end

  it 'should show username of the author of each comment' do
    expect(page).to have_content 'Nick Jhons'
    expect(page).to have_content 'César'
    expect(page).to have_content 'Freddy'
  end

  it 'should show the body of each comment' do
    expect(page).to have_content 'Comment 1 for post 1'
    expect(page).to have_content 'Comment 2 for post 1'
    expect(page).to have_content 'Comment 3 for post 1'
  end
end
