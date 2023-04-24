const server = require('http').createServer();
const io = require('socket.io')({ transports: ['websocket'] }).listen(server);

io.on(
    'connection',
    (socket) => {
        socket.on(
            'test_buffer',
            (respondToDevice) => {
                const buffer = Buffer.alloc(1);
                buffer[0] |= 0x01;
                console.log(Boolean(buffer[0]));
                respondToDevice({
                    'hi': buffer,
                })
            }
        );
    }
);

server.listen(3000)
console.log('Server online on port 3000');