class AirbnbHost

    def self.create_host(host_hash, id)
      host = User.create(first_name: host_hash[:first_name], last_name: "Jones", profile_picture: host_hash[:picture_url], password: 'password')
    end
end
