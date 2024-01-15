<?php

namespace App\Controllers;

use CodeIgniter\Model;

class BulkInsert extends BaseController
{
    function index()
    {
        $q1 = "SELECT *, CONVERT_TZ(`lastSycn`,'+00:00','+07:00') AS 'date'
        FROM cso1_sync 
        ORDER BY inputDate DESC limit 30";
        $items = $this->db->query($q1)->getResultArray();
        $data = array(
            "error" => false,
            "items" => $items,
        );
        return $this->response->setJSON($data);
    }

    // function items()
    // {
    //     $data = array(
    //         "item" => self::item(),
    //         "barcode" => self::barcode(),
    //     );

    //     return $this->response->setJSON($data);
    // }

    function items()
    {
        if ($this->db->simpleQuery("TRUNCATE cso1_item")) {
            $truncate = 'Success!';
        } else {
            $truncate = 'Query failed!';
        }

        $file = 'item.txt';
        // $path = $_ENV['SYNC'].'item.txt';
        $path = self::filePath($file);

        $bulk = " LOAD DATA LOCAL INFILE  
        '$path'
        INTO TABLE cso1_item
        FIELDS TERMINATED BY '|'  
        LINES TERMINATED BY '\r\n' 
        (`id`,`description`,`shortDesc`,`price1`,`price2`,`price3`,`price4`,`price5`,`price6`,`price7`,`price8`,`price9`,`price10`,
        `itemUomId`,`itemCategoryId`,`itemTaxId`,`images`)";


        if ($this->db->simpleQuery($bulk)) {
            $rest = 'Success!';
        } else {
            $rest = 'Query failed!';
        }
        $this->db->table("cso1_sync")->insert([
            "path" => $path,
            "fileName" => $file,
            "result" => $rest,
            "totalInsert" => "",
            "lastSycn" => date("Y-m-d H:i:s"),
            "inputDate" => time(),
        ]);


        $data = [];
        $data[] = array(
            "id" => model("Core")->select("id", "cso1_sync", " fileName = '$file' order by inputDate DESC"),
            "error" => false,
            "file" => $file,
            "TRUNCATE" => $truncate,
            "BULK" => $rest,

        );
        return $this->response->setJSON($data);
    }

    function barcode()
    {
        if ($this->db->simpleQuery("TRUNCATE cso1_item_barcode")) {
            $truncate = 'Success!';
        } else {
            $truncate = 'Query failed!';
        }

        $file = 'barcode.txt';
        $path = self::filePath($file);
        $bulk = " LOAD DATA LOCAL INFILE  
        '$path'
        INTO TABLE cso1_item_barcode  
        FIELDS TERMINATED BY '|'  
        LINES TERMINATED BY '\r\n' 
        (`itemId`,`barcode`)";

        if ($this->db->simpleQuery($bulk)) {
            $rest = 'Success!';
        } else {
            $rest = 'Query failed!';
        }
        $this->db->table("cso1_sync")->insert([
            "path" => $path,
            "fileName" => $file,
            "result" => $rest,
            "totalInsert" => "",
            "lastSycn" => date("Y-m-d H:i:s"),
            "inputDate" => time(),
        ]);

        $data = [];
        $data[] = array(
            "id" => model("Core")->select("id", "cso1_sync", " fileName = '$file' order by inputDate DESC"),
            "error" => false,
            "file" => $file,
            "TRUNCATE" => $truncate,
            "BULK" => $rest,

        );

        return $this->response->setJSON($data);
    }

    function promo()
    {

        $this->db->simpleQuery("TRUNCATE cso1_promotion");
        $this->db->simpleQuery("TRUNCATE cso1_promotion_item");
        $this->db->simpleQuery("TRUNCATE cso1_promotion_free");


        $data = [];
        $data[] = self::promo_header();
        $data[] = self::promo_detail_item();
        $data[] = self::promo_detail_free();

        return $this->response->setJSON($data);
    }

    public function promo_header()
    {
        if ($this->db->simpleQuery("TRUNCATE cso1_promotion")) {
            $truncate = 'Success!';
        } else {
            $truncate = 'Query failed!';
        }

        $file = 'promo_header.txt';
        $path = self::filePath($file);

        $bulk = " LOAD DATA LOCAL INFILE  
        '$path'
        INTO TABLE cso1_promotion  
        FIELDS TERMINATED BY '|'  
        LINES TERMINATED BY '\r\n' 
        (`id`,`typeOfPromotion`,`storeOutlesId`,`code`,`description`,`startDate`,`endDate`, `discountPercent`,`discountAmount`,`status`,
        `Mon`,`Tue`,`Wed`,`Thu`,`Fri`,`Sat`,`Sun`)";

        if ($this->db->simpleQuery($bulk)) {
            $rest = 'Success!';
        } else {
            $rest = 'Query failed!';
        }
        $this->db->table("cso1_sync")->insert([

            "path" => $path,
            "fileName" => $file,
            "result" => $rest,
            "totalInsert" => "",
            "lastSycn" => date("Y-m-d H:i:s"),
            "inputDate" => time(),
        ]);


        $data = array(
            "id" => model("Core")->select("id", "cso1_sync", " fileName = '$file' order by inputDate DESC"),
            "error" => false,
            "file" => $file,
            "TRUNCATE" => $truncate,
            "BULK" => $rest,

        );
        return $data;
    }

