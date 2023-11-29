<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Setup extends CI_Controller
{
	public $mydb = "pos2";

	function mydb()
	{
		//$this->load->database();
		$db = $this->mydb;
		$q = "SELECT COUNT(*) AS 'db'
		FROM information_schema.SCHEMATA
		WHERE SCHEMA_NAME = '$db';";

		if ((int) $this->db->query($q)->result_array()[0]["db"] == 0) {
			$this->db->query("CREATE DATABASE $db");
			$e = 0;
		} else {
			//$this->load->view('step1');
			$e = 1;
		}

		header("Location: ./../?e=$e");
		//$this->load->view('welcome_message');
	}

	function tables()
	{
		$db = $this->mydb;
		// Nama file SQL yang berisi query CREATE TABLE
		$file_path = 'pos_ver2.sql';

		// Membaca isi file SQL
		$sql_content = file_get_contents($file_path);

		// Membuat koneksi ke database (sesuaikan dengan detail database Anda)
		$servername = "localhost";
		$username = "root";
		$password = "";
		$dbname = $db;

		$conn = new mysqli($servername, $username, $password, $dbname);

		// Memeriksa koneksi
		if ($conn->connect_error) {
			die("Connection failed: " . $conn->connect_error);
		}

		// Memecah query berdasarkan titik koma
		$queries = explode(';', $sql_content);
		$i = 1;
		// Menjalankan setiap query
		foreach ($queries as $query) {
			// Menghilangkan spasi ekstra dan baris baru
			$query = trim($query);

			// Menjalankan query jika tidak kosong
			if (!empty($query)) {
				$result = $conn->query($query);

				// Memeriksa hasil query
				if ($result === TRUE) {
					echo $i . " Query berhasil dijalankan  <br>";
				} else {
					echo $i . " Error saat menjalankan query:  " . $conn->error . "<br>";
				}
			}

			$i++;
		}

		// Menutup koneksi
		$conn->close();
		echo "<h3>Berhasil</h3>";
		echo "<h4>Silakan tekan tombol back dibrowser anda.</h4>";
	}

	function env()
	{

		// Nama file .env
		$env_file = './../api/.env';
		$date = date("Y-m-d H:i:s");
		$db = $this->mydb;
		// Data konfigurasi awal
		$env_data = "
# CREATE DATE $date
CI_ENVIRONMENT = production
SECRETKEY = 'hY@xL!l^0A5HAOKBm&cX0YoWjbKpTl6nXea@xKtD4oqktQq7o.GECleklxTCnIIj00Lql3uGT04^eAt#H7fTQ8OF6W^ebpu!CMZb'
SYNC = C:/xampp/htdocs/app/pos2/sync/

# PLEASE INPUT 
api = http://localhost/app/clients/chandra/api/public/ 
server  = http://localhost:7344/app/cso1-api/
socket = http://128.199.94.89:3000


# app.baseURL = ''
database.default.hostname = localhost
database.default.database = $db
database.default.username = root
database.default.password = 
# database.default.DBDriver = MySQLi 
# database.default.port = 3306
		";

		// Membuka file untuk penulisan
		$file_handle = fopen($env_file, 'w');

		// Menulis data konfigurasi ke dalam file
		if ($file_handle) {
			fwrite($file_handle, $env_data);
			fclose($file_handle);
			echo "File .env berhasil dibuat $date .\n";
		} else {
			echo "Gagal membuka file .env untuk penulisan.\n";
		}

	}

}
