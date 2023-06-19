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
  socket.on('add user to room', (data) => { 
    console.log(data['userId']);
    socket.join(data['userId']);
  })
  //console.log(socket.id);
  socket.on('order', (data) => {
    console.log(data);
    io.to(1).emit('order', data);
    //io.emit('order', data);
  });

  socket.on('orderApproval', (data) => {
    console.log('approval data: ' + data['userId']);
    io.to(data['userId']).emit('orderApproval', 'The order has been approved');
  });

  socket.on('orderDenied', (data) => { 
    console.log('deny data: ' + data['userId']);
    io.to(data['userId']).emit('orderDenied', 'The order has been denied');
  })

  })


server.listen(3000, () => {
  console.log('listening on *:3001');
});
