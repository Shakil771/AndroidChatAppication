const socketIo = require('socket.io');

const initializeSocket = (server) => {
  const io = socketIo(server);

  io.on('connection', (socket) => {
    console.log('A user connected');

    socket.on('offer', (data) => {
      socket.broadcast.emit('offer', data);
    });

    socket.on('answer', (data) => {
      socket.broadcast.emit('answer', data);
    });

    socket.on('candidate', (data) => {
      socket.broadcast.emit('candidate', data);
    });

    socket.on('disconnect', () => {
      console.log('A user disconnected');
    });
  });
};

module.exports = initializeSocket;