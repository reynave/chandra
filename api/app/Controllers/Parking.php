<?php

namespace App\Controllers;

use CodeIgniter\Model;

class Parking extends BaseController
{
    function index()
    {
        $q1 = "SELECT * FROM cso1_kiosk_uuid where presence = 1 order by input_date ASC";
        $items = $this->db->query($q1)->getResultArray();

        $data = array(
            "error" => false,
            "items" =>  $items,
            "parkingTotal" => count($items),
        );
       
        return $this->response->setJSON($data);
    }
 
    function remove()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) {

            $this->db->transStart();
            $this->db->table("cso1_kiosk_cart")->delete([
                "kioskUuid" => $post['kioskUuid'],
            ]);
            $this->db->table("cso1_kiosk_cart_free_item")->delete([
                "kioskUuid" => $post['kioskUuid'],
            ]);
            $this->db->table("cso1_kiosk_paid_pos")->delete([
                "kioskUuid" => $post['kioskUuid'],
            ]); 
            $this->db->table("cso1_kiosk_uuid")->delete([
                "kioskUuid" => $post['kioskUuid'],
            ]); 
            $this->db->transComplete();

            $data = array(
                "transStatus" => $this->db->transStatus(),
                "post" => $post,
            );
        }
        return $this->response->setJSON($data);
    }


  
}