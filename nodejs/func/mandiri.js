/**
 * 
 * MANDIRI EDC POS 
 * ver 2.240110
 * 
 */

const { SerialPort } = require('serialport');
var hexa = require('./hexa');
let timeout = 60;

// const com = 'COM8';
// const port = new SerialPort({
//     path: com,
//     baudRate: 9600,
//     autoOpen: false,
// }, (err) => console.log(err));

let header = "\x02";
let version = "\x01";
let TypeTrans;
let SubTypeTrans;

let dataSend = "";
let tagClose = "\x03";
let CRC;

function echoTest(io, msg) {
    let output = {}

    const com = msg['com'];
    const port = new SerialPort({
        path: com,
        baudRate: 9600,
        autoOpen: false,
    }, (err) => console.log(err));

    port.open(function (res) {

        if (res) {
            console.log(res.name, res.message);
            output = {
                name: res.name,
                message: res.message,
            }
            io.emit('emiter', output);
        } else {
            console.log('com8 Open');

            TypeTrans = "\x3B";
            SubTypeTrans = "\x30";
            CRC = "\x09";
            echoTestMandiri = header + version + TypeTrans + SubTypeTrans + dataSend + tagClose + CRC;
            port.write(echoTestMandiri, function (err) {
                if (err) throw err;
            });

            let i = 0;
            let read = "";
            refreshIntervalId = setInterval(function () {
                i++;
                let resp = port.read()?.toString('hex') || '';

                console.log(i, resp, Buffer.from(resp, 'hex').toString('ascii'));
                if (resp) {
                    let string = Buffer.from(resp, 'hex').toString('ascii');
                    let message = hexa.removeSpecialCharactersExcept(string, '|')
                    output = {
                        name: 'Send Done',
                        message: message == "" ? resp : message,
                    }
                    io.emit('emiter', output);
                    port.write('\x06', function (err) {
                        if (err) throw err;
                    });
                    i = 100;
                    console.log(i, "POS kirim ACK (06).");
                }

                if (i > 10) {
                    clearInterval(refreshIntervalId);
                    port.close();
                }

            }, 250);
        }


    });
}

function writeECR(io, msg, data) {
    let output = {}

    const com = msg['com'];
    const port = new SerialPort({
        path: com,
        baudRate: 9600,
        autoOpen: false,
    }, (err) => console.log(err));

    port.open(function (res) {
        if (res) {
            console.log(res.name, res.message);
            output = {
                name: res.name,
                message: res.message,
            }
            io.emit('emiter', output);
        } else {
            console.log('com8 Open');
            output = {
                name: 'Write',
                message: 'SALE ' + data,
            }
            io.emit('emiter', output);

            port.write(data, function (err) {
                if (err) throw err;
            });

            let i = 0;
            let read = "";
            refreshIntervalId = setInterval(function () {
                i++;
                let resp = port.read()?.toString('hex') || '';
                let buffer1 = Buffer.from(resp, 'hex').toString('ascii');

                let string = Buffer.from(resp, 'hex').toString('ascii');
                let strArray = hexa.removeSpecialCharactersExcept(string, '|').split("|")
                let paidAmount = strArray[strArray.length - 1];
                let paidApprovedCode = strArray[strArray.length - 2];
                let paidrRefCode = strArray[strArray.length - 3];
 
              //  console.log(i, resp, ' | buffer1:' + buffer1, ' | paidApprovedCode:' + paidApprovedCode, ' | paidAmount:' + paidAmount);
                if (resp == '06' && paidApprovedCode === undefined) {
                    output = {
                        name: "resp",
                        message: "SUCCESS ACK (06)",
                    }
                    io.emit('emiter', output);

                    console.log(i, "SUCCESS ACK (06)");
                }
                else if (paidApprovedCode !== undefined) {
                    output = {
                        name: "resp",
                        message: hexa.removeSpecialCharactersExcept(string, '|'),
                    }
                    io.emit('emiter', output);
                    console.log(i, resp);
 
                    if (paidApprovedCode.length > 3) {
                        port.write('\x06', function (err) {
                            if (err) throw err;
                        });
                    }

                    i = 10000;
                }

                if (i > 2 * timeout) {
                    clearInterval(refreshIntervalId);
                    port.close();
                }

            }, 500);
        }
    });
}

function sendDataECR() {
    port.open(function (res) {
        if (res) {
            console.log(res.name, res.message);
        } else {
            console.log('com3 Open');
        }

        port.write(sendToEcr['ascii'], function (err) {
            if (err) throw err;
        });

        let read = "";
        refreshIntervalId = setInterval(function () {
            i++;
            let resp = port.read()?.toString('hex') || '';
            console.log(i);
            if (resp) {
                port.write('\x06', function (err) {
                    if (err) throw err;
                });
                let respString = hexToAscii(resp);
                const sendBack = {
                    i: i,
                    hex: resp,
                    ascii: respString,
                    respCode: respString.slice(53, 55),
                    transType: sendToEcr['transType'],
                }
                console.log(i, sendBack, "Port write done");
                sendToEcr['socket'].emit("emiter", sendBack);


                if (sendBack.RespCode == '00') {
                    clearInterval(refreshIntervalId);
                    port.close();
                    console.log("Com Close!");
                }

                if (sendBack.RespCode == 'P3') {
                    clearInterval(refreshIntervalId);
                    port.close();
                    console.log("User press Cancel on EDC, Com Close!");
                }
            }
            if (i > 500) {
                clearInterval(refreshIntervalId);
                port.close();
            }

        }, 250);

    });
}

function clearECR() {
    port.open(function (res) {
        if (res) {
            console.log(res.name, ', opening port: ', res.message);
        } else {
            console.log(com + ' Open');
        }
        for (var i = 0; i <= 10; i++) {
            resp = port.read()?.toString('hex') || '';
            console.log(i, 'ECRClear ', resp);
        }
        console.log("<== END ==>    ");
        port.close();
    });

}

function sendACK(data) {

    port.open(function (res) {
        if (res) {
            console.log(res.name, res.message);
        } else {
            console.log('com8 Open');
        }

        port.write('\x06', function (err) {
            if (err) throw err;
        });
        console.log(0, "MANUAL SEND ACK (06)");

    });
}
module.exports = {
    echoTest,
    writeECR,
    sendDataECR,
    clearECR,
    sendACK
};