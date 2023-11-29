<?php

namespace App\Controllers;

use CodeIgniter\Model;
use Unsplash\HttpClient;

class Env extends BaseController
{
    public function index()
    { 
        $this->response->setHeader('Content-Type', 'application/javascript');
       // header('Content-Type: application/javascript');
       // $this->render('header');
        $data = array(
            "api" => $_ENV["api"],
            "server"   => $_ENV["server"],
            "socket_url" => $_ENV["socket"],
        );

        echo "const  api = '". $data['api']."'; \n";
        echo "const  server = '". $data['server']."'; \n";
        echo "const  socket_url = '". $data['socket_url']."'; \n";

       // return $this->response->setJSON($data);
    }  
}