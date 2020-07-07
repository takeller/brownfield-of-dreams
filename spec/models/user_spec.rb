require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'Class Methods' do
    it '.check_for_username' do
      User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, username: 'takeller')

      5.times do
        create(:user)
      end

      expect(User.check_for_username?("takeller")). to eq(true)
      expect(User.check_for_username?("George")). to eq(false)
    end
  end

  describe 'Instance Methods' do
    it '#activated?' do
      user1 = User.create(email: 'user1@email.com', password: 'password', first_name:'Jim', role: 0, username: 'takeller')
      user2 = User.create(email: 'user2@email.com', password: 'password', first_name:'Jim', role: 0, username: 'takeller', status: "Active")

      expect(user1.activated?).to eq(false)
      expect(user2.activated?).to eq(true)
    end

    it '#activate' do
      user1 = User.create(email: 'user1@email.com', password: 'password', first_name:'Jim', role: 0, username: 'takeller')

      expect(user1.activated?).to eq(false)

      user1.activate

      expect(user1.activated?).to eq(true)
    end
  end
end
