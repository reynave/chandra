<?php

namespace App\Controllers;

use CodeIgniter\Model;
use Unsplash\HttpClient;

class Edc extends BaseController
{
    function index()
    {
        $userId = model("Core")->accountId();
        $q1 = "SELECT * FROM cso1_payment_type  
        where  edc = 1 ";
        $items = $this->db->query($q1)->getResultArray();
        $data = array(
            "error" => false,
            "items" => $items,
        );
        return $this->response->setJSON($data);
    }


    function save()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) { 
            $this->db->table("cso1_payment_type")->update([
                "com" => $post['item']['com'],
                "status" => $post['item']['status'],
                
            ], " id = '" . $post['item']['id'] . "'  ");
           
            $data = array(
                "error" => false,
                "post" => $post,
            );
        }

        return $this->response->setJSON($data);
    }

    function onCashIn()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) {
            $this->db->table("cso2_balance")->insert([
                "cashIn" => $post['cashIn'],
                "transactionid" => "_S1",
                "terminalId" => $post['terminalId'],
                "cashierId" => model("Core")->accountId(),
                "input_date" => date("Y-m-d H:i:s")
            ]);

            $data = array(
                "error" => false,
                "post" => $post,
            );
        }

        return $this->response->setJSON($data);
    }
}