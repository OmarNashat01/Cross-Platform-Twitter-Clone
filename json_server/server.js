const portNumber = 8000;
const data = require('./data.json');
const jsonServer = require('json-server');
const routes = require("./routes.json");

const server = jsonServer.create();
const router = jsonServer.router(data);
const middlewares = jsonServer.defaults();

server.use(jsonServer.bodyParser);
server.use(middlewares);


server.post('/signup/verify', function (req, res, next) {
  res.status(200).json({ "OTP Sent": true, "OTP": "1312" });
  // res.status(200).json({ "OTP Sent": false, "OTP": "1312" });
});

server.get('/signup/confirm_email', function (req, res, next) {
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


server.use(jsonServer.rewriter(routes));
server.use(router);

server.listen(portNumber, () => {
  console.log("JSON Server is running");
});