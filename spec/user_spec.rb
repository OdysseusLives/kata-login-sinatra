describe User do
	describe '#save' do 
		before do
			@user = FactoryGirl.build(:user)
			expect(@user).to be_valid, "PRECONDITION FAILED: User is not valid!"
    end
		
		context 'username' do
			it "should require a username" do
				expect(FactoryGirl.build(:user, :username => "")).not_to be_valid
		    expect{ @user.username = "" }.to change(@user, :valid?).to(false)
			end
		end
	end
end	