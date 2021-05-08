CREATE TABLE IF NOT EXISTS `solishopslocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `solishopsinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtienda` int(11) DEFAULT NULL,
  `iditem` varchar(50) DEFAULT NULL,
  `buyprice` int(11) NOT NULL,
  `sellprice` int(11) NOT NULL,
  `sellamount` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`iditem`) REFERENCES `items`(`name`),
  FOREIGN KEY (`idtienda`) REFERENCES `solishopslocations`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=latin1;