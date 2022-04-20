const portNumber = 8000;
const data = require("./mock_data/users.json");
const routes = require("./routes.json");
const jsonServer = require("json-server");

const server = jsonServer.create();
const router = jsonServer.router(data);
const middlewares = jsonServer.defaults();

server.use(jsonServer.bodyParser);
server.use(middlewares);
server.use(jsonServer.rewriter(routes));
server.use(router);

server.listen(portNumber, () => {
  console.log("JSON Server is running");
});