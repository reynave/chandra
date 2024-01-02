<?php

namespace App\Controllers;

use CodeIgniter\Model;
use Unsplash\HttpClient;

class PromoFixed extends BaseController
{
    public function index()
    {
        $q1 = "SELECT * FROM cso1_promo_fixed  
             ORDER BY id ASC";
        $items = $this->db->query($q1)->getResultArray();

        $data = array(
            "error" => false,
            "items" => $items,
        );
        return $this->response->setJSON($data);
    }


    function fnCheck()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) {
            $this->db->table("cso1_promo_fixed")->update([
                "status" => $post['item']['status'],
            ], " id = " . $post['item']['id']);

            $data = array(
                "post" => $post,
            );
        }
        return $this->response->setJSON($data);
    }

    function fnSave()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) {
            foreach ($post['items'] as $row) { 
                $this->db->table("cso1_promo_fixed")->update([
                    "description" => $row['description'],
                    "shortDesc" => $row['shortDesc'],
                    "targetAmount" => $row['targetAmount'],
                    "ifAmountNearTarget" => $row['ifAmountNearTarget'],
                    "isMultiple" => $row['isMultiple'],
                    "voucherAmount" => $row['voucherAmount'],
                     "expDate" => $row['expDate'], 
                ], " id = " . $row['id']);
            }
            $data = array(
                "post" => $post,
            );
        }
        return $this->response->setJSON($data);
    }
}