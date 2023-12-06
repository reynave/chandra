<?php

namespace App\Controllers;

use CodeIgniter\Model;
use Unsplash\HttpClient;

class Configuration extends BaseController
{
    public function index()
    {
        $q1 = "SELECT * FROM cso1_account  
        where  id > 9 order by id ASC";
        $items = $this->db->query($q1)->getResultArray();
        $data = array(
            "error" => false,
            "items" => $items,
        );
        return $this->response->setJSON($data);
    }


    function onUpdate()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) {
            foreach ($post as $row) {
                $this->db->table("cso1_account")->update([
                    "value" => $row['value'],
                    "updateDate" => time(),
                ]," id = ".$row['id']);
            }

            $data = array(
                "error" => false,
                "post" => $post,
            );
        }

        return $this->response->setJSON($data);
    }
}