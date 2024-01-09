const { SerialPort } = require('serialport');
const com = 'COM8';
const port = new SerialPort({
    path: com,
    baudRate: 9600,
    autoOpen: false,
}, (err) => console.log(err));


let header = "\x02";
let version = "\x01";
let TypeTrans;
let SubTypeTrans;

let dataSend = "";
let tagClose = "\x03";
let CRC;


let echoTestMandiri;

const hexData = Buffer.from("1", 'utf-8').toString('hex');
//console.log('\x31 \x06 06 ', hexData , hexToBinary(hexData)); 
 
 
let a = convertToArrayHexa('000000005000'+'000000000000');
 
const newXor = xorMultipleBinaries(a);
console.log(a, newXor, binaryToHex(newXor));

function convertToArrayHexa(string){
    const str =  Array.from(string);
    let data = [];
 
    data.push(hexToBinary(version));
    
    str.forEach(el => {
        let a = el.charCodeAt(0).toString(2);
        a = '0'.repeat(Math.max(8 - a.length, 0)) + a;
        data.push( a);
 
    });
    data.push(hexToBinary(tagClose));
    
    return data;
}

 
//writeECR();
//echoTest()
// clearECR();



function echoTest() {
    port.open(function (res) {
        if (res) {
            console.log(res.name, res.message);
        } else {
            console.log('com8 Open');
        }
        TypeTrans = "\x3B";
        SubTypeTrans = "\x30";
        CRC = "\x09";
        echoTestMandiri = headerVersion + TypeTrans + SubTypeTrans + dataSend + tagClose + CRC;
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

    });
} 

function writeECR() {
    port.open(function (res) {
        if (res) {
            console.log(res.name, res.message);
        } else {
            console.log('com8 Open');
        }
        TypeTrans = "\x31";
        SubTypeTrans = "\x30";
        CRC = "\x09";


        let data1 = Buffer.from("000000005002", 'utf-8').toString('hex');
        let data2 = Buffer.from("000000000000", 'utf-8').toString('hex');

        dataSend = data1 + data2
        echoTestMandiri = headerVersion + TypeTrans + SubTypeTrans + dataSend + tagClose + CRC;
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
        for (var i = 0; i <= 2; i++) {
            resp = port.read()?.toString('hex') || '';
            console.log(i, 'ECRClear ', resp);
        }
        console.log("<== END ==>    ");
    });

}

function hexToBinary(hex) {
    // Mendapatkan kode karakter dari string
    let charCode = hex.charCodeAt(0);

    // Mengonversi kode karakter menjadi nilai biner
    let binaryValue = charCode.toString(2);

    // Menambahkan padding nol hingga mencapai 8 bit
    let paddedBinary = '0'.repeat(Math.max(8 - binaryValue.length, 0)) + binaryValue;

    return paddedBinary;
}

function xorMultipleBinaries(binaries) {
    // Pastikan semua bilangan memiliki panjang yang sama
    const maxLength = Math.max(...binaries.map(binary => binary.length));

    const paddedBinaries = binaries.map(binary => {
        while (binary.length < maxLength) {
            binary = '0' + binary;
        }
        return binary;
    });

    let result = '';
    for (let i = 0; i < maxLength; i++) {
        const bitValues = paddedBinaries.map(binary => binary[i]);
        const xorResult = bitValues.reduce((accumulator, currentValue) => accumulator ^ currentValue);
        result += xorResult;
    }

    return result;
}

function binaryToHex(binary) {
    // Konversi nilai biner menjadi bilangan bulat
    const decimalValue = parseInt(binary, 2);

    // Konversi bilangan bulat menjadi nilai heksadesimal
    const hexValue = decimalValue.toString(16).toUpperCase();
    let binaryValue = hexValue.toString(2);

    // Menambahkan padding nol hingga mencapai 8 bit
    let paddedBinary = '0'.repeat(Math.max(2 - binaryValue.length, 0)) + binaryValue;
    return paddedBinary;
}
