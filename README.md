## Installation POS

##### 1. Insall XAMPP and Update PHP.INI (manual and required) 
update PHP.ini 
```
//baris 934
extension=intl

//baris 1180
mysqli.allow_local_infile = On 
 ```
- intl untuk time
- mysqli.allow_local_infile untuk bulk insert / sync txt via webbase

##### 2. Setup driver Printer (manual and required)
link Video : https://youtu.be/vylnDnrB2PA?si=LsA4KMsBccb8FxXg&t=101

- setup printer di control panel
- share printer 

##### 3. Nodejs
1. install nodejs https://nodejs.org/en/, select Recommended For Most Users
2. install pm2 manager https://www.npmjs.com/package/pm2 
```
npm i pm2
pm2 start app.js
```

- nodejs untuk Edisi Mandiri / BCA