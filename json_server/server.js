const portNumber = 8000;
const data = require("./mock_data/users.json");
const routes = require("./routes.json");
const jsonServer = require("json-server");

const server = jsonServer.create();
const router = jsonServer.router(data);
const middlewares = jsonServer.defaults();

server.use(jsonServer.bodyParser);
server.use(middlewares);

// server.post('/users', function (req, res, next) {
//   req.method = 'GET';
//   req.query = req.body;
//   next();
//   console.log(res.);
// });

server.post('/verify', function (req, res, next) {
  res.status(200).json({ "OTP Sent": true, "OTP": "1312" });
});

server.use(jsonServer.rewriter(routes));
server.use(router);

server.listen(portNumber, () => {
  console.log("JSON Server is running");
});