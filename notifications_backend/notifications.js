const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);

app.get('/', (req, res) => {
  res.send('<h1>Hello world</h1>');
});

io.on('connect', (socket) => {
  console.log('a user conncected');
  socket.on('order', (data) => {
    console.log(data);
    io.emit('order', data);
  });
  })
  

server.listen(3000, () => {
  console.log('listening on *:3000');
});
