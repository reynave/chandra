## Installation POS 
#### Doc versi Win10

*Sangat disarankan install dengan **git cmd**  untuk memudahkan update version*
https://gitforwindows.org/

####  1. Insall XAMPP and Update PHP.INI (manual and required) 
update PHP.ini 
```
//baris 934
extension=intl

//baris 1180
mysqli.allow_local_infile = On 
 ```
- intl untuk time
- mysqli.allow_local_infile untuk bulk insert / sync txt via webbase

####  2. Setup driver Printer (manual and required)
link Video : https://youtu.be/vylnDnrB2PA?si=LsA4KMsBccb8FxXg&t=101

- setup printer di control panel
- share printer 

####  3. Nodejs
1. install nodejs https://nodejs.org/en/, select Recommended For Most Users
2. install pm2 manager https://www.npmjs.com/package/pm2 
```
npm i pm2
pm2 start app.js
```

- nodejs untuk Edisi Mandiri / BCA

####  4. Install via browser
1.  https://localhost/[your_folder]/install
 


Credit 
- ICON with https://icons8.com/icons/pulsar-color 