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

    function items()
    {
        $data = array(
            "item" => self::item(),
            "barcode" => self::barcode(), 
        );

        return $this->response->setJSON($data);
    }

    function promo()
    {
        $data = array( 
            "promo_header" => self::promo_header(),
            "promo_detail_item" => self::promo_detail_item(),
            "promo_detail_free" => self::promo_detail_free(),
        );

        return $this->response->setJSON($data);
    }
 
    public function item()
    {
        if ($this->db->simpleQuery("TRUNCATE cso1_item")) {
            $truncate = 'Success!';
        } else {
            $truncate = 'Query failed!';
        }

        $file = 'item.txt';
        $path = $_ENV['SYNC'].'item.txt';
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
            "path"  => $path,
            "fileName" => $file,
            "result" => $rest,
            "totalInsert" => "",
            "lastSycn" =>  date("Y-m-d H:i:s"),
            "inputDate" => time(),
        ]);


        $data = array(
            "error" => false,
            "file" => $file,
            "TRUNCATE" => $truncate,
            "BULK" => $rest,

        );
        return $data;
        
    }
    public function barcode()
    {
        if ($this->db->simpleQuery("TRUNCATE cso1_item_barcode")) {
            $truncate = 'Success!';
        } else {
            $truncate = 'Query failed!';
        }

        $file =  'barcode.txt';
        $path = $_ENV['SYNC'].'barcode.txt';
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
            "path"  => $path,
            "fileName" => $file,
            "result" => $rest,
            "totalInsert" => "",
            "lastSycn" =>  date("Y-m-d H:i:s"),
            "inputDate" => time(),
        ]);


        $data = array(
            "error" => false,
            "file" => $file,
            "TRUNCATE" => $truncate,
            "BULK" => $rest,

        );
        return $data;
    }

    public function promo_header()
    {
        if ($this->db->simpleQuery("TRUNCATE cso1_promotion")) {
            $truncate = 'Success!';
        } else {
            $truncate = 'Query failed!';
        }

        $file = $_ENV['SYNC'].'promo_header.txt';
        $bulk = " LOAD DATA LOCAL INFILE  
        '$file'
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



        $data = array(
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

        $file = $_ENV['SYNC'].'promo_detail.txt';
        $bulk = " LOAD DATA LOCAL INFILE  
        '$file'
        INTO TABLE cso1_promotion_item  
        FIELDS TERMINATED BY '|'  
        LINES TERMINATED BY '\r\n' 
        (`promotionId`,`itemId`,`qtyFrom`,`qtyTo`,`specialPrice`,`disc1`,`disc2`,`disc3`,`discountPrice`,`status`)";

        if ($this->db->simpleQuery($bulk)) {
            $rest = 'Success!';
        } else {
            $rest = 'Query failed!';
        }



        $data = array(
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

        $file = $_ENV['SYNC'].'promo_free.txt';
        $bulk = " LOAD DATA LOCAL INFILE  
        '$file'
        INTO TABLE cso1_promotion_free  
        FIELDS TERMINATED BY '|'  
        LINES TERMINATED BY '\r\n' 
        (`promotionId`,`itemId`,`qty`,`freeItemId`,`freeQty`,`applyMultiply`,`scanFree`,`printOnBill`,`status`)";

        if ($this->db->simpleQuery($bulk)) {
            $rest = 'Success!';
        } else {
            $rest = 'Query failed!';
        }
 

        $data = array(
            "error" => false,
            "file" => $file,
            "TRUNCATE" => $truncate,
            "BULK" => $rest,

        );
        return $data;
    }

    
}