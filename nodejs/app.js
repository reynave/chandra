
require('dotenv').config();
const app = require('express')();
const http = require('http').Server(app);
const io = require('socket.io')(http);
const { SerialPort } = require('serialport');
const { Buffer } = require('node:buffer');
const port = process.env.PORT || process.env.PORT_LOCAL;
const ip = process.env.IP;


var hexa = require('./func/hexa');
var edc = require('./func/edc');

// const com = 'COM8';
// const port = new SerialPort({
//     path: com,
//     baudRate: 9600,
//     autoOpen: false,
// }, (err) => console.log(err));
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});


io.on('connection', (socket) => {
    console.log('a user connected');
    socket.on('disconnect', () => {
        console.log('user disconnected');
    });
    socket.on('data', (msg) => {
       // console.log('message: ', msg);
       
        if(msg.action =='echoTest'){
            console.log("echoTest");
            edc.echoTest(io);
        }else{
            io.emit('emiter', msg);
        }
 
      
    });
});


http.listen(port, () => {  
    console.log(`Socket.IO server running at http://${ip}:${port}/`);
});

//ecrMandiri();
//test();
function test() {
    let hexaData = "02013130303037383130333637377c37313436383033313135337c4c494e4b204f6666555320202020207c3533303739352a2a2a2a2a2a343936387c4449507c53414c457c3030303034377c3030303133347c3130204a616e20323032347c31333a30373a32387c3430313031333135373834377c3133303732387c3136037d";

    let resp = hexaData.toString('hex') || '';
    let string = Buffer.from(resp, 'hex').toString('ascii');
    let strArray = hexa.removeSpecialCharactersExcept(string, '|').split("|")
    let paidAmount = strArray[strArray.length - 1];
    let paidApprovedCode = strArray[strArray.length - 2];
    let paidrRefCode = strArray[strArray.length - 3];

    console.log(paidAmount, paidApprovedCode, paidrRefCode);
}

function ecrMandiri() {
    // console.log('|\x02 \x01 | \x31');

    let header = "\x02";
    let version = "\x01";
    let TypeTrans = "\x31";
    let TypeTransSub = "\x30";
    let amount = '000000000023';
    let tagClose = "\x03";
    const send = {
        version: version,
        TypeTrans: TypeTrans,
        TypeTransSub: TypeTransSub,
        amount: amount,
        tagClose: tagClose
    } 
    let a = hexa.joinDataBinary(send); 
    let CRC = hexa.xorMultipleBinaries(a);

    //  let dataTest = "000000000125"; 
    //  let posEDC = header + version + TypeTrans + TypeTransSub + amount + tagClose + "\x02";

    let posEDC = header + version + TypeTrans + TypeTransSub + amount + tagClose + CRC;

    console.log('posEDC', CRC, posEDC, hexa.binaryToHex(CRC), hexa.binaryToHex(CRC).toString('hex'));

    //  edc.writeECR(posEDC);
    //  edc.clearECR();
    //  edc.sendACK();

}
 