require 'rails_helper'

describe "Visit the 'users' show page", type: :feature do
  before :each do
    @user1 = User.create(
      name: 'Nick Jhons',
      photo: 'https://randomuser.me/api/portraits/men/51.jpg',
      bio: 'I am a software engineer with more than 3 years of experience on web development.'
    )
    @post1 = Post.create(id: 1, author: @user1, title: 'Post 1 for user 1', text: 'Content of Post 1 for user 1')
    Post.create(id: 2, author: @user1, title: 'Post 2 for user 1', text: 'Content of Post 2 for user 1')
    Post.create(id: 3, author: @user1, title: 'Post 3 for user 1', text: 'Content of Post 3 for user 1')
    Post.create(id: 4, author: @user1, title: 'Post 4 for user 1', text: 'Content of Post 4 for user 1')

    Comment.create(post: @post1, author: @user1, text: 'Comment 1 for post 1')
    Comment.create(post: @post1, author: @user1, text: 'Comment 2 for post 1')
    Comment.create(post: @post1, author: @user1, text: 'Comment 3 for post 1')

    Like.create(post: @post1, author: @user1)

    visit user_posts_path(@user1.id)
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

  it "should show a post's title on the page" do
    expect(page).to have_content 'Post 1 for user 1'
  end

  it "should show some of the post's body." do
    expect(page).to have_content 'Content of Post 1 for user 1'
    expect(page).to have_content 'Content of Post 2 for user 1'
    expect(page).to have_content 'Content of Post 3 for user 1'
  end

  it 'should show first comments on a post.' do
    expect(page).to have_content 'Comment 1 for post 1'
  end

  it 'should show how many comments a post has.' do
    expect(page).to have_content 'Comments: 3'
  end

  it 'should show how many likes a post has.' do
    expect(page).to have_content 'Likes: 1'
  end

  it 'should had a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_selector('a')
    expect(page).to have_content 'Next ›'
  end

  it "When click on a post, should redirects to that post's show page" do
    click_link 'Post #1'

    expect(page).to have_current_path(user_post_path(@user1, 1))
  end
end
