
const portNumber = 8000;
const routes = require('./routes.json');
const fs = require('fs')
const data = require('./data.json');
const bodyParser = require('body-parser')
const jsonServer = require('json-server');
const path = require('path');


const server = jsonServer.create();
const router = jsonServer.router(data);

let nPath = path.normalize(__dirname + '/data.json');
const db = JSON.parse(fs.readFileSync(nPath));

server.use(bodyParser.urlencoded({ extended: true }))
server.use(bodyParser.json())
server.use(jsonServer.defaults());

// utility functions
function emailExists(email) {
  return db.users.findIndex(user => user.email === email) !== -1;
}
function otpExists(email, otp) {
  return db.OTPs.findIndex(val => val.OTP === otp && val.email === email) !== -1;
}
function usernameExists(username) {
  return db.users.findIndex(user => user.username === username) !== -1;
}

function passMatches(email, password) {
  return db.users.find(user => user.email === email).password === password;
}

function getRandom(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

// Overwritten routes
server.post('/users/likes', function (req, res, next) {
     fs.readFile(nPath, (err, data) => {
      let jsonData = JSON.parse(data.toString());
      let likedTweet=jsonData.tweets.find(tweet => tweet.tweet_id === req.body.tweet_id);
      likedTweet['like_count']++;
      likedTweet["liker_ids"].push(req.body.user_id);
      fs.writeFile(nPath, JSON.stringify(jsonData), (err, result) => {
        res.status(200).json({ });
      });
    });
});

server.post('/signup/verify', function (req, res, next) {
  let exists = emailExists(req.body.email);
  if (exists) {
    res.status(400).json({ "message": "email does already exist" });
  } else {
    let otp = getRandom(1000, 9999);
    let userId = getRandom(100000000000000, 999999999999999);
    let token = getRandom(100000000000000, 999999999999999);

    fs.readFile(nPath, (err, data) => {
      let jsonData = JSON.parse(data.toString());
      jsonData.OTPs.push({
        "_id": userId.toString(),
        "OTP": otp.toString(),
        "token": token.toString(),
        "email": req.body.email
      });
      fs.writeFile(nPath, JSON.stringify(jsonData), (err, result) => {
        res.status(200).json({
          "message": "OTP SENT",
          "OTP": otp
        });
      });
    });
  }

});

server.get('/signup/confirm_email', function (req, res, next) {
  let otp = req.query.OTP;
  let email = req.query.email;
  console.log(otp, email);
  if (otpExists(email, otp)) {
    res.status(200).json({
      "200": "Email verified",
      "email": email
    });
  } else {
    res.status(401).json({ "message": "OTP Expired" });
  }
});

server.post('/signup', function (req, res, next) {
  if (usernameExists(req.body.username)) {
    res.status(400).json({ "message": "username exists" });
  } else {
    fs.readFile(nPath, (err, data) => {
      let jsonData = JSON.parse(data.toString());
      req.body['_id'] = jsonData.OTPs.find(usr => usr.email === req.body.email)._id;  // create "_id" field
      jsonData.users.push(req.body);
      fs.writeFile(nPath, JSON.stringify(jsonData), (err, result) => {
        res.status(200).json({ "message": "Successufly inserted new user" });
      });
    });
  }
});

server.post('/login', function (req, res, next) {
  // Todo 200
  if (!emailExists(req.body.email)) {
    res.status(404).json({ "message": "email doesn't exist" });
  } else if (!passMatches(req.body.email, req.body.password)) {
    res.status(400).json({ "message": "incorrect password" });
  } else {
    let token = getRandom(100000000000000, 999999999999999);
    res.status(201).json({
      "message": "user found",
      "token": token.toString(),
      "_id": db.users.find(user => user.email === req.body.email && user.password === req.body.password)._id
    });
  }
});

//server.post('/tweets', function (req, res, next) {
//
//  fs.readFile(nPath, (err, data) => {
//    let jsonData = JSON.parse(data.toString());
//
//    // get user's data who has a specific user_id
//    let user = jsonData.users.find(usr => usr.user_id === req.body.user_id);
//    if (typeof user === 'undefined') {
//      res.json();
//    }
//
//    // ======= Add data that is not available in the POST request body of tweet creation =========
//    req.body['tweet_id'] = getRandom(100000000000000, 999999999999999);
//    //
//    req.body['name'] = user.name;
//    req.body['prof_pic_url'] = '';
//    req.body['bio'] = '';
//    req.body['followers_count'] = 0;
//    req.body['following_count'] = 0;
//    //
//    req.body['like_count'] = 0;
//    req.body['liker_ids'] = [];
//    req.body['comment_count'] = 0;
//    req.body['retweet_count'] = 0;
//    req.body['comments'] = [];
//    // ==========================================
//    jsonData.tweets.push(req.body);
//    fs.writeFile(nPath, JSON.stringify(jsonData), (err, result) => {
//      res.status(200).json();
//    });
//  });
//
//});


server.use(jsonServer.rewriter(routes));
server.use(router);

server.listen(portNumber, () => {
  console.log("JSON Server is running");

});