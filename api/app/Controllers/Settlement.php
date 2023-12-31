<?php

namespace App\Controllers;

use CodeIgniter\Model;
use CURLFile;
use Unsplash\HttpClient;
use App\Helpers\CSVHelper;

use Mike42\Escpos\Printer;
use Mike42\Escpos\PrintConnectors\WindowsPrintConnector;
use Mike42\Escpos\CapabilityProfile;


class Settlement extends BaseController
{
    function index()
    {
        $q1 = "SELECT t.*, u.name  FROM cso1_transaction as t
        left join cso1_user as u on u.id = t.cashierId
        where t.presence  = 1 and t.locked = 1 and t.settlementId = '' order by t.inputDate DESC";
        $items = $this->db->query($q1)->getResultArray();

        $data = array(
            "error" => false, 
            "items" => $items,
            "printerName" => model("Core")->printer(),
            "total" => (int) model("Core")->select("count(id)", "cso1_transaction", "presence  = 1 and locked = 1 and settlementId = ''"),
        );
        return $this->response->setJSON($data);
    }
    function history()
    {
        $q1 = "SELECT *  FROM cso2_settlement  order by input_date DESC";
        $items = $this->db->query($q1)->getResultArray();

        $data = array(
            "error" => false,
            "items" => $items,
        );
        return $this->response->setJSON($data);
    }
    function print()
    {
        $post = $this->request->getVar();

        if ($post) {
            $q1 = "SELECT *  FROM cso2_settlement  
            where id = '" . $post['id'] . "'";
            $cso2_settlement = $this->db->query($q1)->getResultArray();

            $q2 = "SELECT *  FROM cso2_balance  
            where settlementId = '" . $post['id'] . "' order by input_date ASC";
            $cso2_balance = $this->db->query($q2)->getResultArray();


            $q2 = "SELECT COUNT(id) AS 'total', 
            SUM(total)  AS 'amount', 
            SUM(finalPrice)  AS 'finalPrice',
            SUM(discount)  AS 'discount',
            count(discount)  AS 'totalDiscount'
            
            FROM cso1_transaction WHERE settlementId = '" . $post['id'] . "'  ";
            $transaction = $this->db->query($q2)->getResultArray()[0];

        
            $q3= "SELECT t1.* , n.name
            FROM (
            SELECT p.paymentTypeId, p.paymentNameId, COUNT(p.paymentNameId) AS 'total', SUM(p.amount) AS 'amount'
            FROM cso1_transaction as t 
            LEFT JOIN cso1_transaction_payment AS p ON p.transactionId = t.id
            WHERE t.settlementId = '" . $post['id'] . "'
            GROUP BY p.paymentTypeId, p.paymentNameId
            ) AS t1 
            LEFT JOIN cso1_payment_name AS n ON n.id = t1.paymentNameId
            ";
            $cso1_payment = $this->db->query($q3)->getResultArray();

            $settlementId = $post['id'];

            $date = strtotime(model("Core")->select("input_date", "cso2_settlement", " id = '$settlementId' "));
            $date = date("Y-m-d", $date);

            $data = array(
                "error" => false,
                "post" => $post,
                "transaction" => $transaction,
                "settlement" => $cso2_settlement[0],
                "balance" => $cso2_balance,
                "payment" =>  $cso1_payment,
                "template" => array(
                    "companyName" => model("Core")->select("value", "cso1_account", "name='companyName'"),
                    "companyAddress" => model("Core")->select("value", "cso1_account", "name='companyAddress'"),
                    "companyPhone" => 'Telp : ' . model("Core")->select("value", "cso1_account", "name='companyPhone'"),
                    "footer" => model("Core")->select("value", "cso1_account", "id='1007'"),
                    "brandId" => model("Core")->select("value", "cso1_account", "id='22'"),
                    "outletId" => model("Core")->select("value", "cso1_account", "id='21'"),
                ),
            );
        }
        return $this->response->setJSON($data);
    }



