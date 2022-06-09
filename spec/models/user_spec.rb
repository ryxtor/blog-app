require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject { User.new(name: 'Lucas Bonnefon') }

    before { subject.save }

    it 'Should be valid' do
      expect(subject).to be_valid
    end

    it 'Should not be valid without name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Should not be valid if posts_counter is not an integer' do
      subject.posts_counter = 'a'
      expect(subject).to_not be_valid
    end

    it 'Should not be valid if posts_counter is less than 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'Should return three posts' do
      (1..5).each do
        subject.posts.create(title: 'Post title')
      end
      expect(subject.most_recent_posts.length).to eq(3)
    end
  end
end
