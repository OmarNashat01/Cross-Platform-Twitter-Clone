const portNumber = 8000;
const data = require('./data.json');
const jsonServer = require('json-server');
const routes = require('./routes.json');


const bodyParser = require('body-parser');

const server = jsonServer.create();
const router = jsonServer.router(data);
const middlewares = jsonServer.defaults();


server.use(jsonServer.bodyParser);
server.use(middlewares);


server.post('/signup/verify', function (req, res, next) {
  res.status(200).json({ "OTP Sent": true, "OTP": "1312" });
  // res.status(200).json({ "OTP Sent": false, "OTP": "1312" });
});

server.get('/signup/confirm_email', function (req, res, next)
{
  res.status(200).json({
    "200": "Email verified",
    "email": "mohamedmohsen96661@gmail.com"
  });

  // res.status(401).json({ "401": "Token expired" });
});

server.post('/signup', function (req, res, next) {
  // res.status(200).json();
  res.status(400).json();
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