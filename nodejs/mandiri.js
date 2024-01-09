const { SerialPort } = require('serialport');
var hexa = require('./func/hexa');
var edc = require('./func/edc');

const com = 'COM8';
const port = new SerialPort({
    path: com,
    baudRate: 9600,
    autoOpen: false,
}, (err) => console.log(err));



ecrMandiri();

function ecrMandiri() {
    // console.log('|\x02 \x01 | \x31');
    let header = "\x02";
    let version = "\x01";
    let TypeTrans = "\x31";
    let TypeTransSub = "\x30";
    let amount = '000000000535';
    let tagClose = "\x03";
    const send = { 
        version: version,
        TypeTrans: TypeTrans,
        TypeTransSub: TypeTransSub,
        amount : amount,
        tagClose : tagClose
    }
    //  let TypeTrans = Buffer.from("1", 'utf-8').toString('hex')+Buffer.from("0", 'utf-8').toString('hex');

   

  
    let a = hexa.joinDataBinary(send);
    
   // console.log(hexa.stringToHexa(amount))
    let CRC = hexa.xorMultipleBinaries(a);

    //  let dataTest = "000000000125";


    let posEDC = header + version + TypeTrans + TypeTransSub + amount + tagClose+   Buffer.from(CRC.replace(/\s/g, ''), 'hex');;
    //   let posEDC = header + version + TypeTrans + TypeTransSub + amount + tagClose +"\x05";

    console.log('posEDC',posEDC );
     edc.writeECR(posEDC);
    //  edc.clearECR();
}

//writeECR();
//edc.echoTest();
// clearECR();



// function echoTest() {
//     port.open(function (res) {
//         if (res) {
//             console.log(res.name, res.message);
//         } else {
//             console.log('com8 Open');
//         }
//         TypeTrans = "\x3B";
//         SubTypeTrans = "\x30";
//         CRC = "\x09";
//         echoTestMandiri = headerVersion + TypeTrans + SubTypeTrans + dataSend + tagClose + CRC;
//         port.write(echoTestMandiri, function (err) {
//             if (err) throw err;
//         });

//         let i = 0;
//         let read = "";
//         refreshIntervalId = setInterval(function () {
//             i++;
//             let resp = port.read()?.toString('hex') || '';

//             console.log(i, resp, Buffer.from(resp, 'hex').toString('ascii'));
//             if (resp) {
//                 port.write('\x06', function (err) {
//                     if (err) throw err;
//                 });
//                 i = 100;
//                 console.log(i, "POS kirim ACK (06).");
//             }

//             if (i > 10) {
//                 clearInterval(refreshIntervalId);
//                 port.close();
//             }

//         }, 250);

//     });
// }

// function writeECR() {
//     port.open(function (res) {
//         if (res) {
//             console.log(res.name, res.message);
//         } else {
//             console.log('com8 Open');
//         }
//         TypeTrans = "\x31";
//         SubTypeTrans = "\x30";
//         CRC = "\x09";


//         let data1 = Buffer.from("000000005002", 'utf-8').toString('hex');
//         let data2 = Buffer.from("000000000000", 'utf-8').toString('hex');

//         dataSend = data1 + data2
//         echoTestMandiri = headerVersion + TypeTrans + SubTypeTrans + dataSend + tagClose + CRC;
//         port.write(echoTestMandiri, function (err) {
//             if (err) throw err;
//         });

//         let i = 0;
//         let read = "";
//         refreshIntervalId = setInterval(function () {
//             i++;
//             let resp = port.read()?.toString('hex') || '';

//             console.log(i, resp, Buffer.from(resp, 'hex').toString('ascii'));
//             if (resp) {
//                 port.write('\x06', function (err) {
//                     if (err) throw err;
//                 });
//                 i = 100;
//                 console.log(i, "POS kirim ACK (06).");
//             }

//             if (i > 10) {
//                 clearInterval(refreshIntervalId);
//                 port.close();
//             }

//         }, 250);

//     });
// }

// function sendDataECR() {
//     port.open(function (res) {
//         if (res) {
//             console.log(res.name, res.message);
//         } else {
//             console.log('com3 Open');
//         }

//         port.write(sendToEcr['ascii'], function (err) {
//             if (err) throw err;
//         });

//         let read = "";
//         refreshIntervalId = setInterval(function () {
//             i++;
//             let resp = port.read()?.toString('hex') || '';
//             console.log(i);
//             if (resp) {
//                 port.write('\x06', function (err) {
//                     if (err) throw err;
//                 });
//                 let respString = hexToAscii(resp);
//                 const sendBack = {
//                     i: i,
//                     hex: resp,
//                     ascii: respString,
//                     respCode: respString.slice(53, 55),
//                     transType: sendToEcr['transType'],
//                 }
//                 console.log(i, sendBack, "Port write done");
//                 sendToEcr['socket'].emit("emiter", sendBack);


//                 if (sendBack.RespCode == '00') {
//                     clearInterval(refreshIntervalId);
//                     port.close();
//                     console.log("Com Close!");
//                 }

//                 if (sendBack.RespCode == 'P3') {
//                     clearInterval(refreshIntervalId);
//                     port.close();
//                     console.log("User press Cancel on EDC, Com Close!");
//                 }
//             }
//             if (i > 500) {
//                 clearInterval(refreshIntervalId);
//                 port.close();
//             }

//         }, 250);

//     });
// }

// function clearECR() {
//     port.open(function (res) {
//         if (res) {
//             console.log(res.name, ', opening port: ', res.message);
//         } else {
//             console.log(com + ' Open');
//         }
//         for (var i = 0; i <= 2; i++) {
//             resp = port.read()?.toString('hex') || '';
//             console.log(i, 'ECRClear ', resp);
//         }
//         console.log("<== END ==>    ");
//     });

// }
