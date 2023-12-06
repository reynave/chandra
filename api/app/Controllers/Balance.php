<?php

namespace App\Controllers;

use CodeIgniter\Model;
use Unsplash\HttpClient;

use Mike42\Escpos\Printer;
use Mike42\Escpos\PrintConnectors\WindowsPrintConnector;
use Mike42\Escpos\CapabilityProfile;

class Balance extends BaseController
{
    public function index()
    {
        $q1 = "SELECT * FROM cso2_balance  
        where  close = 0 order by input_date ASC";
        $items = $this->db->query($q1)->getResultArray(); 
        $data = array(
            "error" => false,
            "items" => $items,
            "total" => model("Core")->select("count(id)","cso2_balance","close = 0"),
            "cashIn" => model("Core")->select("SUM(cashIn)","cso2_balance","close = 0"),
            "cashOut" => model("Core")->select("SUM(cashOut)","cso2_balance","close = 0"),
            "startBalance" => model("Core")->select("cashIn","cso2_balance","close = 0 and transactionId = '_S1' "),
            "startDate" =>  model("Core")->select("input_date","cso2_balance","close = 0 and transactionId = '_S1' "),
            
        );
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
                "printer" => model("Core")->printer(),
            );
        }

        return $this->response->setJSON($data);
    }

    function fnOpenCashDrawer()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post && $post['token'] == 'YbgQmalu1sr9LmoOKJmy2BeI3vy70CV2RKg8thPw3I4TxXhlwg') {
            
            if(model("Core")->printer() != "" ){
                $profile = CapabilityProfile::load("simple");
                $connector = new WindowsPrintConnector(model("Core")->printer());
                $printer = new Printer($connector, $profile); 
                $printer->pulse();
                $printer->close();
            }
         
            $data = array(
                "error" => false, 
                "printer" => model("Core")->printer(),
            );
        }

        return $this->response->setJSON($data);
    }
}