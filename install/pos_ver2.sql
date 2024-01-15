-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table pos2.auto_number
CREATE TABLE IF NOT EXISTS `auto_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `digit` int(11) NOT NULL DEFAULT 6,
  `runningNumber` int(11) NOT NULL DEFAULT 0,
  `updateDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.auto_number: ~18 rows (approximately)
DELETE FROM `auto_number`;
INSERT INTO `auto_number` (`id`, `name`, `prefix`, `digit`, `runningNumber`, `updateDate`) VALUES
	(1, 'brand', 'BND', 4, 26, 1657258458),
	(2, 'terminal', 'T', 4, 19, 1668759062),
	(3, 'taxCode', 'TAX', 4, 9, 1657280513),
	(4, 'branched', 'BN', 4, 9, 1657267586),
	(5, 'outlet', 'OD', 4, 36, 1657790756),
	(6, 'idPayment', 'ID', 4, 10, 1681281223),
	(7, 'uom', 'UOM', 4, 11, 1657281222),
	(10, 'item', 'TM', 9, 3, 1657781787),
	(11, 'user', 'S', 6, 1, 1657258458),
	(100, 'promotion', 'PR', 6, 11, 1658813889),
	(200, 'transaction', '', 4, 120, 1705296353),
	(201, 'kiosk', NULL, 9, 48869, 1701431691),
	(220, 'reset', 'RST', 6, 248, 1691133733),
	(300, 'kioskUuid', 'BILL', 9, 11902, 1692178227),
	(301, 'settlement', 'SET', 6, 38, 1705084025),
	(302, 'pos', NULL, 4, 215, 1705294021),
	(303, 'refund', 'REF', 6, 49, 1701431691),
	(304, 'exchange', 'EXC', 6, 34, 1697626014);

-- Dumping structure for table pos2.cso1_account
CREATE TABLE IF NOT EXISTS `cso1_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `value` longtext DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_account: ~32 rows (approximately)
DELETE FROM `cso1_account`;
INSERT INTO `cso1_account` (`id`, `name`, `value`, `updateDate`, `updateBy`) VALUES
	(1, 'companyId', '01', 1654258394, 1),
	(2, 'keyLisence', 'Update 2022-11-07 10:32:55', 1667813575, 1),
	(3, 'keygen', 'cso1_account', 1654258548, 1),
	(4, 'kioskEnable', '1', 1686535691, 1),
	(10, 'companyName', 'CHANDRA GROUP', 1701337374, 1),
	(11, 'companyAddress', 'Jl. Pemuda No 1, Bandar Lampung', 1701337374, 1),
	(12, 'companyPhone', '(0721)269813', 1701337374, 1),
	(14, 'Logo Images Terminal (option)', '', 1701337374, 0),
	(21, 'Outlet ID', 'OT99', NULL, NULL),
	(22, 'Brand ID', 'BD52', NULL, NULL),
	(51, 'Digit Prefix Position', '1', 1701337374, NULL),
	(52, 'Digit Item', '6', 1701337374, 1),
	(53, 'Digit Weight', '5', 1701337374, 1),
	(54, 'Digit Float', '3', 1701337374, 1),
	(99, 'Member Discount', '10', NULL, NULL),
	(100, 'Round Method', '10', 1701337374, 1),
	(101, 'Tax Id', 'NPWP', 1701337374, 1),
	(201, 'Customer Photo', '1', 1701337374, NULL),
	(300, 'getMember', NULL, 1701337374, NULL),
	(301, 'getItem', NULL, 1701337374, NULL),
	(302, 'getPromotion', NULL, 1701337374, NULL),
	(350, 'sendTransaction', NULL, 1701337374, NULL),
	(400, 'Printer Name', 'wintec', 1701337374, NULL),
	(1001, 'Welcome Screen', 'Selamat Datang di Chandra Superstore.<br>Semoga anda nyaman dengan pengalaman baru berbelanja di Chandra Superstore.', 1701337374, 1),
	(1003, 'Customer Statement Display', 'Saya bersedia untuk scan dengan apa yang telah saya beli. ', 1701337374, 1),
	(1004, 'Thank You Display', 'Thank You for shopping on our store, and we hope you have enjoyable shopping experience. <br><br><br><br><br>Please Come Again', 1701337374, 1),
	(1005, 'Member not found Display', 'Member anda tidak ditemukan.', 1701337374, 1),
	(1006, 'Visitor Login Display', 'Selamat datang Pelanggan yang kami hormati. <br>Semoga anda menikmati lanyanan Self Checkout ini.<br>Hubungi tim kami jika anda membutuhkan bantuan.', 1701337374, 1),
	(1007, 'Print out Message on Receipt', 'Terima Kasih atas kunjungan anda.<br>Belanja Nyaman Belanja Hemat.', 1701337374, 1),
	(1009, 'Promotion free Item', 'barang Promotion Item label', 1701337374, 1),
	(1101, 'tnc1', 'Saya bersedia dalam penggunaan system akan memasukan data  dengan benar & tepat', 1701337374, NULL),
	(1102, 'tnc2', 'Saya bersedia jika ada kekurangan tepatan untuk menerima pihak toko melakukan penyesuaian', 1701337374, NULL);

-- Dumping structure for table pos2.cso1_greeting
CREATE TABLE IF NOT EXISTS `cso1_greeting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(250) DEFAULT NULL,
  `publishDate` date DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `presence` int(11) NOT NULL DEFAULT 1,
  `inputBy` int(11) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_greeting: ~0 rows (approximately)
DELETE FROM `cso1_greeting`;

