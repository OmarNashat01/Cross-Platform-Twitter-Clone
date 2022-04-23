const portNumber = 8000;
const routes = require('./routes.json');
const fs = require('fs')
const data = require('./data.json');
const bodyParser = require('body-parser')
const jsonServer = require('json-server');
const path = require('path');

const server = jsonServer.create();
const router = jsonServer.router(data);

let nPath = path.normalize( __dirname + '/data.json');
const db = JSON.parse(fs.readFileSync(nPath));

server.use(bodyParser.urlencoded({extended: true}))
server.use(bodyParser.json())
server.use(jsonServer.defaults());


function emailExists(email){
  return db.users.findIndex(user => user.email === email) !== -1;
}
 
server.post('/signup/verify', function (req, res, next) {
  let exists = emailExists(req.body.email);
  res.status(200).json({ "OTP Sent": !exists, "OTP": "1312" });
 
});

function otpExists(otp, email) {
  return db.OTPs.findIndex(val => val.OTP === otp && val.email === email) !== -1;
}
server.get('/signup/confirm_email', function (req, res, next) {
  let otp = req.query.OTP;
  let email = req.query.email;

  if (otpExists(otp, email)) {
    res.status(200).json({
      "200": "Email verified",
      "email": email
    });
  } else {
    res.status(401).json({ "401": "Token expired" });
  }
});

function usernameExists(username){
  return db.users.findIndex(user => user.username === username) !== -1;
}

server.post('/signup', function (req, res, next) {
  if (usernameExists(req.body.username)) {
    res.status(400).json();
  } else {
    res.status(200).json();
  }
});

server.post('/login', function (req, res, next) {
  res.status(200).json({
    "User found": true,
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
    "user_id": "62556148e10c0b48c19d2cb9"
  });

  // res.status(400).json({ "400": "Password doesn't match" });
  // res.status(401).json({ "400": "user not found" });

});


server.use(jsonServer.rewriter(routes));
server.use(router);

server.listen(portNumber, () => {
  console.log("JSON Server is running");


});