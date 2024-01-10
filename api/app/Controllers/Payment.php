<?php

namespace App\Controllers;

use CodeIgniter\Model;

use Mike42\Escpos\Printer;
use Mike42\Escpos\PrintConnectors\WindowsPrintConnector;
use Mike42\Escpos\CapabilityProfile;

class Payment extends BaseController
{
    function method()
    {
        $q1 = "SELECT *, id as 'paymentTypeId' 
        FROM cso1_payment_type 
        WHERE status = 1 
        ORDER BY label ASC";
        $items = $this->db->query($q1)->getResultArray();


        $q2 = "SELECT * 
        FROM cso1_payment_name 
        WHERE status = 1 
        ORDER BY id ASC";
        $paymentName = $this->db->query($q2)->getResultArray();

        $q2 = "SELECT * 
        FROM cso1_payment_type
        WHERE status = 1 and edc = 1
        ORDER BY id ASC";
        $edc = $this->db->query($q2)->getResultArray();

        $data = array(
            "error" => false,
            "items" => $items,
            "edc" => $edc,
            "paymentName" => $paymentName,
        );

        return $this->response->setJSON($data);
    }

    function invoice()
    {
        $kioskUuid = $this->request->getVar()['kioskUuid'];

        $q1 = "SELECT a.* , p.name, p.label, a.voucherNumber
        FROM cso1_kiosk_paid_pos AS a
        LEFT JOIN cso1_payment_type AS p ON p.id = a.paymentTypeId
        WHERE a.kioskUuid = '$kioskUuid' ";
        $kioskPaid = $this->db->query($q1)->getResultArray();
        $i = 0;
        foreach( $kioskPaid  as $row ){
            $kioskPaid[$i]['paymentName'] =  model("Core")->select("name","cso1_payment_name","id = '". $row['paymentNameId']."' ");
            $i++;
        }


        $bill = (int) model("Core")->select("sum(price)", "cso1_kiosk_cart", "kioskUuid = '$kioskUuid' and presence = 1");
        $bill = $bill < 0 ? 1 : $bill;
        $paid = (int) model("Core")->select("sum(paid)", "cso1_kiosk_paid_pos", "kioskUuid = '$kioskUuid'");
        $data = array(
            "error" => false,
            "total" => array(
                "bill" => $bill,
                "remaining" => $bill - $paid,
                "paid" => $paid,
            ),
            "close" => $bill - $paid <= 0 ? true : false,
            "kioskPaid" => $kioskPaid,
        );
        $data["promoFixed"] = [
            "freeParking" => model("Promo")->freeParking($data['total']['bill']),
            "voucher" => model("Promo")->voucher($data['total']['bill']),
            "voucherDiscount" => model("Promo")->voucherDiscount($data['total']['bill']),
            "luckyDip" => model("Promo")->luckyDip($data['total']['bill']),

        ];
        return $this->response->setJSON($data);
    }

