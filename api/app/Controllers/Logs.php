<?php

namespace App\Controllers;

use CodeIgniter\Model;

class Logs extends BaseController
{
    function index()
    {

        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) {
            log_message('debug', "kioskUuid : ".$post['kioskUuid']);

            log_message('debug', $post['note']);

            $data = array(
                "error" => false,
                "post" => $post,
            );
        }

        return $this->response->setJSON($data);


      

    }
}