-- Dumping structure for table pos2.cso1_item
CREATE TABLE IF NOT EXISTS `cso1_item` (
  `id` varchar(50) NOT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `shortDesc` varchar(250) DEFAULT NULL,
  `priceFlag` int(11) DEFAULT NULL,
  `ppnFlag` int(11) DEFAULT NULL,
  `price1` double DEFAULT NULL,
  `price2` double DEFAULT NULL,
  `price3` double DEFAULT NULL,
  `price4` double DEFAULT NULL,
  `price5` double DEFAULT NULL,
  `price6` double DEFAULT NULL,
  `price7` double DEFAULT NULL,
  `price8` double DEFAULT NULL,
  `price9` double DEFAULT NULL,
  `price10` double DEFAULT NULL,
  `itemUomId` varchar(50) DEFAULT NULL,
  `itemCategoryId` varchar(50) DEFAULT NULL,
  `itemTaxId` varchar(50) DEFAULT NULL,
  `images` longtext DEFAULT NULL,
  `presence` int(1) NOT NULL DEFAULT 1,
  `status` int(11) NOT NULL DEFAULT 1,
  `inputBy` int(11) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_description` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_item: ~0 rows (approximately)
DELETE FROM `cso1_item`;

-- Dumping structure for table pos2.cso1_item_barcode
CREATE TABLE IF NOT EXISTS `cso1_item_barcode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemId` varchar(50) DEFAULT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `presence` int(1) NOT NULL DEFAULT 1,
  `inputBy` varchar(250) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  `updateBy` varchar(250) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_item_barcode: ~0 rows (approximately)
DELETE FROM `cso1_item_barcode`;

-- Dumping structure for table pos2.cso1_item_category
CREATE TABLE IF NOT EXISTS `cso1_item_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_parent` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `presence` int(11) NOT NULL DEFAULT 1,
  `inputBy` int(11) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_item_category: ~46 rows (approximately)
DELETE FROM `cso1_item_category`;
INSERT INTO `cso1_item_category` (`id`, `id_parent`, `name`, `status`, `presence`, `inputBy`, `inputDate`, `updateBy`, `updateDate`) VALUES
	(1, 0, 'Food', 1, 1, 1, 1653024459, 1, 1654232884),
	(2, 1, 'Fish Market', 1, 1, 1, 1653024459, 1, 1654664752),
	(3, 2, 'Udang', 1, 1, 1, NULL, 1, 1654665802),
	(4, 2, 'Ikan', 1, 1, 1, 1654233826, 1, 1654665812),
	(5, 0, 'Cleaning', 1, 1, 1, 1654236577, 1, 1654664748),
	(6, 0, 'Non Food', 1, 1, 1, 1654236689, 1, 1654565401),
	(7, 6, 'Perawatan Kendaraan', 1, 1, 1, 1654236701, 1, 1654565944),
	(8, 1, 'Snacks', 1, 1, 1, 1654565193, 1, 1654565193),
	(9, 1, 'Minuman', 1, 1, 1, 1654565205, 1, 1654565513),
	(10, 1, 'Fresh Product', 1, 1, 1, 1654565212, 1, 1654565792),
	(11, 1, 'Bahan Pokok', 1, 1, 1, 1654565224, 1, 1654565462),
	(12, 11, 'Beras', 1, 1, 1, 1654565472, 1, 1654565472),
	(13, 11, 'Minyak Goreng', 1, 1, 1, 1654565478, 1, 1654565478),
	(14, 11, 'Tepung', 1, 1, 1, 1654565485, 1, 1654565485),
	(15, 11, 'Telur', 1, 1, 1, 1654565554, 1, 1654565554),
	(16, 9, 'Susu', 1, 1, 1, 1654565578, 1, 1654565578),
	(17, 9, 'Soda', 1, 1, 1, 1654565583, 1, 1654565583),
	(18, 9, 'Juice', 1, 1, 1, 1654565606, 1, 1654565606),
	(19, 9, 'Energi / Suplemen', 1, 1, 1, 1654565617, 1, 1654566218),
	(20, 9, 'Air Mineral', 1, 1, 1, 1654565626, 1, 1654565626),
	(21, 8, 'Snack Pabrik', 1, 1, 1, 1654565691, 1, 1654565691),
	(22, 8, 'Snack Repacking', 1, 1, 1, 1654565702, 1, 1654565702),
	(23, 8, 'Snack Curah', 1, 1, 1, 1654565729, 1, 1654565729),
	(24, 10, 'Sayuran', 1, 1, 1, 1654565799, 1, 1654565799),
	(25, 10, 'Buah', 1, 1, 1, 1654565803, 1, 1654565803),
	(26, 6, 'Perawatan Tubuh', 1, 1, 1, 1654565838, 1, 1654565838),
	(27, 6, 'Bahan dan Peralatan Cuci', 1, 1, 1, 1654565855, 1, 1656502020),
	(28, 6, 'Perawatan Rumah', 1, 1, 1, 1654565870, 1, 1654565870),
	(29, 6, 'Alat Tulis dan Kantor', 1, 1, 1, 1654565889, 1, 1654565889),
	(30, 26, 'Shampoo', 1, 1, 1, 1654565958, 1, 1654565958),
	(31, 26, 'Sabun Mandi', 1, 1, 1, 1654565963, 1, 1654565963),
	(32, 26, 'Pasta Gigi', 1, 1, 1, 1654565974, 1, 1654565974),
	(33, 26, 'Kosmetik', 1, 1, 1, 1654565980, 1, 1654565980),
	(34, 28, 'Pembersih Kamar Mandi', 1, 1, 1, 1654566002, 1, 1654566002),
	(35, 28, 'Pembersih Kaca', 1, 1, 1, 1654566012, 1, 1654566012),
	(36, 28, 'Pembersih Lantai', 1, 1, 1, 1654566022, 1, 1654566022),
	(37, 28, 'Alat Kebersihan', 1, 1, 1, 1654566034, 1, 1654566034),
	(38, 27, 'Deterjen', 1, 1, 1, 1654566051, 1, 1654566051),
	(39, 27, 'Pelembut dan Pewangi', 1, 1, 1, 1654566058, 1, 1654566058),
	(40, 27, 'Sabun Cuci Piring', 1, 1, 1, 1654566075, 1, 1654566075),
	(41, 27, 'Pemutih Pakaian', 1, 1, 1, 1654566087, 1, 1654566087),
	(42, 29, 'Buku', 1, 1, 1, 1654566099, 1, 1654566099),
	(43, 29, 'Alat Tulis', 1, 1, 1, 1654566106, 1, 1654566106),
	(44, 7, 'Sabun Mobil', 1, 1, 1, 1654566125, 1, 1654566125),
	(45, 7, 'Peralatan pembersih kendaraan', 1, 1, 1, 1654566138, 1, 1654566138),
	(46, 14, 'Sagu', 1, 1, 1, 1656497534, 1, 1656497534);

-- Dumping structure for table pos2.cso1_item_discount
CREATE TABLE IF NOT EXISTS `cso1_item_discount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `presence` int(11) NOT NULL,
  `inputBy` int(11) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_item_discount: ~0 rows (approximately)
DELETE FROM `cso1_item_discount`;

-- Dumping structure for table pos2.cso1_item_tax
CREATE TABLE IF NOT EXISTS `cso1_item_tax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `presence` int(11) NOT NULL DEFAULT 1,
  `inputBy` int(11) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_item_tax: ~2 rows (approximately)
DELETE FROM `cso1_item_tax`;
INSERT INTO `cso1_item_tax` (`id`, `description`, `status`, `presence`, `inputBy`, `inputDate`, `updateBy`, `updateDate`) VALUES
	(2, 'Enable', 1, 1, NULL, NULL, NULL, NULL),
	(3, 'Disable', 1, 1, NULL, NULL, NULL, NULL);

-- Dumping structure for table pos2.cso1_item_uom
CREATE TABLE IF NOT EXISTS `cso1_item_uom` (
  `id` varchar(50) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `presence` int(11) NOT NULL DEFAULT 1,
  `inputBy` int(11) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_item_uom: ~4 rows (approximately)
DELETE FROM `cso1_item_uom`;
INSERT INTO `cso1_item_uom` (`id`, `name`, `description`, `status`, `presence`, `inputBy`, `inputDate`, `updateBy`, `updateDate`) VALUES
	('UOM0001', 'Bag', 'Kilogram ', 1, 1, 1, 1652960737, 1, 1656501138),
	('UOM0002', 'Pcs', 'Piece', 1, 1, 1, 1653024577, 1, 1654567712),
	('UOM0003', 'Box', 'Box ', 1, 1, 1, 1653024577, 1, 1654567720),
	('UOM0004', 'Btl', 'Bottle', 1, 1, 1, 1654567814, 1, 1656501301);

-- Dumping structure for table pos2.cso1_kiosk_cart
CREATE TABLE IF NOT EXISTS `cso1_kiosk_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kioskUuid` varchar(50) DEFAULT NULL,
  `promotionId` varchar(50) DEFAULT NULL,
  `promotionItemId` int(11) DEFAULT NULL,
  `promotionFreeId` int(11) DEFAULT NULL,
  `promotionDiscountId` varchar(50) DEFAULT NULL,
  `itemId` varchar(50) DEFAULT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `originPrice` double DEFAULT 0,
  `price` double DEFAULT 0,
  `discount` double DEFAULT 0,
  `memberDiscountPercent` double DEFAULT 0,
  `memberDiscountAmount` double DEFAULT 0,
  `validationNota` int(1) DEFAULT 0,
  `isPriceEdit` int(1) DEFAULT 0,
  `isFreeItem` varchar(50) NOT NULL DEFAULT '',
  `isSpecialPrice` int(1) NOT NULL DEFAULT 0,
  `isPrintOnBill` int(1) NOT NULL DEFAULT 1,
  `photo` longtext DEFAULT NULL,
  `void` int(11) NOT NULL DEFAULT 0,
  `note` varchar(250) DEFAULT NULL,
  `presence` int(1) NOT NULL DEFAULT 1,
  `inputDate` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  `updateBy` varchar(50) DEFAULT NULL,
  `input_date` datetime NOT NULL DEFAULT '2023-01-01 00:00:00',
  `update_date` datetime NOT NULL DEFAULT '2023-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_kiosk_cart: ~0 rows (approximately)
DELETE FROM `cso1_kiosk_cart`;

-- Dumping structure for table pos2.cso1_kiosk_paid_pos
CREATE TABLE IF NOT EXISTS `cso1_kiosk_paid_pos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kioskUuid` varchar(50) NOT NULL,
  `paymentTypeId` varchar(50) DEFAULT NULL,
  `paymentNameId` varchar(50) DEFAULT NULL,
  `approvedCode` varchar(50) DEFAULT NULL,
  `refCode` varchar(50) DEFAULT NULL,
  `paid` int(11) DEFAULT 0,
  `deviceId` varchar(50) DEFAULT NULL,
  `cardId` varchar(50) DEFAULT NULL,
  `voucherNumber` varchar(50) DEFAULT NULL,
  `note` varchar(250) DEFAULT NULL,
  `externalTransId` varchar(50) DEFAULT NULL,
  `startDate` datetime DEFAULT '2023-01-01 00:00:00',
  `input_date` datetime DEFAULT '2023-01-01 00:00:00',
  `update_date` datetime DEFAULT '2023-01-01 00:00:00',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_kiosk_paid_pos: ~0 rows (approximately)
DELETE FROM `cso1_kiosk_paid_pos`;

-- Dumping structure for table pos2.cso1_kiosk_uuid
CREATE TABLE IF NOT EXISTS `cso1_kiosk_uuid` (
  `kioskUuid` varchar(50) NOT NULL,
  `exchange` varchar(50) NOT NULL,
  `cashierId` varchar(50) NOT NULL,
  `terminalId` varchar(50) DEFAULT NULL,
  `storeOutlesId` varchar(50) DEFAULT NULL,
  `memberId` varchar(50) DEFAULT NULL,
  `photo` longtext DEFAULT NULL,
  `ilock` int(1) DEFAULT 0,
  `presence` int(1) DEFAULT 1,
  `status` int(1) DEFAULT 1,
  `inputDate` int(11) DEFAULT NULL,
  `startDate` datetime DEFAULT '2023-01-01 00:00:00',
  `input_date` datetime DEFAULT '2023-01-01 00:00:00',
  `update_date` datetime DEFAULT '2023-01-01 00:00:00',
  PRIMARY KEY (`kioskUuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_kiosk_uuid: ~0 rows (approximately)
DELETE FROM `cso1_kiosk_uuid`;

-- Dumping structure for table pos2.cso1_payment_bca_ecr
CREATE TABLE IF NOT EXISTS `cso1_payment_bca_ecr` (
  `transactionId` varchar(50) NOT NULL,
  `kioskUuid` varchar(50) DEFAULT NULL,
  `paymentTypeId` varchar(250) DEFAULT NULL,
  `respCode` varchar(250) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `pan` varchar(50) DEFAULT NULL,
  `expiryDate` varchar(4) DEFAULT NULL,
  `rrn` varchar(50) DEFAULT NULL,
  `approvalCode` varchar(50) DEFAULT NULL,
  `dateTime` varchar(50) DEFAULT NULL,
  `merchantId` varchar(50) DEFAULT NULL,
  `terminalId` varchar(50) DEFAULT NULL,
  `cardHolderName` varchar(50) DEFAULT NULL,
  `invoiceNumber` varchar(50) DEFAULT NULL,
  `hex` longtext DEFAULT NULL,
  `asciiString` longtext DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`transactionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_payment_bca_ecr: ~0 rows (approximately)
DELETE FROM `cso1_payment_bca_ecr`;

-- Dumping structure for table pos2.cso1_payment_bca_qris
CREATE TABLE IF NOT EXISTS `cso1_payment_bca_qris` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kioskUuid` varchar(50) NOT NULL,
  `reffNo` varchar(50) DEFAULT NULL,
  `hex` longtext DEFAULT NULL,
  `asciiString` longtext DEFAULT NULL,
  `respAscii` longtext DEFAULT NULL,
  `respHex` longtext DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `presence` int(11) NOT NULL DEFAULT 1,
  `inputDate` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_payment_bca_qris: ~0 rows (approximately)
DELETE FROM `cso1_payment_bca_qris`;

-- Dumping structure for table pos2.cso1_payment_name
CREATE TABLE IF NOT EXISTS `cso1_payment_name` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `status` int(2) NOT NULL DEFAULT 1,
  `img` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_payment_name: ~13 rows (approximately)
DELETE FROM `cso1_payment_name`;
INSERT INTO `cso1_payment_name` (`id`, `name`, `status`, `img`) VALUES
	(10, 'BCA DEBIT', 1, ''),
	(11, 'BCA VISA', 1, ''),
	(12, 'BCA MASTERCARD', 1, ''),
	(20, 'MANDIRI DEBIT', 1, ''),
	(21, 'MANDIRI VISA', 1, ''),
	(22, 'MANDIRI MASTERCARD', 1, ''),
	(30, 'BRI DEBIT', 1, ''),
	(31, 'BRI VISA', 1, ''),
	(32, 'BRI MASTERCARD', 1, ''),
	(40, 'BNI DEBIT', 1, ''),
	(41, 'BNI VISA', 1, ''),
	(42, 'BNI MASTERCARD', 1, ''),
	(101, 'DIGITAL MONEY', 1, '');

-- Dumping structure for table pos2.cso1_payment_qris_telkom
CREATE TABLE IF NOT EXISTS `cso1_payment_qris_telkom` (
  `kioskUuid` varchar(50) NOT NULL,
  `cliTrxNumber` varchar(50) DEFAULT NULL,
  `cliTrxAmount` int(11) DEFAULT NULL,
  `qris_status` varchar(50) DEFAULT NULL,
  `qris_payment_customername` varchar(50) DEFAULT NULL,
  `qris_payment_methodby` varchar(50) DEFAULT NULL,
  `transactionId` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `presence` int(11) DEFAULT 1,
  `qris_content` longtext DEFAULT NULL,
  `qris_invoiceid` varchar(50) DEFAULT NULL,
  `qris_api_version_code` varchar(50) DEFAULT NULL,
  `qris_request_date` datetime(3) DEFAULT NULL,
  `qris_nmid` varchar(50) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`kioskUuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_payment_qris_telkom: ~0 rows (approximately)
DELETE FROM `cso1_payment_qris_telkom`;

-- Dumping structure for table pos2.cso1_payment_type
CREATE TABLE IF NOT EXISTS `cso1_payment_type` (
  `id` varchar(50) NOT NULL,
  `edc` int(1) NOT NULL DEFAULT 0,
  `label` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `com` varchar(9) NOT NULL DEFAULT '',
  `apikey` varchar(50) NOT NULL DEFAULT '',
  `mId` varchar(50) NOT NULL DEFAULT '',
  `nmId` varchar(50) NOT NULL DEFAULT '',
  `merchant` varchar(50) NOT NULL DEFAULT '',
  `timeout` int(11) NOT NULL,
  `image` varchar(250) NOT NULL DEFAULT '',
  `apiUrl` varchar(250) NOT NULL DEFAULT '',
  `apiUrlStatus` varchar(250) NOT NULL DEFAULT '',
  `isLock` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1,
  `presence` int(11) NOT NULL DEFAULT 1,
  `inputBy` int(11) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_payment_type: ~10 rows (approximately)
DELETE FROM `cso1_payment_type`;
INSERT INTO `cso1_payment_type` (`id`, `edc`, `label`, `name`, `com`, `apikey`, `mId`, `nmId`, `merchant`, `timeout`, `image`, `apiUrl`, `apiUrlStatus`, `isLock`, `status`, `presence`, `inputBy`, `inputDate`, `updateBy`, `updateDate`) VALUES
	('BCA01', 0, 'BCA CARD ERC', 'BCA Debit', '', '', '', '', '', 0, 'http://192.168.202.72/imgs/debit-card.jpg', '', '', 1, 1, 1, NULL, NULL, 1, 1683006321),
	('BCA31', 0, 'BCA QRIS', 'BCA QRIS', '', '', '', '', '', 0, 'http://192.168.202.72/imgs/QRIS-BCA.jpg', '', '', 1, 1, 1, NULL, NULL, 1, 1681275934),
	('CASH', 0, 'CASH', 'CASH', '', '', '', '', '', 0, '', '', '', 1, 1, 1, NULL, NULL, NULL, NULL),
	('DEBITCC', 0, 'MANUAL DEBIT CARD', 'DEBIT, VISA, MASTERCARD', '', '', '', '', '', 0, '', '', '', 1, 1, 1, NULL, NULL, NULL, NULL),
	('DISC.BILL', 0, 'DISCOUNT BILL', 'DISCOUNT BILL', '', '', '', '', '', 0, '', '', '', 1, 0, 1, NULL, NULL, NULL, NULL),
	('EDC_BCA', 1, 'BCA EDC', 'BCA EDC', 'COM5', '', '', '', '', 0, './assets/logo/bca.png', '', '', 1, 0, 1, NULL, NULL, NULL, NULL),
	('EDC_BRI', 1, 'BRI EDC', 'BRI EDC', '', '', '', '', '', 0, './assets/logo/bri.png', '', '', 1, 0, 1, NULL, NULL, NULL, NULL),
	('EDC_MANDIRI', 1, 'Mandiri EDC', 'Mandiri EDC', 'COM8', '', '', '', '', 0, './assets/logo/mandiri.png', '', '', 1, 1, 1, NULL, NULL, NULL, NULL),
	('QRISTELKOM', 0, 'QRIS TELKOM', 'CHANDRA SUPERSTORE', '', '139139211206273', '195268799679', 'ID2022218237529', 'MITRALINK SOLUSI', 30, './assets/logo/qrisTelkom.png', 'https://qris.id/restapi/qris/show_qris.php', 'https://qris.id/restapi/qris/checkpaid_qris.php', 1, 0, 1, 1, 1657780329, 1, 1681277052),
	('VOUCHER', 0, 'VOUCHER', 'VOUCHER', '', '', '', '', '', 0, '', '', '', 1, 0, 1, NULL, NULL, NULL, NULL);

-- Dumping structure for table pos2.cso1_promotion
CREATE TABLE IF NOT EXISTS `cso1_promotion` (
  `id` varchar(50) NOT NULL,
  `typeOfPromotion` int(11) NOT NULL DEFAULT 0,
  `storeOutlesId` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `startDate` int(11) DEFAULT NULL,
  `endDate` int(11) DEFAULT NULL,
  `discountPercent` double DEFAULT NULL,
  `discountAmount` double DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 1,
  `presence` int(1) NOT NULL DEFAULT 1,
  `Mon` int(1) DEFAULT 0,
  `Tue` int(1) DEFAULT 0,
  `Wed` int(1) DEFAULT 0,
  `Thu` int(1) DEFAULT 0,
  `Fri` int(1) DEFAULT 0,
  `Sat` int(1) DEFAULT 0,
  `Sun` int(1) DEFAULT 0,
  `inputDate` int(1) DEFAULT 0,
  `inputBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_promotion: ~0 rows (approximately)
DELETE FROM `cso1_promotion`;

-- Dumping structure for table pos2.cso1_promotion_discount
CREATE TABLE IF NOT EXISTS `cso1_promotion_discount` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `promotionId` varchar(50) DEFAULT NULL,
  `itemId` varchar(50) DEFAULT NULL,
  `disc1` double DEFAULT NULL,
  `disc2` double DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 1,
  `presence` int(1) NOT NULL DEFAULT 1,
  `inputDate` int(11) DEFAULT NULL,
  `inputBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_promotion_discount: ~0 rows (approximately)
DELETE FROM `cso1_promotion_discount`;

-- Dumping structure for table pos2.cso1_promotion_free
CREATE TABLE IF NOT EXISTS `cso1_promotion_free` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promotionId` varchar(50) DEFAULT NULL,
  `itemId` varchar(50) DEFAULT NULL,
  `qty` int(11) NOT NULL DEFAULT 0,
  `freeItemId` varchar(50) DEFAULT NULL,
  `freeQty` int(11) NOT NULL DEFAULT 0,
  `applyMultiply` tinyint(4) NOT NULL DEFAULT 0,
  `scanFree` tinyint(4) NOT NULL DEFAULT 0,
  `printOnBill` tinyint(4) NOT NULL DEFAULT 0,
  `status` int(11) DEFAULT 1,
  `presence` int(1) NOT NULL DEFAULT 1,
  `inputDate` int(11) DEFAULT NULL,
  `inputBy` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_promotion_free: ~0 rows (approximately)
DELETE FROM `cso1_promotion_free`;

-- Dumping structure for table pos2.cso1_promotion_item
CREATE TABLE IF NOT EXISTS `cso1_promotion_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promotionId` varchar(50) DEFAULT NULL,
  `itemId` varchar(50) DEFAULT NULL,
  `qtyFrom` int(11) DEFAULT NULL,
  `qtyTo` int(11) DEFAULT NULL,
  `specialPrice` double DEFAULT NULL,
  `disc1` double DEFAULT NULL,
  `disc2` double DEFAULT NULL,
  `disc3` double DEFAULT NULL,
  `discountPrice` double DEFAULT NULL,
  `presence` int(1) NOT NULL DEFAULT 1,
  `status` int(11) NOT NULL DEFAULT 1,
  `inputDate` int(11) DEFAULT NULL,
  `inputBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_promotion_item: ~0 rows (approximately)
DELETE FROM `cso1_promotion_item`;

-- Dumping structure for table pos2.cso1_promo_fixed
CREATE TABLE IF NOT EXISTS `cso1_promo_fixed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `icon` varchar(50) DEFAULT '<i class="bi bi-check"></i>',
  `description` varchar(150) DEFAULT NULL,
  `shortDesc` varchar(150) DEFAULT NULL,
  `targetAmount` int(11) DEFAULT NULL,
  `isMultiple` int(1) DEFAULT 1,
  `voucherAmount` float(11,2) DEFAULT NULL,
  `ifAmountNearTarget` float(4,2) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `expDate` date DEFAULT '2023-01-01',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_promo_fixed: ~8 rows (approximately)
DELETE FROM `cso1_promo_fixed`;
INSERT INTO `cso1_promo_fixed` (`id`, `name`, `icon`, `description`, `shortDesc`, `targetAmount`, `isMultiple`, `voucherAmount`, `ifAmountNearTarget`, `status`, `expDate`) VALUES
	(1, 'Free Packing', '<i class="bi bi-check"></i>', 'Belanja di atas Rp 100.000, Anda dapat parkir gratis', 'Gratis Parkir', 100000, 0, NULL, 50.00, 1, '2025-01-01'),
	(10, 'Lucky dip', '<i class="bi bi-check"></i>', 'Anda berhak mendapatkan  nomor lucky dip', 'Lucky dip', 100000, 1, NULL, 70.00, 0, '2025-09-25'),
	(20, 'voucher', '<i class="bi bi-check"></i>', 'Anda mendapakan Voucher kelipatan Rp 100.000, sebesar', 'Get Voucher', 100000, 1, 100000.00, 70.00, 1, '2023-11-01'),
	(21, 'voucher Discount', '<i class="bi bi-check"></i>', 'Anda mendapakan Discount', 'Get Voucher Discount', 100000, 0, 0.05, 70.00, 1, '2023-11-01'),
	(100, 'extra point', '<i class="bi bi-check"></i>', 'Dapat extra point yang bisa di redeem di customer service untuk masuk ke membership', 'Extra Point', 100000, 0, NULL, 70.00, 1, '2024-01-01'),
	(101, 'Free Gift', '<i class="bi bi-check"></i>', 'Promo gratis barang tertentu untuk pembelian sejumlah barang', 'Free Gift', 100000, 0, NULL, 70.00, 1, '2024-01-01'),
	(102, 'Get Voucher', '<i class="bi bi-check"></i>', 'Setting nilai maximum voucher', 'Get Voucher', 100000, 0, 1.00, 80.00, 1, '2024-01-01'),
	(103, 'Cashback Brands', '<i class="bi bi-check"></i>', 'Belanja dengan nilai tertentu dapat discount untuk brand tertentu untuk pembelanjaan berikutnya', 'Cashback Brands', 100000, 0, 4.00, 42.00, 1, '2024-01-01');

-- Dumping structure for table pos2.cso1_reset
CREATE TABLE IF NOT EXISTS `cso1_reset` (
  `id` varchar(50) NOT NULL,
  `storeOutlesId` varchar(50) DEFAULT NULL,
  `startDate` int(11) DEFAULT NULL,
  `endDate` int(11) DEFAULT NULL,
  `totalNumberOfCheck` int(11) DEFAULT NULL,
  `summaryTotalVoid` double DEFAULT NULL,
  `summaryTotalTransaction` double DEFAULT NULL,
  `summaryTotalCart` double DEFAULT NULL,
  `overalitemSales` double DEFAULT NULL,
  `overalDiscount` double DEFAULT NULL,
  `overalNetSales` double DEFAULT NULL,
  `overalFinalPrice` double DEFAULT NULL,
  `overalTax` double DEFAULT NULL,
  `note` varchar(250) DEFAULT NULL,
  `presence` int(11) NOT NULL,
  `inputDate` int(11) DEFAULT 1,
  `inputBy` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_reset: ~0 rows (approximately)
DELETE FROM `cso1_reset`;

-- Dumping structure for table pos2.cso1_reset_payment
CREATE TABLE IF NOT EXISTS `cso1_reset_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resetId` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `paymentTypeId` varchar(50) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `paidAmount` double DEFAULT NULL,
  `presence` int(11) NOT NULL DEFAULT 1,
  `inputDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_reset_payment: ~0 rows (approximately)
DELETE FROM `cso1_reset_payment`;

-- Dumping structure for table pos2.cso1_sync
CREATE TABLE IF NOT EXISTS `cso1_sync` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(250) NOT NULL DEFAULT '0',
  `fileName` varchar(250) DEFAULT NULL,
  `totalInsert` int(11) DEFAULT NULL,
  `result` varchar(250) DEFAULT NULL,
  `lastSycn` datetime(3) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_sync: ~0 rows (approximately)
DELETE FROM `cso1_sync`;

-- Dumping structure for table pos2.cso1_sync_log
CREATE TABLE IF NOT EXISTS `cso1_sync_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(50) DEFAULT NULL,
  `fileName` varchar(250) DEFAULT NULL,
  `fileSize` double DEFAULT 0,
  `syncDate` datetime(3) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `presence` int(11) NOT NULL DEFAULT 0,
  `inputDate` int(11) DEFAULT NULL,
  `inputBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_sync_log: ~0 rows (approximately)
DELETE FROM `cso1_sync_log`;

-- Dumping structure for table pos2.cso1_taxcode
CREATE TABLE IF NOT EXISTS `cso1_taxcode` (
  `id` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `taxType` int(11) DEFAULT NULL COMMENT 'Inclusive or Exclusive',
  `percentage` double DEFAULT 0,
  `status` int(11) DEFAULT 0,
  `presence` int(11) DEFAULT 1,
  `inputDate` int(11) DEFAULT NULL,
  `inputBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_taxcode: ~3 rows (approximately)
DELETE FROM `cso1_taxcode`;
INSERT INTO `cso1_taxcode` (`id`, `name`, `taxType`, `percentage`, `status`, `presence`, `inputDate`, `inputBy`, `updateDate`, `updateBy`) VALUES
	('0', 'Non PPN', 0, 0, 1, 1, 1654663251, 1, 1659435264, 1),
	('1', 'PPN 11% Inc', 1, 11, 1, 1, 1654490568, 1, 1661746470, 1),
	('2', 'PPN 11% Excl', 0, 11, 1, 1, NULL, NULL, 1659435264, 1);

-- Dumping structure for table pos2.cso1_tebus_murah
CREATE TABLE IF NOT EXISTS `cso1_tebus_murah` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(250) DEFAULT NULL,
  `expDate` int(11) DEFAULT 0,
  `exp_date` date DEFAULT '2023-12-12',
  `minTransaction` int(11) DEFAULT 0,
  `maxItem` int(3) DEFAULT 0,
  `status` int(1) DEFAULT 1,
  `presence` int(1) DEFAULT 1,
  `inputDate` int(11) DEFAULT 0,
  `input_date` datetime DEFAULT '2023-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_tebus_murah: ~0 rows (approximately)
DELETE FROM `cso1_tebus_murah`;

-- Dumping structure for table pos2.cso1_tebus_murah_items
CREATE TABLE IF NOT EXISTS `cso1_tebus_murah_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tembusMurahId` int(11) NOT NULL DEFAULT 0,
  `itemId` varchar(50) NOT NULL DEFAULT '',
  `price` int(11) NOT NULL DEFAULT 0,
  `inputDate` int(11) NOT NULL DEFAULT 0,
  `input_date` datetime NOT NULL DEFAULT '2023-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_tebus_murah_items: ~0 rows (approximately)
DELETE FROM `cso1_tebus_murah_items`;

-- Dumping structure for table pos2.cso1_transaction
CREATE TABLE IF NOT EXISTS `cso1_transaction` (
  `id` varchar(50) NOT NULL,
  `transactionDate` int(11) DEFAULT NULL,
  `transaction_date` datetime DEFAULT '2023-01-01 00:00:00',
  `kioskUuid` varchar(50) DEFAULT NULL,
  `resetId` varchar(50) DEFAULT NULL,
  `settlementId` varchar(50) NOT NULL DEFAULT '',
  `memberId` varchar(50) DEFAULT NULL,
  `paymentTypeId` varchar(50) DEFAULT NULL,
  `storeOutlesId` varchar(50) DEFAULT NULL,
  `terminalId` varchar(50) DEFAULT NULL,
  `struk` varchar(50) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `locked` tinyint(4) NOT NULL DEFAULT 0,
  `startDate` datetime(3) DEFAULT NULL,
  `endDate` datetime(3) DEFAULT NULL,
  `cashierId` varchar(50) DEFAULT NULL,
  `pthType` int(11) DEFAULT NULL,
  `subTotal` double DEFAULT 0,
  `discount` double DEFAULT 0,
  `discountMember` double DEFAULT 0,
  `voucher` double DEFAULT 0,
  `bkp` double DEFAULT 0,
  `dpp` double DEFAULT 0,
  `ppn` double DEFAULT 0,
  `nonBkp` double DEFAULT NULL,
  `finalPrice` double DEFAULT NULL,
  `photo` varchar(250) DEFAULT NULL,
  `userId` varchar(50) DEFAULT NULL,
  `cashDrawer` int(1) DEFAULT 0,
  `printing` int(1) DEFAULT 0,
  `presence` int(11) NOT NULL DEFAULT 1,
  `inputDate` int(11) DEFAULT NULL,
  `input_date` datetime DEFAULT '2023-01-01 00:00:00',
  `updateDate` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT '2023-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_transaction: ~0 rows (approximately)
DELETE FROM `cso1_transaction`;

-- Dumping structure for table pos2.cso1_transaction_detail
CREATE TABLE IF NOT EXISTS `cso1_transaction_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transactionId` varchar(50) DEFAULT NULL,
  `promotionId` varchar(50) DEFAULT NULL,
  `promotionFreeId` int(11) DEFAULT NULL,
  `promotionItemId` int(11) DEFAULT NULL,
  `promotionDiscountId` int(11) DEFAULT NULL,
  `itemId` varchar(50) DEFAULT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `originPrice` double DEFAULT 0,
  `price` double DEFAULT 0,
  `discount` double DEFAULT 0,
  `memberDiscountAmount` double DEFAULT 0,
  `memberDiscountPercent` double DEFAULT 0,
  `validationNota` int(1) DEFAULT 0,
  `isPriceEdit` int(11) DEFAULT 0,
  `isFreeItem` varchar(50) NOT NULL DEFAULT '',
  `isSpecialPrice` int(11) NOT NULL DEFAULT 0,
  `isPrintOnBill` int(11) NOT NULL DEFAULT 1,
  `note` varchar(250) DEFAULT NULL,
  `void` int(11) NOT NULL DEFAULT 0,
  `refund` varchar(50) NOT NULL DEFAULT '',
  `exchange` varchar(50) NOT NULL DEFAULT '',
  `presence` int(11) NOT NULL DEFAULT 1,
  `inputDate` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  `updateBy` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_transaction_detail: ~0 rows (approximately)
DELETE FROM `cso1_transaction_detail`;

-- Dumping structure for table pos2.cso1_transaction_payment
CREATE TABLE IF NOT EXISTS `cso1_transaction_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transactionId` varchar(50) NOT NULL DEFAULT '',
  `paymentTypeId` varchar(50) NOT NULL DEFAULT '',
  `paymentNameId` varchar(50) NOT NULL DEFAULT '',
  `amount` double DEFAULT NULL,
  `rounding` double DEFAULT NULL,
  `voucherNumber` varchar(50) DEFAULT '',
  `approvedCode` varchar(50) DEFAULT '',
  `refCode` varchar(50) DEFAULT '',
  `presence` int(11) NOT NULL DEFAULT 0,
  `inputDate` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  `input_date` datetime DEFAULT '2023-01-01 00:00:00',
  `update_date` datetime DEFAULT '2023-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_transaction_payment: ~18 rows (approximately)
DELETE FROM `cso1_transaction_payment`;
INSERT INTO `cso1_transaction_payment` (`id`, `transactionId`, `paymentTypeId`, `paymentNameId`, `amount`, `rounding`, `voucherNumber`, `approvedCode`, `refCode`, `presence`, `inputDate`, `updateDate`, `input_date`, `update_date`) VALUES
	(72, '123123.0112', 'CASH', '', 20000, NULL, NULL, '', '', 1, 1704970878, 1704970878, '2024-01-11 18:01:18', '2024-01-11 18:01:18'),
	(73, '123123.0112', 'CASH', '', 5000, NULL, NULL, '', '', 1, 1704970878, 1704970878, '2024-01-11 18:01:18', '2024-01-11 18:01:18'),
	(74, '123123.0112', 'CASH', '', 2, NULL, NULL, '', '', 1, 1704970878, 1704970878, '2024-01-11 18:01:18', '2024-01-11 18:01:18'),
	(75, '123123.0112', 'EDC_MANDIRI', '10', 13, NULL, NULL, '174901', '', 1, 1704970878, 1704970878, '2024-01-11 18:01:18', '2024-01-11 18:01:18'),
	(76, '123123.0112', 'EDC_MANDIRI', '12', 11, NULL, NULL, '175550', '', 1, 1704970878, 1704970878, '2024-01-11 18:01:18', '2024-01-11 18:01:18'),
	(77, '123123.0112', 'CASH', '', 500, NULL, NULL, '', '', 1, 1704970878, 1704970878, '2024-01-11 18:01:18', '2024-01-11 18:01:18'),
	(78, '123123.0112', 'DEBITCC', '10', 51, NULL, NULL, '555555', '', 1, 1704970878, 1704970878, '2024-01-11 18:01:18', '2024-01-11 18:01:18'),
	(79, '123123.0112', 'CASH', '', 171093, NULL, NULL, '', '', 1, 1704970878, 1704970878, '2024-01-11 18:01:18', '2024-01-11 18:01:18'),
	(95, '123123.0113', 'CASH', '', 104840, NULL, NULL, '', '', 1, 1704973809, 1704973809, '2024-01-11 18:50:09', '2024-01-11 18:50:09'),
	(96, '123123.0114', 'CASH', '', 50000, NULL, NULL, '', '', 1, 1704976028, 1704976028, '2024-01-11 19:27:08', '2024-01-11 19:27:08'),
	(97, '123123.0114', 'DEBITCC', '31', 80000, NULL, NULL, '0000001', '', 1, 1704976028, 1704976028, '2024-01-11 19:27:08', '2024-01-11 19:27:08'),
	(98, '123123.0114', 'CASH', '', 1272860, NULL, NULL, '', '', 1, 1704976028, 1704976028, '2024-01-11 19:27:08', '2024-01-11 19:27:08'),
	(99, '123123.0115', 'CASH', '', 188070, NULL, NULL, '', '', 1, 1705035225, 1705035225, '2024-01-12 11:53:45', '2024-01-12 11:53:45'),
	(100, '123123.0116', 'CASH', '', 87500, NULL, NULL, '', '', 1, 1705083708, 1705083708, '2024-01-13 01:21:48', '2024-01-13 01:21:48'),
	(101, '123123.0117', 'CASH', '', 122500, NULL, NULL, '', '', 1, 1705113618, 1705113618, '2024-01-13 09:40:18', '2024-01-13 09:40:18'),
	(104, '123123.0118', 'CASH', '', 87500, NULL, NULL, '', '', 1, 1705114312, 1705114312, '2024-01-13 09:51:52', '2024-01-13 09:51:52'),
	(106, '123123.0119', 'CASH', '', 68300, NULL, NULL, '', '', 1, 1705121075, 1705121075, '2024-01-13 11:44:35', '2024-01-13 11:44:35'),
	(107, '123123.0120', 'CASH', '', 599100, NULL, NULL, '', '', 1, 1705296353, 1705296353, '2024-01-15 12:25:53', '2024-01-15 12:25:53');

-- Dumping structure for table pos2.cso1_transaction_printlog
CREATE TABLE IF NOT EXISTS `cso1_transaction_printlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transactionId` varchar(50) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  `input_date` datetime DEFAULT '2023-01-01 00:00:00',
  `inputBy` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_transaction_printlog: ~0 rows (approximately)
DELETE FROM `cso1_transaction_printlog`;

-- Dumping structure for table pos2.cso1_user
CREATE TABLE IF NOT EXISTS `cso1_user` (
  `id` varchar(50) NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `userAccessId` int(11) DEFAULT NULL,
  `storeOutlesId` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `presence` int(11) NOT NULL DEFAULT 1,
  `saveFunc` varchar(250) DEFAULT NULL,
  `saveShortCut` varchar(250) DEFAULT NULL,
  `inputBy` int(11) DEFAULT NULL,
  `inputDate` int(11) DEFAULT NULL,
  `updateBy` int(11) DEFAULT NULL,
  `updateDate` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT '2023-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_user: ~2 rows (approximately)
DELETE FROM `cso1_user`;
INSERT INTO `cso1_user` (`id`, `name`, `userAccessId`, `storeOutlesId`, `password`, `status`, `presence`, `saveFunc`, `saveShortCut`, `inputBy`, `inputDate`, `updateBy`, `updateDate`, `update_date`) VALUES
	('123123', 'Cashier', 10, NULL, NULL, 1, 1, '[1,2,3,4,5,6,7,12,0,0,0,0]', NULL, NULL, NULL, NULL, 1698052381, '2023-10-23 09:13:01'),
	('123456789', 'Supervisor', 1, NULL, '4297f44b13955235245b2497399d7a93', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-01 00:00:00');

-- Dumping structure for table pos2.cso1_user_access
CREATE TABLE IF NOT EXISTS `cso1_user_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_user_access: ~4 rows (approximately)
DELETE FROM `cso1_user_access`;
INSERT INTO `cso1_user_access` (`id`, `name`) VALUES
	(1, 'Supervisor'),
	(2, 'IT'),
	(3, 'Management'),
	(10, 'Cashier');

-- Dumping structure for table pos2.cso1_user_auth
CREATE TABLE IF NOT EXISTS `cso1_user_auth` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `userId` varchar(50) NOT NULL DEFAULT '',
  `terminalId` varchar(50) NOT NULL DEFAULT '',
  `input_date` datetime NOT NULL DEFAULT '2024-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso1_user_auth: ~0 rows (approximately)
DELETE FROM `cso1_user_auth`;

-- Dumping structure for table pos2.cso1_user_func
CREATE TABLE IF NOT EXISTS `cso1_user_func` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(50) NOT NULL DEFAULT '',
  `number` int(2) NOT NULL DEFAULT 0,
  `color` varchar(50) NOT NULL DEFAULT '',
  `sorting` int(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table pos2.cso1_user_func: ~16 rows (approximately)
DELETE FROM `cso1_user_func`;
INSERT INTO `cso1_user_func` (`id`, `userId`, `number`, `color`, `sorting`) VALUES
	(25, '123123', 0, '', 1),
	(26, '123123', 0, '', 2),
	(27, '123123', 0, '', 1),
	(28, '123123', 0, '', 3),
	(29, '123123', 0, '', 4),
	(30, '123123', 0, '', 5),
	(31, '123123', 0, '', 6),
	(32, '123123', 0, '', 6),
	(33, '123123', 0, '', 7),
	(34, '123123', 0, '', 8),
	(35, '123123', 0, '', 9),
	(36, '123123', 0, '', 10),
	(37, '123123', 0, '', 10),
	(38, '123123', 0, '', 11),
	(39, '123123', 0, '', 12),
	(40, '123123', 0, '', 12);

-- Dumping structure for table pos2.cso2_balance
CREATE TABLE IF NOT EXISTS `cso2_balance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cashIn` int(11) NOT NULL DEFAULT 0,
  `cashOut` int(11) NOT NULL DEFAULT 0,
  `transactionId` varchar(50) NOT NULL DEFAULT '',
  `kioskUuid` varchar(50) NOT NULL DEFAULT '',
  `cashierId` varchar(50) NOT NULL,
  `terminalId` varchar(50) NOT NULL,
  `settlementId` varchar(50) NOT NULL,
  `close` int(1) NOT NULL DEFAULT 0,
  `input_date` datetime NOT NULL DEFAULT '2023-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso2_balance: ~0 rows (approximately)
DELETE FROM `cso2_balance`;

-- Dumping structure for table pos2.cso2_exchange
CREATE TABLE IF NOT EXISTS `cso2_exchange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kioskUuid` varchar(50) NOT NULL DEFAULT '',
  `exchange` varchar(50) NOT NULL DEFAULT '',
  `transactionId` varchar(50) NOT NULL DEFAULT '',
  `transactionDetailId` varchar(50) NOT NULL DEFAULT '',
  `itemId` varchar(50) NOT NULL DEFAULT '',
  `refundAmount` int(9) NOT NULL DEFAULT 0,
  `exchangeItemId` varchar(50) NOT NULL DEFAULT '',
  `exchangeAmount` int(9) NOT NULL DEFAULT 0,
  `input_date` datetime NOT NULL DEFAULT '2024-01-01 00:00:00',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso2_exchange: ~0 rows (approximately)
DELETE FROM `cso2_exchange`;

-- Dumping structure for table pos2.cso2_member
CREATE TABLE IF NOT EXISTS `cso2_member` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(250) NOT NULL DEFAULT 'no name',
  `status` varchar(50) NOT NULL DEFAULT '1',
  `expDate` varchar(50) NOT NULL DEFAULT '2024-01-01',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso2_member: ~0 rows (approximately)
DELETE FROM `cso2_member`;

-- Dumping structure for table pos2.cso2_payment_method
CREATE TABLE IF NOT EXISTS `cso2_payment_method` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `paymentTypeId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso2_payment_method: ~5 rows (approximately)
DELETE FROM `cso2_payment_method`;
INSERT INTO `cso2_payment_method` (`id`, `paymentTypeId`) VALUES
	(1, 'BCA01'),
	(2, 'BCA31'),
	(3, 'ID0007'),
	(4, 'QRT001'),
	(5, 'CASH');

-- Dumping structure for table pos2.cso2_refund
CREATE TABLE IF NOT EXISTS `cso2_refund` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `transactionId` varchar(50) NOT NULL DEFAULT '',
  `refundTotalAmount` int(9) NOT NULL DEFAULT 0,
  `terminalId` varchar(50) NOT NULL DEFAULT '',
  `inputDate` int(9) NOT NULL DEFAULT 0,
  `input_date` datetime NOT NULL DEFAULT '2024-01-01 00:00:00',
  `input_by` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso2_refund: ~0 rows (approximately)
DELETE FROM `cso2_refund`;

-- Dumping structure for table pos2.cso2_settlement
CREATE TABLE IF NOT EXISTS `cso2_settlement` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `total` int(4) NOT NULL DEFAULT 0,
  `amount` int(11) NOT NULL DEFAULT 0,
  `input_date` datetime NOT NULL DEFAULT '2023-01-01 00:00:00',
  `upload` int(1) NOT NULL DEFAULT 0,
  `upload_date` datetime NOT NULL DEFAULT '2023-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table pos2.cso2_settlement: ~0 rows (approximately)
DELETE FROM `cso2_settlement`;

-- Dumping structure for table pos2.voucher
CREATE TABLE IF NOT EXISTS `voucher` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `voucherMasterId` varchar(50) CHARACTER SET armscii8 COLLATE armscii8_general_ci NOT NULL DEFAULT '0',
  `number` varchar(50) NOT NULL DEFAULT '0',
  `amount` int(9) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `kioskUuid` varchar(50) CHARACTER SET armscii8 COLLATE armscii8_general_ci NOT NULL DEFAULT '',
  `transactionId` varchar(50) CHARACTER SET armscii8 COLLATE armscii8_general_ci NOT NULL DEFAULT '',
  `update_date` datetime NOT NULL DEFAULT '2024-01-01 00:00:00',
  `input_date` datetime NOT NULL DEFAULT '2024-01-01 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table pos2.voucher: ~0 rows (approximately)
DELETE FROM `voucher`;

-- Dumping structure for table pos2.voucher_master
CREATE TABLE IF NOT EXISTS `voucher_master` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(50) CHARACTER SET armscii8 COLLATE armscii8_general_ci NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `donwload` int(3) NOT NULL DEFAULT 0,
  `expDate` date DEFAULT '2026-01-01',
  `filename` varchar(50) DEFAULT NULL,
  `input_date` datetime NOT NULL DEFAULT '2024-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table pos2.voucher_master: ~0 rows (approximately)
DELETE FROM `voucher_master`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