    function onSubmitPayment()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) {
            $paid = $post['payment']['amount'] - $post['changes'];
            $this->db->table("cso1_kiosk_paid_pos")->insert([
                "kioskUuid" => $post['kioskUuid'],
                "paid" => $paid,
                "paymentTypeId" => $post['paymentMethodDetail']['paymentTypeId'],
                "cardId" => $post['payment']['cardId'],
                "approvedCode" => $post['approvedCode'],
                "paymentNameId" => isset($post['paymentNameId']) ? $post['paymentNameId'] : '',
                "input_date" => date("Y-m-d H:i:s")
            ]);

            if ($post['paymentMethodDetail']['paymentTypeId'] == 'CASH') {
                $this->db->table("cso2_balance")->insert([
                    "cashIn" => $post['payment']['amount'],
                    "cashOut" => -1 * (int) $post['changes'],
                    "kioskUuid" => $post['kioskUuid'],
                    "terminalId" => $post['terminalId'],
                    "cashierId" => model("Core")->accountId(),
                    "input_date" => date("Y-m-d H:i:s"), 
                ]);
            }
            $this->db->table("cso1_kiosk_uuid")->update([
                "ilock" => 1,
                "update_date" => date("Y-m-d H:i:s"),
            ], "  kioskUuid =  '" . $post['kioskUuid'] . "' ");


            $data = array(
                "error" => false,
                "post" => $post,
            );
        }
        return $this->response->setJSON($data);
    }
 
    function onSubmitDiscountBill()
    {
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
        );
        if ($post) {
            $paid = $post['amount'];
            $this->db->table("cso1_kiosk_paid_pos")->insert([
                "kioskUuid" => $post['kioskUuid'],
                "paid" => $paid,
                "paymentTypeId" => 'DISC.BILL', 
                "input_date" => date("Y-m-d H:i:s"),
                "update_date" => date("Y-m-d H:i:s"), 
            ]);
  

            $data = array(
                "error" => false,
                "post" => $post,
            );
        }
        return $this->response->setJSON($data);
    }
 

    function isCloseTransaction()
    {
        $get = $this->request->getVar();
        $kioskUuid = $get['kioskUuid'];


        $paid = (int) model("Core")->select("sum(paid)", "cso1_kiosk_paid_pos", "kioskUuid = '$kioskUuid'");
        $invoiced = (int) model("Core")->select("sum(price)", "cso1_kiosk_cart", "kioskUuid = '$kioskUuid' and presence = 1");
        $invoiced = $invoiced < 0 ? 1 : $invoiced;

        $closed = ($invoiced - $paid) <= 0 ? true : false;
        $summary = [];

        $summary = model("Core")->summary($kioskUuid);
        $finalPrice = (int) $summary['final'];
        //&& $finalPrice > 0
        if ($closed == true && !model("Core")->select("id", "cso1_transaction", "kioskUuid = '$kioskUuid' ")) {

            $this->db->transStart();
            $terminalId = $get['terminalId'];
            $storeOutlesId = "Comingsoon";
            $id = $get['accountId'] . "." . model("Core")->number("transaction");

            $this->db->table("cso1_transaction")->insert([
                "id" => $id,
                "transactionDate" => time(),
                "kioskUuid" => $kioskUuid,
                "memberId" => model("Core")->select("memberId", "cso1_kiosk_uuid", "kioskUuid = '" . $kioskUuid . "'"),
                "paymentTypeId" => "",
                "startDate" => model("Core")->select("startDate", "cso1_kiosk_uuid", "kioskUuid = '" . $kioskUuid . "'"),
                "endDate" => date("Y-m-d H:i:s"),
                "storeOutlesId" => $storeOutlesId,
                "terminalId" => $terminalId,
                "struk" => $id,
                "cashierId" => model("Core")->accountId(),
                "pthType" => 1,
                "total" => (int) $summary['total'],
                "discount" => (int) $summary['discount'],
                "discountMember" => (int) $summary['memberDiscount'],
                "voucher" => (int) $summary['voucer'],
                "bkp" => (int) $summary['bkp'],
                "dpp" => (int) $summary['dpp'],
                "ppn" => (int) $summary['ppn'],
                "nonBkp" => (int) $summary['nonBkp'],
                "finalPrice" => (int) $summary['final'],
                "locked" => 1,
                "presence" => 1,
                "inputDate" => time(),
                "updateDate" => time(),
                "transaction_date" => date("Y-m-d H:i:s"),
                "input_date" => date("Y-m-d H:i:s"),
                "update_date" => date("Y-m-d H:i:s"),
            ]);

            $q = model("Core")->sql("SELECT * FROM cso1_kiosk_cart WHERE kioskUuid = '$kioskUuid' and presence = 1 order by input_date ASC");
            foreach ($q as $row) {
                $insertDetail = array(
                    "transactionId" => $id,
                    "promotionId" => $row['promotionId'],
                    "promotionItemId" => $row['promotionItemId'],
                    "barcode" => $row['barcode'],
                    "itemId" => $row['itemId'],
                    "originPrice" => $row['originPrice'],
                    "price" => $row['price'],
                    "discount" => $row['discount'],
                    "isPriceEdit" => $row['isPriceEdit'],
                    "isFreeItem" => $row['isFreeItem'],
                    "isSpecialPrice" => $row['isSpecialPrice'],
                    "isPrintOnBill" => $row['isPrintOnBill'],

                    "memberDiscountPercent" => $row['memberDiscountPercent'],
                    "memberDiscountAmount" => $row['memberDiscountAmount'],
                    "validationNota" => $row['validationNota'],

                    "note" => $row['note'],
                    "void" => $row['void'],
                    "presence" => 1,
                    "inputDate" => $row['inputDate'],
                    "updateDate" => time(),
                    "updateBy" => $row['updateBy'],
                );
                $this->db->table("cso1_transaction_detail")->insert($insertDetail);
            }

            $q = model("Core")->sql("SELECT * FROM cso1_kiosk_cart_free_item  WHERE presence = 1 AND status = 0 AND kioskUuid = '$kioskUuid' ");
            foreach ($q as $row) {
                $insertDetail = array(
                    "transactionId" => $id,
                    "barcode" => $row['barcode'],
                    "itemId" => $row['freeItemId'],
                    "promotionId" => $row['promotionId'],
                    "promotionFreeId" => $row['promotionFreeId'],
                    "originPrice" => 0,
                    "price" => 0,
                    "discount" => 0,
                    "isPriceEdit" => 0,
                    "isFreeItem" => 1,
                    "isSpecialPrice" => 0,
                    "isPrintOnBill" => $row['printOnBill'],
                    "void" => 0,
                    "presence" => $row['scanFree'] == true ? 1 : 2,
                    "inputDate" => $row['inputDate'],
                    "updateDate" => time(),
                    "updateBy" => $row['updateBy'],
                );
                $this->db->table("cso1_transaction_detail")->insert($insertDetail);
            }

            $q = model("Core")->sql("SELECT * FROM cso1_kiosk_paid_pos WHERE kioskUuid = '$kioskUuid' order by id ASC ");
            foreach ($q as $row) {
                $insertDetail = array(
                    "transactionId" => $id,
                    "paymentTypeId" => $row['paymentTypeId'],
                    "paymentNameId" => $row['paymentNameId'],
                    "approvedCode" => $row['approvedCode'],
                    
                    "amount" => $row['paid'],
                    "voucherNumber" => $row['voucherNumber'],
                    "presence" => 1,

                    "inputDate" => time(),
                    "updateDate" => time(),
                    "input_date" => date("Y-m-d H:i:s"),
                    "update_date" => date("Y-m-d H:i:s"),
                );
                $this->db->table("cso1_transaction_payment")->insert($insertDetail);
            }
            $this->db->table("voucher")->update(["transactionId" => $id,], " kioskUuid = '$kioskUuid' ");
            $this->db->table("cso1_kiosk_uuid")->update(["presence" => 4,], " kioskUuid = '$kioskUuid' ");
            $this->db->table("cso2_balance")->update(["transactionId" => $id,], " kioskUuid = '$kioskUuid' ");

            $isCash = (int) model("Core")->sql(" SELECT count(id) as 'cash' from cso1_transaction_payment 
                WHERE paymentTypeId = 'CASH' and  transactionId ='$id'");

            if ($isCash < 1) {
                $this->db->table("cso1_transaction")->update([
                    "cashDrawer" => 1,
                ], "id = '$id' ");
            }

            $this->db->table("cso1_kiosk_cart")->delete([
                "kioskUuid" => $kioskUuid,
            ]);
            $this->db->table("cso1_kiosk_cart_free_item")->delete([
                "kioskUuid" => $kioskUuid,
            ]);
            $this->db->table("cso1_kiosk_paid_pos")->delete([
                "kioskUuid" => $kioskUuid,
            ]); 
            $this->db->table("cso1_kiosk_uuid")->delete([
                "kioskUuid" => $kioskUuid,
            ]);


            $this->db->transComplete();


            $data = array(
                "error" => false,
                "transactionId" => $id,
                "closed" => $closed,
                "note" => "Transcation Success",
                "transStatus" => $this->db->transStatus(),
                "get" => $get,
            );
        } else {
            $this->db->table("cso1_kiosk_uuid")->update([
                "presence" => 5,
            ], " kioskUuid = '$kioskUuid' ");

            $data = array(
                "error" => true,
                "summary" => $summary,
                "transactionId" => model("Core")->select("id", "cso1_transaction", "kioskUuid = '$kioskUuid'"),
                "closed" => $closed,
                "note" => "Transaction  Done",
                "get" => $get,
                "paid" => $paid,
                "invoiced" => $invoiced,
                "transStatus" => null,
                "x" => ($paid - $invoiced)
            );
        }

        return $this->response->setJSON($data);
    }
 

    function addBarcode(){
        $post = json_decode(file_get_contents('php://input'), true);
        $data = array(
            "error" => true,
            "post" => $post,
            "note" => "Not Found",
        );
        if ($post) {
            $barcode = $post['barcode'];
            $kioskUuid =  $post['kioskUuid'];
            $id = model("Core")->select('id', "voucher", "number = '$barcode' and status = 0 ");
            $userId = model("Core")->select('id', "cso1_user", "id = '$barcode' and status = 1 and presence = 1 and userAccessId < 9");
            if ($id) {
 
                $bill = (int) model("Core")->select("sum(price)", "cso1_kiosk_cart", "kioskUuid = '$kioskUuid'") ;
                $bill =   $bill < 0  ? 1 :   $bill;
                $paid = (int) model("Core")->select("sum(paid)", "cso1_kiosk_paid_pos", "kioskUuid = '$kioskUuid'");
                $remaining = $bill - $paid;
 
                $amount = model("Core")->select('amount', "voucher", "id = '$id' ");
 
                $this->db->table("cso1_kiosk_paid_pos")->insert([
                    "kioskUuid" => $post['kioskUuid'],
                    "paid" =>  ($remaining -  $amount) < 0 ? $remaining : $amount,
                    "paymentTypeId" => 'VOUCHER',
                    "voucherNumber" => $barcode,
                    "input_date" => date("Y-m-d H:i:s")
                ]);

                $this->db->table("voucher")->update([
                    "kioskUuid" => $post['kioskUuid'],
                    "status" => 1,
                    "update_date" => date("Y-m-d H:i:s")
                ], " id = '$id' ");

                $data = array(
                    "error" => false,
                    "post" => $post,
                    "action" => "",
                    "note" => "",
                    "reload" => true,
                );
            }
            else if($userId){
                $data = array(
                    "error" => true,
                    "post" => $post,
                    "action" => "openPassword",
                    "note" => "user login",
                    "reload" => false,
                );
            } 
            else if( model("Core")->select('id', "voucher", "number = '$barcode' and status = 1 ") ){
                $data = array(
                    "error" => true,
                    "post" => $post,
                    "action" => "",
                    "note" => "not found",
                    "reload" => false,
                );
            }
            
        }
        return $this->response->setJSON($data);
    }
}