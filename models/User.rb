class User
  include DataMapper::Resource
  
  property :id,           Serial
  property :username,     String, :required => true
  property :password,     String, :required => true
  property :completed_at, DateTime
end