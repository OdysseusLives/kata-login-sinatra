class User
  include DataMapper::Resource
  
  property :id,           Serial
  property :username,     String, :required => true, :unique => true, :format => /^\w+$/
  property :password,     String, :required => true
  property :completed_at, DateTime

  validates_length_of :username, :min => 5
  validates_length_of :password, :min => 8
end