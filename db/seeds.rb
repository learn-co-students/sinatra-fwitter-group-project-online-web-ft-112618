user = User.create(username: "aaj3f", email: "ajohnson.uva@gmail.com", password: "hippofreak")
t1 = Tweet.create(content: "hello world!")
t2 = Tweet.create(content: "woah first tweet!")
user.tweets << t1
user.tweets << t2
