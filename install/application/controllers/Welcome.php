<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Welcome extends CI_Controller
{
	public $mydb = "pos2";
	 

	public function index()
	{ 
		$q = "SELECT COUNT(*) AS 'db'
		FROM information_schema.SCHEMATA
		WHERE SCHEMA_NAME = '".$this->mydb."' ";

		$data = array(
			"mydb" => $this->mydb,
			"checkDb" => $this->db->query($q)->result_array()[0]["db"],
		);
		 $this->load->view('home',$data);
	} 

}
