let header = "\x02";
let version = "\x01";
let TypeTrans;
let SubTypeTrans;

let dataSend = "";
let tagClose = "\x03";
let CRC;
 

function hexToBinary(hex) {
    // Mendapatkan kode karakter dari string
    let charCode = hex.charCodeAt(0);

    // Mengonversi kode karakter menjadi nilai biner
    let binaryValue = charCode.toString(2);

    // Menambahkan padding nol hingga mencapai 8 bit
    let paddedBinary = '0'.repeat(Math.max(8 - binaryValue.length, 0)) + binaryValue;

    return paddedBinary;
}

function xorMultipleBinaries(binaries){
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
   // console.log("xor : ",result);
    
    return Buffer.from(binaryToHex(result), 'hex') ;
}

function binaryToHex(binary){
    // Konversi nilai biner menjadi bilangan bulat
    const decimalValue = parseInt(binary, 2);

    // Konversi bilangan bulat menjadi nilai heksadesimal
   // const hexValue = decimalValue.toString(16).toUpperCase();
    const hexValue = decimalValue.toString(16).toUpperCase().padStart(Math.ceil(binary.length / 4), '0');

    //let binaryValue = hexValue.toString(2);

    // Menambahkan padding nol hingga mencapai 8 bit
   // let paddedBinary = '0'.repeat(Math.max(2 - binaryValue.length, 0)) + binaryValue;
    return hexValue;
}
 
function joinDataBinary(post) {
    const str =  Array.from(post['amount']);
    let data = [];
  
    data.push(hexToBinary(post['version']));
    data.push(hexToBinary(post['TypeTrans']));
    data.push(hexToBinary(post['TypeTransSub']));
    
    str.forEach(el => {
        let a = el.charCodeAt(0).toString(2);
        a = '0'.repeat(Math.max(8 - a.length, 0)) + a;
        data.push(a);
 
    });
    data.push(hexToBinary(post['tagClose']));
    
    return data;
}

function stringToHexa(string){ 
    const str =  Array.from(string);
   
    let data = '';
    str.forEach(el => {
         data += Buffer.from(el, 'utf-8').toString('hex');
    }); 
    return data;
}

function removeSpecialCharactersExcept(inputString, exceptionChar) {
    // Membuat ekspresi reguler dengan karakter yang tidak ingin dihapus
    const regexPattern = new RegExp(`[^\\w\\s${exceptionChar}]`, 'gi');
  
    // Menggunakan ekspresi reguler untuk menyaring karakter khusus
    const cleanString = inputString.replace(regexPattern, '');
  
    return cleanString;
}

module.exports = { 
    hexToBinary,
    xorMultipleBinaries,
    binaryToHex,
    joinDataBinary, 
    stringToHexa,
    removeSpecialCharactersExcept
};