    function onSetSettlement()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) {
            $this->db->transStart();
            $settlementId = $post['terminalId'] . model("Core")->number("settlement");

            $this->db->table("cso1_transaction")->update([
                "settlementId" => $settlementId,
            ], "   presence  = 1 AND locked = 1 AND settlementId = '' ");

            $this->db->table("cso2_balance")->update([
                "settlementId" => $settlementId,
                "close" => 1,
            ], " settlementId = '' and close = 0 ");

            $this->db->table("cso2_settlement")->insert([
                "id" => $settlementId,
                "amount" => model("Core")->select("sum(total)", "cso1_transaction", "settlementId = '$settlementId' "),
                "total" => model("Core")->select("count(id)", "cso1_transaction", "settlementId = '$settlementId' "),
                "input_date" => date("Y-m-d H:i:s")
            ]);


            $q1 = "SELECT *  FROM cso2_settlement  
            where id = '" . $settlementId . "'";
            $cso2_settlement = $this->db->query($q1)->getResultArray();

            $q2 = "SELECT *  FROM cso2_balance  
            where settlementId = '" . $settlementId . "' order by input_date ASC";
            $cso2_balance = $this->db->query($q2)->getResultArray();


            $q2 = "SELECT *  FROM cso1_transaction  
            where settlementId = '" . $settlementId . "' order by input_date ASC";
            $cso1_transaction = $this->db->query($q2)->getResultArray();

            $q2 = "SELECT t.settlementId, d.* FROM cso1_transaction_detail AS d
            LEFT JOIN cso1_transaction AS t ON t.id = d.transactionId
            WHERE t.settlementId =  '" . $settlementId . "'  ORDER BY t.inputDate ASC";
            $cso1_transaction_detail = $this->db->query($q2)->getResultArray();

            $q2 = "SELECT a.* , t.id
            FROM cso1_transaction_payment AS a
            LEFT JOIN cso1_transaction AS t ON t.id = a.transactionId
            WHERE t.settlementId = '" . $settlementId . "';
            ";
            $cso1_transaction_payment = $this->db->query($q2)->getResultArray();

            $date = strtotime(model("Core")->select("input_date", "cso2_settlement", " id = '$settlementId' "));
            $date = date("Y-m-d", $date);

            $csv = array(
                "cso1_transaction" => CSVHelper::arrayToCsv($cso1_transaction, $settlementId . '_pos_transaction', $date),
                "cso1_transaction_detail" => CSVHelper::arrayToCsv($cso1_transaction_detail, $settlementId . '_pos_transaction_detail', $date),
                "cso2_settlement" => CSVHelper::arrayToCsv($cso2_settlement, $settlementId . '_pos_settlement', $date),
                "cso2_balance" => count($cso2_balance) > 0 ? CSVHelper::arrayToCsv($cso2_balance, $settlementId . '_pos_balance', $date) : false,
                "cso1_transaction_payment" => CSVHelper::arrayToCsv($cso1_transaction_payment, $settlementId . '_pos_transaction_payment', $date),

            );

            $this->db->transComplete();



            $data = array(
                "error" => false,
                "id" => $settlementId,
                "post" => $post,
                "transStatus" => $this->db->transStatus(),
                "csv" => $csv,
            );
        }

        return $this->response->setJSON($data);
    }

    function testCSV()
    {
        $data = [
            ['name' => 'Joh2n', 'age' => 230, 'email' => 'john@example.com'],
            ['name' => 'Jane', 'age' => 425, 'email' => 'jane@example.com'],
        ];


        // Memanggil fungsi dari Helper
        $filePath = CSVHelper::arrayToCsv($data, 'data_export');
        $filePath = CSVHelper::arrayToCsv($data, 'data_export2');


        if ($filePath) {
            echo "File CSV berhasil dibuat dan disimpan di: " . $filePath;
        } else {
            echo "Gagal membuat file CSV.";
        }
    }

    function fnOpenCashDrawer()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post && $post['token'] === "8zrGkEgUfVJM9XfUHuvYBMipLHMBEHES6HKkGqytFYq36h67gE") {
            $printer = model("Core")->printer();
            if ($printer != "") {

                $profile = CapabilityProfile::load("simple");
                $connector = new WindowsPrintConnector($printer);
                $printer = new Printer($connector, $profile);
                $printer->text($post['outputPrint']); 
                $printer->pulse();
                $printer->close();
            }

            $data = array(
                "note" => 'success',
                "printer" => $printer,
                "action" => "Cash Drawer"
            );
        }
        return $this->response->setJSON($data);
    }

    function fnPrint()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) { 
            $printer = model("Core")->printer();
            if ($printer != "") { 
                $profile = CapabilityProfile::load("simple");
                $connector = new WindowsPrintConnector($printer);
                $printer = new Printer($connector, $profile); 
                $printer->text($post['outputPrint']); 
                $printer->cut(); 
                $printer->close();
            }
           
            $data = array(
                "note" => 'success',
                "printer" => $printer,
                "post" => $post,
                "action" => "Print, Cut and Cash Drawer"
            );
        }
        return $this->response->setJSON($data);
    }
}