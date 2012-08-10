SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `cases`;
CREATE TABLE IF NOT EXISTS `cases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `createdBy` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `factory` tinyint(3) unsigned DEFAULT NULL,
  `machine` varchar(64) DEFAULT NULL,
  `device` varchar(64) DEFAULT NULL,
  `supporter` tinyint(3) unsigned DEFAULT NULL,
  `editingTime` int(10) unsigned NOT NULL DEFAULT '0',
  `cost` varchar(32) NOT NULL DEFAULT '',
  `subject` varchar(128) NOT NULL DEFAULT '',
  `problem` text NOT NULL,
  `diagnosis` text NOT NULL,
  `solution` text NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `kind` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `priority` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `supporter` (`supporter`),
  KEY `createdBy` (`createdBy`),
  KEY `factory` (`factory`),
  KEY `machine` (`machine`),
  KEY `device` (`device`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=55 ;

DROP TABLE IF EXISTS `case_categories`;
CREATE TABLE IF NOT EXISTS `case_categories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent` tinyint(3) unsigned DEFAULT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `catalog_categories`;
CREATE TABLE IF NOT EXISTS `catalog_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent` int(10) unsigned DEFAULT NULL,
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_name` (`parent`,`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=61 ;

DROP TABLE IF EXISTS `catalog_products`;
CREATE TABLE IF NOT EXISTS `catalog_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` int(10) unsigned NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `manufacturer` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_name` (`category`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=22 ;

DROP TABLE IF EXISTS `catalog_product_images`;
CREATE TABLE IF NOT EXISTS `catalog_product_images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product` int(10) unsigned NOT NULL,
  `file` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `file` (`file`),
  KEY `product` (`product`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

DROP TABLE IF EXISTS `declaration_templates`;
CREATE TABLE IF NOT EXISTS `declaration_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_polish_ci NOT NULL,
  `pattern` varchar(200) COLLATE utf8_polish_ci NOT NULL,
  `code` text COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=8 ;

DROP TABLE IF EXISTS `documentations`;
CREATE TABLE IF NOT EXISTS `documentations` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `machine` varchar(64) DEFAULT NULL,
  `device` varchar(64) DEFAULT NULL,
  `title` varchar(128) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `machine` (`machine`),
  KEY `device` (`device`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=222 ;

DROP TABLE IF EXISTS `documentation_files`;
CREATE TABLE IF NOT EXISTS `documentation_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documentation` smallint(5) unsigned NOT NULL DEFAULT '0',
  `file` varchar(128) NOT NULL DEFAULT '',
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `documentation` (`documentation`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=568 ;

DROP TABLE IF EXISTS `emails`;
CREATE TABLE IF NOT EXISTS `emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `createdAt` int(10) unsigned NOT NULL,
  `subject` varchar(200) COLLATE utf8_polish_ci NOT NULL,
  `from` varchar(100) COLLATE utf8_polish_ci NOT NULL,
  `to` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `body` text COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `to` (`to`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=11 ;

DROP TABLE IF EXISTS `email_attachments`;
CREATE TABLE IF NOT EXISTS `email_attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` int(10) unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8_polish_ci NOT NULL,
  `type` varchar(60) COLLATE utf8_polish_ci NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `data` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=4 ;

DROP TABLE IF EXISTS `engines`;
CREATE TABLE IF NOT EXISTS `engines` (
  `id` varchar(64) NOT NULL DEFAULT '',
  `machine` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`machine`),
  KEY `machine` (`machine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `variable` varchar(64) NOT NULL DEFAULT '',
  `factory` tinyint(3) unsigned DEFAULT NULL,
  `machine` varchar(64) DEFAULT NULL,
  `device` varchar(64) DEFAULT NULL,
  `operator` enum('==','!=','<','<=','>','>=') NOT NULL DEFAULT '==',
  `valueType` enum('concrete','min','max') NOT NULL DEFAULT 'concrete',
  `value` float(9,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variable` (`variable`),
  KEY `factory` (`factory`),
  KEY `machine` (`machine`),
  KEY `device` (`device`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `event_actions`;
CREATE TABLE IF NOT EXISTS `event_actions` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `event` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `type` varchar(32) NOT NULL DEFAULT '',
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `event` (`event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `factories`;
CREATE TABLE IF NOT EXISTS `factories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `latitude` decimal(18,15) NOT NULL DEFAULT '0.000000000000000',
  `longitude` decimal(18,15) NOT NULL DEFAULT '0.000000000000000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

DROP TABLE IF EXISTS `grid_views`;
CREATE TABLE IF NOT EXISTS `grid_views` (
  `grid` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `view` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `creator` tinyint(3) unsigned NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `options` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`view`),
  KEY `creator` (`creator`),
  KEY `grid` (`grid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `grid_view_defaults`;
CREATE TABLE IF NOT EXISTS `grid_view_defaults` (
  `grid` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `view` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`grid`,`user`),
  KEY `view` (`view`),
  KEY `user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `help`;
CREATE TABLE IF NOT EXISTS `help` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent` int(10) unsigned DEFAULT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `title` varchar(128) NOT NULL DEFAULT '',
  `contents` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=45 ;

DROP TABLE IF EXISTS `help_tags`;
CREATE TABLE IF NOT EXISTS `help_tags` (
  `tag` varchar(64) NOT NULL DEFAULT '',
  `page` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`tag`,`page`),
  KEY `tag` (`tag`),
  KEY `page` (`page`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `issues`;
CREATE TABLE IF NOT EXISTS `issues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `creator` tinyint(3) unsigned NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  `updatedAt` int(10) unsigned NOT NULL,
  `owner` tinyint(3) unsigned DEFAULT NULL,
  `ownerStakes` decimal(10,2) unsigned NOT NULL,
  `ownerStakesType` tinyint(1) unsigned NOT NULL,
  `subject` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `relatedFactory` tinyint(3) unsigned DEFAULT NULL,
  `relatedMachine` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `relatedDevice` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `priority` tinyint(1) NOT NULL DEFAULT '2',
  `kind` tinyint(1) NOT NULL DEFAULT '3',
  `type` tinyint(1) NOT NULL DEFAULT '4',
  `orderNumber` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orderDate` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orderInvoice` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orderInvoiceDate` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expectedFinishAt` date DEFAULT NULL,
  `percent` float DEFAULT NULL,
  `quantity` decimal(10,4) unsigned NOT NULL DEFAULT '1.0000',
  `unit` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'szt.',
  `currency` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'PLN',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `per` int(11) unsigned NOT NULL DEFAULT '1',
  `vat` tinyint(3) unsigned NOT NULL DEFAULT '23',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  KEY `creator` (`creator`),
  KEY `relatedFactory` (`relatedFactory`),
  KEY `relatedMachine` (`relatedMachine`),
  KEY `relatedDevice` (`relatedDevice`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=377 ;

DROP TABLE IF EXISTS `issue_assignees`;
CREATE TABLE IF NOT EXISTS `issue_assignees` (
  `issue` int(10) unsigned NOT NULL,
  `assignee` tinyint(3) unsigned NOT NULL,
  `stakes` decimal(10,2) unsigned NOT NULL,
  `stakesType` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`issue`,`assignee`),
  KEY `assignee` (`assignee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `issue_emails`;
CREATE TABLE IF NOT EXISTS `issue_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

DROP TABLE IF EXISTS `issue_files`;
CREATE TABLE IF NOT EXISTS `issue_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `issue` int(10) unsigned NOT NULL,
  `uploader` tinyint(3) unsigned NOT NULL,
  `uploadedAt` int(10) unsigned NOT NULL,
  `file` varchar(60) COLLATE utf8_polish_ci NOT NULL,
  `name` varchar(200) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue` (`issue`),
  KEY `uploader` (`uploader`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=281 ;

DROP TABLE IF EXISTS `issue_history`;
CREATE TABLE IF NOT EXISTS `issue_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `issue` int(10) unsigned NOT NULL,
  `parent` int(10) unsigned DEFAULT NULL,
  `system` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` int(10) unsigned NOT NULL,
  `createdBy` tinyint(3) unsigned NOT NULL,
  `changes` text COLLATE utf8_unicode_ci,
  `tasks` text COLLATE utf8_unicode_ci,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue` (`issue`),
  KEY `createdBy` (`createdBy`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1789 ;

DROP TABLE IF EXISTS `issue_relations`;
CREATE TABLE IF NOT EXISTS `issue_relations` (
  `issue1` int(10) unsigned NOT NULL,
  `issue2` int(10) unsigned NOT NULL,
  PRIMARY KEY (`issue1`,`issue2`),
  KEY `issue2` (`issue2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `issue_subscribers`;
CREATE TABLE IF NOT EXISTS `issue_subscribers` (
  `issue` int(10) unsigned NOT NULL,
  `user` tinyint(3) unsigned NOT NULL,
  `recentlyNotifiedAt` int(10) unsigned NOT NULL,
  PRIMARY KEY (`issue`,`user`),
  KEY `user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `issue_tasks`;
CREATE TABLE IF NOT EXISTS `issue_tasks` (
  `id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `issue` int(1) unsigned NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  `createdBy` tinyint(3) unsigned NOT NULL,
  `assignedTo` tinyint(3) unsigned DEFAULT NULL,
  `completedAt` int(10) unsigned DEFAULT NULL,
  `completedBy` tinyint(3) unsigned DEFAULT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `summary` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `position` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue` (`issue`),
  KEY `completedBy` (`completedBy`),
  KEY `createdBy` (`createdBy`),
  KEY `assignedTo` (`assignedTo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1149 ;

DROP TABLE IF EXISTS `issue_templates`;
CREATE TABLE IF NOT EXISTS `issue_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `createdBy` tinyint(3) unsigned NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `createdBy` (`createdBy`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=7 ;

DROP TABLE IF EXISTS `issue_template_tasks`;
CREATE TABLE IF NOT EXISTS `issue_template_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template` int(10) unsigned NOT NULL,
  `summary` varchar(255) COLLATE utf8_polish_ci NOT NULL,
  `description` text COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `template` (`template`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=37 ;

DROP TABLE IF EXISTS `issue_times`;
CREATE TABLE IF NOT EXISTS `issue_times` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `issue` int(10) unsigned NOT NULL,
  `user` tinyint(3) unsigned NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  `timeSpent` int(10) unsigned NOT NULL,
  `comment` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue` (`issue`),
  KEY `user` (`user`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=19 ;

DROP TABLE IF EXISTS `limits`;
CREATE TABLE IF NOT EXISTS `limits` (
  `machine` varchar(64) NOT NULL DEFAULT '',
  `device` varchar(64) NOT NULL DEFAULT '',
  `variable` varchar(64) NOT NULL DEFAULT '',
  `min` float(9,5) NOT NULL DEFAULT '0.00000',
  `max` float(9,5) NOT NULL DEFAULT '0.00000',
  PRIMARY KEY (`device`,`variable`,`machine`),
  KEY `variable` (`variable`),
  KEY `machine` (`machine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `logs`;
CREATE TABLE IF NOT EXISTS `logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user` tinyint(3) unsigned DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip` varchar(40) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5377 ;

DROP TABLE IF EXISTS `machines`;
CREATE TABLE IF NOT EXISTS `machines` (
  `id` varchar(64) NOT NULL DEFAULT '',
  `factory` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `factory` (`factory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `news`;
CREATE TABLE IF NOT EXISTS `news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `createdBy` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `title` varchar(128) NOT NULL DEFAULT '',
  `introduction` text NOT NULL,
  `body` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `createdBy` (`createdBy`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

DROP TABLE IF EXISTS `offers`;
CREATE TABLE IF NOT EXISTS `offers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `issue` int(10) unsigned DEFAULT NULL,
  `number` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `createdAt` date NOT NULL,
  `closedAt` date DEFAULT NULL,
  `title` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `client` text COLLATE utf8_unicode_ci NOT NULL,
  `clientContact` text COLLATE utf8_unicode_ci NOT NULL,
  `supplier` text COLLATE utf8_unicode_ci NOT NULL,
  `supplierContact` text COLLATE utf8_unicode_ci NOT NULL,
  `intro` text COLLATE utf8_unicode_ci NOT NULL,
  `outro` text COLLATE utf8_unicode_ci NOT NULL,
  `sentTo` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `issue` (`issue`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=145 ;

DROP TABLE IF EXISTS `offer_items`;
CREATE TABLE IF NOT EXISTS `offer_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `offer` int(10) unsigned NOT NULL,
  `issue` int(10) unsigned DEFAULT NULL,
  `position` tinyint(3) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `quantity` decimal(10,4) unsigned NOT NULL,
  `unit` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'szt.',
  `currency` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'PLN',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `per` int(11) NOT NULL DEFAULT '1',
  `vat` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `offer` (`offer`),
  KEY `issue` (`issue`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1644 ;

DROP TABLE IF EXISTS `offer_templates`;
CREATE TABLE IF NOT EXISTS `offer_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `template` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

DROP TABLE IF EXISTS `plc_devices`;
CREATE TABLE IF NOT EXISTS `plc_devices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `machine` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `initialValue` float(16,8) NOT NULL DEFAULT '0.00000000',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `kind` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `comment1` text COLLATE utf8_unicode_ci NOT NULL,
  `comment2` text COLLATE utf8_unicode_ci NOT NULL,
  `comment3` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `machine` (`machine`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

DROP TABLE IF EXISTS `plc_machines`;
CREATE TABLE IF NOT EXISTS `plc_machines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `comments` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

DROP TABLE IF EXISTS `plc_modules`;
CREATE TABLE IF NOT EXISTS `plc_modules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `machine` int(10) unsigned NOT NULL DEFAULT '0',
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `machine` (`machine`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

DROP TABLE IF EXISTS `plc_module_elements`;
CREATE TABLE IF NOT EXISTS `plc_module_elements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` int(10) unsigned NOT NULL DEFAULT '0',
  `element` int(10) unsigned NOT NULL DEFAULT '0',
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `module_2` (`module`,`element`),
  KEY `module` (`module`),
  KEY `element` (`element`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

DROP TABLE IF EXISTS `plc_module_types`;
CREATE TABLE IF NOT EXISTS `plc_module_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `inputs` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `outputs` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `role_privilages`;
CREATE TABLE IF NOT EXISTS `role_privilages` (
  `role` varchar(64) NOT NULL DEFAULT '',
  `privilage` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`role`,`privilage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `storages`;
CREATE TABLE IF NOT EXISTS `storages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=36 ;

DROP TABLE IF EXISTS `storage_products`;
CREATE TABLE IF NOT EXISTS `storage_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `storage` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `index` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `supplier` text COLLATE utf8_unicode_ci NOT NULL,
  `contact` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uniq_in_storage` (`storage`,`index`),
  KEY `storage` (`storage`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=725 ;

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(64) DEFAULT NULL,
  `super` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(128) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(128) NOT NULL DEFAULT '',
  `createdAt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lastVisitAt` datetime DEFAULT NULL,
  `allowedFactories` text,
  `allowedMachines` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `credentials` (`email`,`password`),
  KEY `role` (`role`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=42 ;

DROP TABLE IF EXISTS `values`;
CREATE TABLE IF NOT EXISTS `values` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `machine` varchar(64) NOT NULL DEFAULT '',
  `engine` varchar(64) NOT NULL DEFAULT '',
  `variable` varchar(64) NOT NULL DEFAULT '',
  `value` float(10,2) NOT NULL DEFAULT '0.00',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `variable` (`variable`),
  KEY `machine` (`machine`),
  KEY `engine` (`engine`),
  KEY `dev_var` (`variable`,`machine`,`engine`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

DROP TABLE IF EXISTS `variables`;
CREATE TABLE IF NOT EXISTS `variables` (
  `id` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `vis_factories`;
CREATE TABLE IF NOT EXISTS `vis_factories` (
  `factory` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `width` smallint(5) unsigned NOT NULL DEFAULT '640',
  `height` smallint(5) unsigned NOT NULL DEFAULT '480',
  `fg_color` varchar(32) NOT NULL DEFAULT 'black',
  `bg_color` varchar(32) NOT NULL DEFAULT 'transparent',
  `bg_image` varchar(128) NOT NULL DEFAULT 'none',
  `bg_position` varchar(32) NOT NULL DEFAULT 'center center',
  `bg_repeat` varchar(9) NOT NULL DEFAULT 'no-repeat',
  PRIMARY KEY (`factory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `vis_factory_machines`;
CREATE TABLE IF NOT EXISTS `vis_factory_machines` (
  `machine` varchar(64) NOT NULL DEFAULT '',
  `top` smallint(6) NOT NULL DEFAULT '0',
  `left` smallint(6) NOT NULL DEFAULT '0',
  `zindex` smallint(5) unsigned NOT NULL DEFAULT '0',
  `image` varchar(128) NOT NULL DEFAULT 'default.gif',
  `image_width` int(11) NOT NULL DEFAULT '200',
  `image_height` int(11) NOT NULL DEFAULT '200',
  `image_max_width` int(11) NOT NULL DEFAULT '400',
  `image_max_height` int(11) NOT NULL DEFAULT '450',
  `fg_color` varchar(32) NOT NULL DEFAULT 'inherit',
  `bg_color` varchar(32) NOT NULL DEFAULT 'transparent',
  PRIMARY KEY (`machine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `vis_machines`;
CREATE TABLE IF NOT EXISTS `vis_machines` (
  `machine` varchar(64) NOT NULL DEFAULT '',
  `width` smallint(5) unsigned NOT NULL DEFAULT '640',
  `height` smallint(5) unsigned NOT NULL DEFAULT '480',
  `fg_color` varchar(32) NOT NULL DEFAULT 'black',
  `bg_color` varchar(32) NOT NULL DEFAULT 'transparent',
  `bg_image` varchar(128) NOT NULL DEFAULT 'none',
  `bg_position` varchar(32) NOT NULL DEFAULT 'center center',
  `bg_repeat` varchar(9) NOT NULL DEFAULT 'no-repeat',
  PRIMARY KEY (`machine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `vis_machine_devices`;
CREATE TABLE IF NOT EXISTS `vis_machine_devices` (
  `machine` varchar(64) NOT NULL DEFAULT '',
  `device` varchar(64) NOT NULL DEFAULT '',
  `top` smallint(6) NOT NULL DEFAULT '0',
  `left` smallint(6) NOT NULL DEFAULT '0',
  `zindex` smallint(5) unsigned NOT NULL DEFAULT '0',
  `image` varchar(128) NOT NULL DEFAULT 'default.gif',
  `image_width` int(11) NOT NULL DEFAULT '200',
  `image_height` int(11) NOT NULL DEFAULT '200',
  `image_max_width` int(11) NOT NULL DEFAULT '400',
  `image_max_height` int(11) NOT NULL DEFAULT '450',
  `fg_color` varchar(32) NOT NULL DEFAULT 'inherit',
  `bg_color` varchar(32) NOT NULL DEFAULT 'transparent',
  `variables_fg_color` varchar(32) NOT NULL DEFAULT 'inherit',
  `variables_bg_color` varchar(32) NOT NULL DEFAULT 'transparent',
  PRIMARY KEY (`device`,`machine`),
  KEY `machine` (`machine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `vis_machine_device_variables`;
CREATE TABLE IF NOT EXISTS `vis_machine_device_variables` (
  `machine` varchar(64) NOT NULL DEFAULT '',
  `device` varchar(64) NOT NULL DEFAULT '',
  `variable` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`device`,`variable`,`machine`),
  KEY `variable` (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `cases`
  ADD CONSTRAINT `cases_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cases_ibfk_2` FOREIGN KEY (`factory`) REFERENCES `factories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cases_ibfk_4` FOREIGN KEY (`device`) REFERENCES `engines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cases_ibfk_5` FOREIGN KEY (`supporter`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cases_ibfk_6` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cases_ibfk_7` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cases_ibfk_8` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE;

ALTER TABLE `case_categories`
  ADD CONSTRAINT `case_categories_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `case_categories` (`id`) ON DELETE CASCADE;

ALTER TABLE `catalog_categories`
  ADD CONSTRAINT `catalog_categories_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `catalog_categories` (`id`) ON DELETE CASCADE;

ALTER TABLE `catalog_products`
  ADD CONSTRAINT `catalog_products_ibfk_1` FOREIGN KEY (`category`) REFERENCES `catalog_categories` (`id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_images`
  ADD CONSTRAINT `catalog_product_images_ibfk_1` FOREIGN KEY (`product`) REFERENCES `catalog_products` (`id`) ON DELETE CASCADE;

ALTER TABLE `documentations`
  ADD CONSTRAINT `documentations_ibfk_2` FOREIGN KEY (`device`) REFERENCES `engines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `documentations_ibfk_3` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `documentations_ibfk_4` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE;

ALTER TABLE `documentation_files`
  ADD CONSTRAINT `documentation_files_ibfk_1` FOREIGN KEY (`documentation`) REFERENCES `documentations` (`id`) ON DELETE CASCADE;

ALTER TABLE `email_attachments`
  ADD CONSTRAINT `email_attachments_ibfk_1` FOREIGN KEY (`email`) REFERENCES `emails` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `engines`
  ADD CONSTRAINT `engines_ibfk_1` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`variable`) REFERENCES `variables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`factory`) REFERENCES `factories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `events_ibfk_4` FOREIGN KEY (`device`) REFERENCES `engines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `events_ibfk_5` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE;

ALTER TABLE `event_actions`
  ADD CONSTRAINT `event_actions_ibfk_1` FOREIGN KEY (`event`) REFERENCES `events` (`id`) ON DELETE CASCADE;

ALTER TABLE `grid_view_defaults`
  ADD CONSTRAINT `grid_view_defaults_ibfk_2` FOREIGN KEY (`view`) REFERENCES `grid_views` (`view`) ON DELETE CASCADE,
  ADD CONSTRAINT `grid_view_defaults_ibfk_3` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `help`
  ADD CONSTRAINT `help_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `help` (`id`) ON DELETE CASCADE;

ALTER TABLE `help_tags`
  ADD CONSTRAINT `help_tags_ibfk_1` FOREIGN KEY (`page`) REFERENCES `help` (`id`) ON DELETE CASCADE;

ALTER TABLE `issues`
  ADD CONSTRAINT `issues_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issues_ibfk_2` FOREIGN KEY (`owner`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issues_ibfk_3` FOREIGN KEY (`relatedFactory`) REFERENCES `factories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issues_ibfk_4` FOREIGN KEY (`relatedMachine`) REFERENCES `machines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `issues_ibfk_5` FOREIGN KEY (`relatedDevice`) REFERENCES `engines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `issue_assignees`
  ADD CONSTRAINT `issue_assignees_ibfk_1` FOREIGN KEY (`assignee`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_assignees_ibfk_2` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`) ON DELETE CASCADE;

ALTER TABLE `issue_files`
  ADD CONSTRAINT `issue_files_ibfk_1` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_files_ibfk_2` FOREIGN KEY (`uploader`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `issue_history`
  ADD CONSTRAINT `issue_history_ibfk_1` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_history_ibfk_2` FOREIGN KEY (`parent`) REFERENCES `issue_history` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_history_ibfk_3` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `issue_relations`
  ADD CONSTRAINT `issue_relations_ibfk_1` FOREIGN KEY (`issue1`) REFERENCES `issues` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_relations_ibfk_2` FOREIGN KEY (`issue2`) REFERENCES `issues` (`id`) ON DELETE CASCADE;

ALTER TABLE `issue_subscribers`
  ADD CONSTRAINT `issue_subscribers_ibfk_1` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_subscribers_ibfk_2` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `issue_tasks`
  ADD CONSTRAINT `issue_tasks_ibfk_1` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_tasks_ibfk_3` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_tasks_ibfk_4` FOREIGN KEY (`completedBy`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `issue_tasks_ibfk_5` FOREIGN KEY (`assignedTo`) REFERENCES `users` (`id`) ON DELETE SET NULL;

ALTER TABLE `issue_template_tasks`
  ADD CONSTRAINT `template` FOREIGN KEY (`template`) REFERENCES `issue_templates` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `issue_times`
  ADD CONSTRAINT `issue_times_ibfk_1` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_times_ibfk_2` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_times_ibfk_3` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_times_ibfk_4` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `limits`
  ADD CONSTRAINT `limits_ibfk_1` FOREIGN KEY (`device`) REFERENCES `engines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `limits_ibfk_2` FOREIGN KEY (`variable`) REFERENCES `variables` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `limits_ibfk_3` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE;

ALTER TABLE `machines`
  ADD CONSTRAINT `machines_ibfk_1` FOREIGN KEY (`factory`) REFERENCES `factories` (`id`) ON DELETE CASCADE;

ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `offers`
  ADD CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`) ON DELETE SET NULL;

ALTER TABLE `offer_items`
  ADD CONSTRAINT `offer_items_ibfk_1` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `offer_items_ibfk_2` FOREIGN KEY (`offer`) REFERENCES `offers` (`id`) ON DELETE CASCADE;

ALTER TABLE `plc_devices`
  ADD CONSTRAINT `plc_devices_ibfk_1` FOREIGN KEY (`machine`) REFERENCES `plc_machines` (`id`) ON DELETE CASCADE;

ALTER TABLE `plc_modules`
  ADD CONSTRAINT `plc_modules_ibfk_1` FOREIGN KEY (`type`) REFERENCES `plc_module_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plc_modules_ibfk_2` FOREIGN KEY (`machine`) REFERENCES `plc_machines` (`id`) ON DELETE CASCADE;

ALTER TABLE `plc_module_elements`
  ADD CONSTRAINT `plc_module_elements_ibfk_1` FOREIGN KEY (`module`) REFERENCES `plc_modules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plc_module_elements_ibfk_2` FOREIGN KEY (`element`) REFERENCES `plc_devices` (`id`) ON DELETE CASCADE;

ALTER TABLE `role_privilages`
  ADD CONSTRAINT `role_privilages_ibfk_1` FOREIGN KEY (`role`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `storages`
  ADD CONSTRAINT `storages_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `storage_products`
  ADD CONSTRAINT `storage_products_ibfk_1` FOREIGN KEY (`storage`) REFERENCES `storages` (`id`) ON DELETE CASCADE;

ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role`) REFERENCES `roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `values`
  ADD CONSTRAINT `values_ibfk_1` FOREIGN KEY (`engine`) REFERENCES `engines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `values_ibfk_2` FOREIGN KEY (`variable`) REFERENCES `variables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `values_ibfk_3` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `vis_factories`
  ADD CONSTRAINT `vis_factories_ibfk_1` FOREIGN KEY (`factory`) REFERENCES `factories` (`id`) ON DELETE CASCADE;

ALTER TABLE `vis_factory_machines`
  ADD CONSTRAINT `vis_factory_machines_ibfk_1` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vis_factory_machines_ibfk_2` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE;

ALTER TABLE `vis_machines`
  ADD CONSTRAINT `vis_machines_ibfk_1` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vis_machines_ibfk_2` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE;

ALTER TABLE `vis_machine_devices`
  ADD CONSTRAINT `vis_machine_devices_ibfk_1` FOREIGN KEY (`device`) REFERENCES `engines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vis_machine_devices_ibfk_2` FOREIGN KEY (`machine`) REFERENCES `machines` (`id`) ON DELETE CASCADE;

ALTER TABLE `vis_machine_device_variables`
  ADD CONSTRAINT `vis_machine_device_variables_ibfk_3` FOREIGN KEY (`device`) REFERENCES `engines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vis_machine_device_variables_ibfk_4` FOREIGN KEY (`variable`) REFERENCES `variables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;