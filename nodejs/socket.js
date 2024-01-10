require('dotenv').config();
const app = require('express')();
const http = require('http').Server(app);
const io = require('socket.io')(http);
const port = process.env.PORT || process.env.PORT_LOCAL;
const ip = process.env.IP;
 
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

io.on('connection', (socket) => {
    console.log('a user connected');
    socket.on('disconnect', () => {
        console.log('user disconnected');
    });
    socket.on('data', (msg) => {
        console.log('message: ', msg);
        io.emit('emiter', msg);
    });
});


http.listen(port, () => {  
    console.log(`Socket.IO server running at http://${ip}:${port}/`);
});