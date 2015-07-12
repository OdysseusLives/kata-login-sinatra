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

      it 'should allow usernames 5 characters or more long' do
				expect(FactoryGirl.build(:user, :username => 'abcde')).to be_valid
		  end

      it 'should disallow repeated usernames' do
        user = FactoryGirl.build(:user)
        user.save!
        duplicated_username_user = FactoryGirl.build(:user, :username => user.username)
				expect(duplicated_username_user).not_to be_valid
      end

      context 'special characters' do
        it 'should allow letters, numbers, and uppercase letters' do
          expect(FactoryGirl.build(:user, :username => 'aaAA11')).to be_valid
          end

        it 'should disallow special characters' do
          expect(FactoryGirl.build(:user, :username => 'aaAA11!@#')).not_to be_valid
        end
      end
    end

    context 'password' do
      it 'should require a password' do
        expect(FactoryGirl.build(:user, :password => '')).not_to be_valid
      end

      it 'should disallow passwords under 8 characters' do
        user = FactoryGirl.build(:user)
        invalid_user = FactoryGirl.build(:user, :password => user.password[0..6])
        expect(invalid_user).not_to be_valid
        expect(invalid_user.password.length).to equal(7)
      end

      it 'should allow passwords 8 characters or more long' do
        user = FactoryGirl.build(:user)
        expect(user).to be_valid
        expect(user.password.length).to equal(8)
      end

      context 'regex' do
        before(:each) do
          @valid_password = '1aA1aA1aA1aA'
        end

        it 'should require passwords to contain a lowercase letter' do
          password = @valid_password.gsub('a', '')
          user = FactoryGirl.build(:user, :password => password)
          expect(user).not_to be_valid
          expect(user.errors[:password].length).to equal(1)
          expect(user.errors[:password][0]).to be == 'Password has an invalid format'
        end

        it 'should require passwords to contain an uppercase letter' do
          password = @valid_password.gsub('A', '')
          user = FactoryGirl.build(:user, :password => password)
          expect(user).not_to be_valid
          expect(user.errors[:password].length).to equal(1)
          expect(user.errors[:password][0]).to be == 'Password has an invalid format'
        end

        it 'should require passwords to contain a number' do
          password = @valid_password.gsub('1', '')
          user = FactoryGirl.build(:user, :password => password)
          expect(user).not_to be_valid
          expect(user.errors[:password].length).to equal(1)
          expect(user.errors[:password][0]).to be == 'Password has an invalid format'
        end
      end
    end
	end
end	