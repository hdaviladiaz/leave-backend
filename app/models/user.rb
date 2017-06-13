class User
    
    attr_accessor :username, :email
    
    def initialize(email)         
        @email = email
        @username = email.split('@')[0]
    end
end