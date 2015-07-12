describe User do
	describe '#save' do
    it 'should have a valid factory' do
      expect(FactoryGirl.build(:user)).to be_valid
    end

		context 'username' do
			it 'should require a username' do
				expect(FactoryGirl.build(:user, :username => '')).not_to be_valid
		  end

      it 'should disallow usernames under 5 characters' do
				expect(FactoryGirl.build(:user, :username => 'abcd')).not_to be_valid
		  end

      it 'should disallow repeated usernames' do
        user = FactoryGirl.build(:user)
        user.save!
        duplicated_username_user = FactoryGirl.build(:user, :username => user.username)
				expect(duplicated_username_user).not_to be_valid
      end
		end
	end
end	