    public function promo_detail_item()
    {
        if ($this->db->simpleQuery("TRUNCATE cso1_promotion_item")) {
            $truncate = 'Success!';
        } else {
            $truncate = 'Query failed!';
        }


        $file = 'promo_detail.txt';
        $path = self::filePath($file);


        $bulk = " LOAD DATA LOCAL INFILE  
        '$path'
        INTO TABLE cso1_promotion_item  
        FIELDS TERMINATED BY '|'  
        LINES TERMINATED BY '\r\n' 
        (`promotionId`,`itemId`,`qtyFrom`,`qtyTo`,`specialPrice`,`disc1`,`disc2`,`disc3`,`discountPrice`,`status`)";

        if ($this->db->simpleQuery($bulk)) {
            $rest = 'Success!';
        } else {
            $rest = 'Query failed!';
        }
        $this->db->table("cso1_sync")->insert([
            "path" => $path,
            "fileName" => $file,
            "result" => $rest,
            "totalInsert" => "",
            "lastSycn" => date("Y-m-d H:i:s"),
            "inputDate" => time(),
        ]);


        $data = array(
            "id" => model("Core")->select("id", "cso1_sync", " fileName = '$file' order by inputDate DESC"),
            "error" => false,
            "file" => $file,
            "TRUNCATE" => $truncate,
            "BULK" => $rest,

        );
        return $data;
    }

    public function promo_detail_free()
    {
        if ($this->db->simpleQuery("TRUNCATE cso1_promotion_free")) {
            $truncate = 'Success!';
        } else {
            $truncate = 'Query failed!';
        }

        // $file = $_ENV['SYNC'] . 'promo_free.txt';
        $file = 'promo_free.txt';
        $path = self::filePath($file);

        $bulk = " LOAD DATA LOCAL INFILE  
        '$path'
        INTO TABLE cso1_promotion_free  
        FIELDS TERMINATED BY '|'  
        LINES TERMINATED BY '\r\n' 
        (`promotionId`,`itemId`,`qty`,`freeItemId`,`freeQty`,`applyMultiply`,`scanFree`,`printOnBill`,`status`)";

        if ($this->db->simpleQuery($bulk)) {
            $rest = 'Success!';
        } else {
            $rest = 'Query failed!';
        }
        $this->db->table("cso1_sync")->insert([

            "path" => $path,
            "fileName" => $file,
            "result" => $rest,
            "totalInsert" => "",
            "lastSycn" => date("Y-m-d H:i:s"),
            "inputDate" => time(),
        ]);

        $data = array(
            "id" => model("Core")->select("id", "cso1_sync", " fileName = '$file' order by inputDate DESC"),
            "error" => false,
            "file" => $file,
            "TRUNCATE" => $truncate,
            "BULK" => $rest,

        );
        return $data;
    }

    function onSyncVoucher()
    {
        $data = array(
            "server" => $_ENV['server'],
        );


        // URL file yang akan diunduh
        $fileUrl = $_ENV['server'] . 'uploads/voucher/V000017.txt';

        // Nama file untuk menyimpan hasil unduhan
        $localFile = './../../sync/voucher/V000017.txt';

        // Inisialisasi cURL
        $ch = curl_init($fileUrl);

        // Menentukan opsi cURL
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        // Melakukan request untuk mengunduh file
        $fileContent = curl_exec($ch);

        // Menutup koneksi cURL
        curl_close($ch);

        // Menyimpan hasil unduhan ke dalam file lokal
        file_put_contents($localFile, $fileContent);

        $data = array(
            "error" => false,
            "respons" => "File berhasil diunduh dan disimpan dalam $localFile",
        );


        return $this->response->setJSON($data);
    }

    function dir()
    {
        echo __DIR__;
    }
    function member()
    {
        if ($this->db->simpleQuery("TRUNCATE cso2_member")) {
            $truncate = 'Success!';
        } else {
            $truncate = 'Query failed!';
        }


        $file = 'KMEMBER.txt';
        $path = self::filePath($file);

        $bulk = " LOAD DATA LOCAL INFILE  
        '$path'
        INTO TABLE cso2_member  
        FIELDS TERMINATED BY '|'  
        LINES TERMINATED BY '\r\n' 
        (`id`,`name`,`status`,`expDate`)";

        if ($this->db->simpleQuery($bulk)) {
            $rest = 'Success!';
        } else {
            $rest = 'Query failed!';
        }
        $this->db->table("cso1_sync")->insert([
            "path" => $path,
            "fileName" => $file,
            "result" => $rest,
            "totalInsert" => "",
            "lastSycn" => date("Y-m-d H:i:s"),
            "inputDate" => time(),
        ]);


        $data = [];
        $data[] = array(
            "id" => model("Core")->select("id", "cso1_sync", " fileName = '$file' order by inputDate DESC"),
            "error" => false,
            "file" => $file,
            "TRUNCATE" => $truncate,
            "BULK" => $rest,

        );
        return $this->response->setJSON($data);


    }


    function filePath($filename)
    {
        $absolutePath = str_replace("api\public\\", "", FCPATH);
        $path = $absolutePath . 'sync\\' . $filename;
        $path = str_replace(DIRECTORY_SEPARATOR, '/', $path);

        return $path;
    }

    function updateTimer()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) {
            foreach ($post['data'] as $row) {
                $this->db->table("cso1_sync")->update([
                    "totalTime" => $post['t'],
                ], " id = " . $row['id']);
            }

            $data = array(
                "error" => false,
                "post" => $post,
            );
            return $this->response->setJSON($data);
        }
    }
}