%w{User}.each{|x| eval(x).delete_all}

20.times{IndUser.gen}
IndUser.first.update_attribute(:email,"user1@gmail.com")
IndUser.last.update_attribute(:email,"user2@gmail.com")



