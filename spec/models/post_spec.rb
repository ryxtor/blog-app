require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    user = User.create(name: 'Lucas Bonnefon')

    subject { Post.new(title: 'Post title', user_id: user.id) }

    before { subject.save }

    it 'Should be valid' do
      expect(subject).to be_valid
    end

    it 'Should not be valid without title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'Should not be valid if the title is too long' do
      subject.title = 'a' * 300
      expect(subject).to_not be_valid
    end

    it 'Should not be valid if comments_counter is not an integer' do
      subject.comments_counter = 'a'
      expect(subject).to_not be_valid
    end

    it 'Should not be valid if comments_counter is less than 0' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'Should not be valid if likes_counter is not an integer' do
      subject.likes_counter = 'a'
      expect(subject).to_not be_valid
    end

    it 'Should not be valid if likes_counter is less than 0' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'Should increment the user posts counter' do
      expect(subject.user.posts_counter).to eq(1)
    end

    it 'Should return five comments' do
      (1..10).each do
        subject.comments.create(text: 'Comment content', user_id: user.id)
      end
      expect(subject.most_recent_comments.length).to eq(5)
    end

    it 'Should return the short text' do
      subject.text = 'a' * 250
      expect(subject.short_text).to eq("#{'a' * 72}...")
    end

    it 'Should return true if the user has liked the post' do
      user.likes.create(post_id: subject.id)
      expect(subject.liked?(user)).to eq(true)
    end
  end
end
