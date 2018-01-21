PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE user(id integer not null primary key autoincrement, name text not null unique);
CREATE TABLE filter_type(id integer not null primary key autoincrement, name text not null unique);
INSERT INTO "filter_type" VALUES(1,'pokemons');
INSERT INTO "filter_type" VALUES(2,'gyms');
CREATE TABLE user_filter(id integer not null primary key autoincrement, userid integer not null references user(id), filterid integer not null references filter(id));
CREATE TABLE filter_condition(id integer not null primary key autoincrement, filterid integer not null references filter(id), key text not null, value text not null, operator integer not null default 4 references filter_condition(id));
INSERT INTO "filter_condition" VALUES(1,1,'pokemon_id','249',4);
INSERT INTO "filter_condition" VALUES(2,1,'pokemon_id','250',4);
INSERT INTO "filter_condition" VALUES(3,1,'pokemon_id','251',4);
INSERT INTO "filter_condition" VALUES(4,2,'pokemon_id','147',4);
INSERT INTO "filter_condition" VALUES(5,2,'pokemon_id','148',4);
INSERT INTO "filter_condition" VALUES(6,2,'pokemon_id','149',4);
INSERT INTO "filter_condition" VALUES(7,3,'pokemon_id','74',4);
INSERT INTO "filter_condition" VALUES(8,3,'pokemon_id','75',4);
INSERT INTO "filter_condition" VALUES(9,3,'pokemon_id','76',4);
INSERT INTO "filter_condition" VALUES(10,4,'pokemon_id','66',4);
INSERT INTO "filter_condition" VALUES(11,4,'pokemon_id','67',4);
INSERT INTO "filter_condition" VALUES(12,4,'pokemon_id','68',4);
INSERT INTO "filter_condition" VALUES(13,5,'pokemon_id','63',4);
INSERT INTO "filter_condition" VALUES(14,5,'pokemon_id','64',4);
INSERT INTO "filter_condition" VALUES(15,5,'pokemon_id','65',4);
INSERT INTO "filter_condition" VALUES(16,6,'pokemon_id','113',4);
INSERT INTO "filter_condition" VALUES(17,6,'pokemon_id','242',4);
INSERT INTO "filter_condition" VALUES(18,7,'pokemon_id','143',4);
INSERT INTO "filter_condition" VALUES(19,8,'pokemon_id','201',4);
INSERT INTO "filter_condition" VALUES(20,9,'pokemon_id','133',4);
INSERT INTO "filter_condition" VALUES(21,9,'cp','840',5);
INSERT INTO "filter_condition" VALUES(22,10,'pokemon_id','129',4);
INSERT INTO "filter_condition" VALUES(23,10,'cp','180',5);
INSERT INTO "filter_condition" VALUES(24,11,'pokemon_id','81',4);
INSERT INTO "filter_condition" VALUES(25,11,'pokemon_id','82',4);
INSERT INTO "filter_condition" VALUES(26,11,'pokemon_id','205',4);
INSERT INTO "filter_condition" VALUES(27,11,'pokemon_id','208',4);
INSERT INTO "filter_condition" VALUES(28,11,'pokemon_id','212',4);
INSERT INTO "filter_condition" VALUES(29,11,'pokemon_id','227',4);
INSERT INTO "filter_condition" VALUES(30,11,'pokemon_id','303',4);
INSERT INTO "filter_condition" VALUES(31,11,'pokemon_id','304',4);
INSERT INTO "filter_condition" VALUES(32,11,'pokemon_id','305',4);
INSERT INTO "filter_condition" VALUES(33,11,'pokemon_id','306',4);
INSERT INTO "filter_condition" VALUES(34,11,'pokemon_id','374',4);
INSERT INTO "filter_condition" VALUES(35,11,'pokemon_id','375',4);
INSERT INTO "filter_condition" VALUES(36,11,'pokemon_id','376',4);
INSERT INTO "filter_condition" VALUES(37,11,'pokemon_id','379',4);
INSERT INTO "filter_condition" VALUES(38,11,'pokemon_id','385',4);
INSERT INTO "filter_condition" VALUES(40,12,'individual_attack','15',4);
INSERT INTO "filter_condition" VALUES(41,12,'individual_defense','15',4);
INSERT INTO "filter_condition" VALUES(42,12,'individual_stamina','15',4);
INSERT INTO "filter_condition" VALUES(43,13,'raid_pokemon_id','248',4);
INSERT INTO "filter_condition" VALUES(44,14,'raid_pokemon_id','68',4);
INSERT INTO "filter_condition" VALUES(45,15,'raid_pokemon_id','65',4);
INSERT INTO "filter_condition" VALUES(46,16,'raid_pokemon_id','38',4);
INSERT INTO "filter_condition" VALUES(47,17,'raid_pokemon_id','38',4);
INSERT INTO "filter_condition" VALUES(48,17,'raid_pokemon_move_1','116',3);
INSERT INTO "filter_condition" VALUES(49,18,'raid_level','3',5);
INSERT INTO "filter_condition" VALUES(50,20,'pokemon_id','252',4);
INSERT INTO "filter_condition" VALUES(51,20,'pokemon_id','253',4);
INSERT INTO "filter_condition" VALUES(52,20,'pokemon_id','254',4);
INSERT INTO "filter_condition" VALUES(53,21,'pokemon_id','255',4);
INSERT INTO "filter_condition" VALUES(54,21,'pokemon_id','256',4);
INSERT INTO "filter_condition" VALUES(55,21,'pokemon_id','257',4);
INSERT INTO "filter_condition" VALUES(56,22,'pokemon_id','258',4);
INSERT INTO "filter_condition" VALUES(57,22,'pokemon_id','259',4);
INSERT INTO "filter_condition" VALUES(58,22,'pokemon_id','260',4);
INSERT INTO "filter_condition" VALUES(59,23,'pokemon_id','261',4);
INSERT INTO "filter_condition" VALUES(60,23,'pokemon_id','262',4);
INSERT INTO "filter_condition" VALUES(61,24,'pokemon_id','263',4);
INSERT INTO "filter_condition" VALUES(62,24,'pokemon_id','264',4);
INSERT INTO "filter_condition" VALUES(63,25,'pokemon_id','265',4);
INSERT INTO "filter_condition" VALUES(64,25,'pokemon_id','266',4);
INSERT INTO "filter_condition" VALUES(65,25,'pokemon_id','267',4);
INSERT INTO "filter_condition" VALUES(66,25,'pokemon_id','268',4);
INSERT INTO "filter_condition" VALUES(67,25,'pokemon_id','269',4);
INSERT INTO "filter_condition" VALUES(68,26,'pokemon_id','273',4);
INSERT INTO "filter_condition" VALUES(69,26,'pokemon_id','274',4);
INSERT INTO "filter_condition" VALUES(70,26,'pokemon_id','275',4);
INSERT INTO "filter_condition" VALUES(71,27,'pokemon_id','280',4);
INSERT INTO "filter_condition" VALUES(72,27,'pokemon_id','281',4);
INSERT INTO "filter_condition" VALUES(73,27,'pokemon_id','282',4);
INSERT INTO "filter_condition" VALUES(74,28,'pokemon_id','285',4);
INSERT INTO "filter_condition" VALUES(75,28,'pokemon_id','286',4);
INSERT INTO "filter_condition" VALUES(76,29,'pokemon_id','287',4);
INSERT INTO "filter_condition" VALUES(77,29,'pokemon_id','288',4);
INSERT INTO "filter_condition" VALUES(78,29,'pokemon_id','289',4);
INSERT INTO "filter_condition" VALUES(79,30,'pokemon_id','296',4);
INSERT INTO "filter_condition" VALUES(80,30,'pokemon_id','297',4);
INSERT INTO "filter_condition" VALUES(81,31,'pokemon_id','300',4);
INSERT INTO "filter_condition" VALUES(82,31,'pokemon_id','301',4);
INSERT INTO "filter_condition" VALUES(83,32,'pokemon_id','307',4);
INSERT INTO "filter_condition" VALUES(84,32,'pokemon_id','308',4);
INSERT INTO "filter_condition" VALUES(85,33,'pokemon_id','309',4);
INSERT INTO "filter_condition" VALUES(86,33,'pokemon_id','310',4);
INSERT INTO "filter_condition" VALUES(87,34,'pokemon_id','316',4);
INSERT INTO "filter_condition" VALUES(88,34,'pokemon_id','317',4);
INSERT INTO "filter_condition" VALUES(89,35,'pokemon_id','325',4);
INSERT INTO "filter_condition" VALUES(90,35,'pokemon_id','326',4);
INSERT INTO "filter_condition" VALUES(91,36,'level','35',4);
INSERT INTO "filter_condition" VALUES(92,37,'pokemon_id','3',4);
INSERT INTO "filter_condition" VALUES(93,37,'pokemon_id','6',4);
INSERT INTO "filter_condition" VALUES(94,37,'pokemon_id','9',4);
INSERT INTO "filter_condition" VALUES(95,37,'pokemon_id','12',4);
INSERT INTO "filter_condition" VALUES(96,37,'pokemon_id','15',4);
INSERT INTO "filter_condition" VALUES(97,37,'pokemon_id','18',4);
INSERT INTO "filter_condition" VALUES(98,37,'pokemon_id','31',4);
INSERT INTO "filter_condition" VALUES(99,37,'pokemon_id','34',4);
INSERT INTO "filter_condition" VALUES(100,37,'pokemon_id','45',4);
INSERT INTO "filter_condition" VALUES(101,37,'pokemon_id','62',4);
INSERT INTO "filter_condition" VALUES(102,37,'pokemon_id','65',4);
INSERT INTO "filter_condition" VALUES(103,37,'pokemon_id','68',4);
INSERT INTO "filter_condition" VALUES(104,37,'pokemon_id','71',4);
INSERT INTO "filter_condition" VALUES(105,37,'pokemon_id','76',4);
INSERT INTO "filter_condition" VALUES(106,37,'pokemon_id','94',4);
INSERT INTO "filter_condition" VALUES(107,37,'pokemon_id','149',4);
INSERT INTO "filter_condition" VALUES(108,37,'pokemon_id','154',4);
INSERT INTO "filter_condition" VALUES(109,37,'pokemon_id','157',4);
INSERT INTO "filter_condition" VALUES(110,37,'pokemon_id','160',4);
INSERT INTO "filter_condition" VALUES(111,37,'pokemon_id','169',4);
INSERT INTO "filter_condition" VALUES(112,37,'pokemon_id','181',4);
INSERT INTO "filter_condition" VALUES(113,37,'pokemon_id','189',4);
INSERT INTO "filter_condition" VALUES(114,37,'pokemon_id','248',4);
INSERT INTO "filter_condition" VALUES(115,37,'pokemon_id','254',4);
INSERT INTO "filter_condition" VALUES(116,37,'pokemon_id','257',4);
INSERT INTO "filter_condition" VALUES(117,37,'pokemon_id','260',4);
INSERT INTO "filter_condition" VALUES(118,37,'pokemon_id','267',4);
INSERT INTO "filter_condition" VALUES(119,37,'pokemon_id','269',4);
INSERT INTO "filter_condition" VALUES(120,37,'pokemon_id','272',4);
INSERT INTO "filter_condition" VALUES(121,37,'pokemon_id','275',4);
INSERT INTO "filter_condition" VALUES(122,37,'pokemon_id','282',4);
INSERT INTO "filter_condition" VALUES(123,37,'pokemon_id','289',4);
INSERT INTO "filter_condition" VALUES(124,37,'pokemon_id','295',4);
INSERT INTO "filter_condition" VALUES(125,37,'pokemon_id','306',4);
INSERT INTO "filter_condition" VALUES(126,37,'pokemon_id','330',4);
INSERT INTO "filter_condition" VALUES(127,37,'pokemon_id','365',4);
INSERT INTO "filter_condition" VALUES(128,37,'pokemon_id','373',4);
INSERT INTO "filter_condition" VALUES(129,37,'pokemon_id','376',4);
INSERT INTO "filter_condition" VALUES(130,38,'pokemon_id','270',4);
INSERT INTO "filter_condition" VALUES(131,38,'pokemon_id','271',4);
INSERT INTO "filter_condition" VALUES(132,38,'pokemon_id','272',4);
INSERT INTO "filter_condition" VALUES(133,39,'pokemon_id','318',4);
INSERT INTO "filter_condition" VALUES(134,39,'pokemon_id','319',4);
INSERT INTO "filter_condition" VALUES(135,40,'pokemon_id','320',4);
INSERT INTO "filter_condition" VALUES(136,40,'pokemon_id','321',4);
INSERT INTO "filter_condition" VALUES(137,41,'pokemon_id','339',4);
INSERT INTO "filter_condition" VALUES(138,41,'pokemon_id','340',4);
INSERT INTO "filter_condition" VALUES(139,42,'pokemon_id','341',4);
INSERT INTO "filter_condition" VALUES(140,42,'pokemon_id','342',4);
INSERT INTO "filter_condition" VALUES(141,43,'pokemon_id','349',4);
INSERT INTO "filter_condition" VALUES(142,43,'pokemon_id','350',4);
INSERT INTO "filter_condition" VALUES(143,44,'pokemon_id','370',4);
CREATE TABLE filter(id integer not null primary key autoincrement, type integer not null references filter_type(id), name text, operator integer not null default 1 references filter_operator(id), sortorder int not null default 0);
INSERT INTO "filter" VALUES(1,1,'Larvitar family',2,1);
INSERT INTO "filter" VALUES(2,1,'Dratini family',2,1);
INSERT INTO "filter" VALUES(3,1,'Geodude family',2,1);
INSERT INTO "filter" VALUES(4,1,'Machop family',2,1);
INSERT INTO "filter" VALUES(5,1,'Abra family',2,1);
INSERT INTO "filter" VALUES(6,1,'Chansey family',2,1);
INSERT INTO "filter" VALUES(7,1,'Snorlax',1,2);
INSERT INTO "filter" VALUES(8,1,'Unown',1,2);
INSERT INTO "filter" VALUES(9,1,'Eevee CP>=840',1,2);
INSERT INTO "filter" VALUES(10,1,'Magikarp CP>=180',1,2);
INSERT INTO "filter" VALUES(11,1,'Steel',2,5);
INSERT INTO "filter" VALUES(12,1,'100% IV',1,5);
INSERT INTO "filter" VALUES(13,2,'Tyranitar raid',1,3);
INSERT INTO "filter" VALUES(14,2,'Machamp raid',1,3);
INSERT INTO "filter" VALUES(15,2,'Alakazam raid',1,3);
INSERT INTO "filter" VALUES(16,2,'Ninetails raid',1,3);
INSERT INTO "filter" VALUES(17,2,'Ninetails raid (non-SB)',1,3);
INSERT INTO "filter" VALUES(18,2,'Raids (lv. 3, 4, 5)',2,3);
INSERT INTO "filter" VALUES(19,2,'Instinct gyms w/open spots',1,6);
INSERT INTO "filter" VALUES(20,1,'Treecko family',2,1);
INSERT INTO "filter" VALUES(21,1,'Torchic family',2,1);
INSERT INTO "filter" VALUES(22,1,'Mudkip family',2,1);
INSERT INTO "filter" VALUES(23,1,'Poochyena family',2,1);
INSERT INTO "filter" VALUES(24,1,'Zigzagoon family',2,1);
INSERT INTO "filter" VALUES(25,1,'Wurmple family',2,1);
INSERT INTO "filter" VALUES(26,1,'Seedot family',2,1);
INSERT INTO "filter" VALUES(27,1,'Ralts family',2,1);
INSERT INTO "filter" VALUES(28,1,'Shroomish family',2,1);
INSERT INTO "filter" VALUES(29,1,'Slakoth family',2,1);
INSERT INTO "filter" VALUES(30,1,'Makuhita family',2,1);
INSERT INTO "filter" VALUES(31,1,'Skitty family',2,1);
INSERT INTO "filter" VALUES(32,1,'Meditite family',2,1);
INSERT INTO "filter" VALUES(33,1,'Electrike family',2,1);
INSERT INTO "filter" VALUES(34,1,'Gulpin family',2,1);
INSERT INTO "filter" VALUES(35,1,'Spoink family',2,1);
INSERT INTO "filter" VALUES(36,1,'Level 35',2,5);
INSERT INTO "filter" VALUES(37,1,'3rd-stage evolutions',2,5);
INSERT INTO "filter" VALUES(38,1,'Lotad family',2,1);
INSERT INTO "filter" VALUES(39,1,'Carvanha family',2,1);
INSERT INTO "filter" VALUES(40,1,'Wailmer family',2,1);
INSERT INTO "filter" VALUES(41,1,'Barboach family',2,1);
INSERT INTO "filter" VALUES(42,1,'Corphish family',2,1);
INSERT INTO "filter" VALUES(43,1,'Feebas family',2,1);
INSERT INTO "filter" VALUES(44,1,'Luvdisc',2,2);
CREATE TABLE filter_operator(id integer not null primary key autoincrement, name);
INSERT INTO "filter_operator" VALUES(1,'and');
INSERT INTO "filter_operator" VALUES(2,'or');
INSERT INTO "filter_operator" VALUES(3,'not');
INSERT INTO "filter_operator" VALUES(4,'eq');
INSERT INTO "filter_operator" VALUES(5,'gte');
INSERT INTO "filter_operator" VALUES(6,'lte');
CREATE TABLE hidden(id integer not null primary key autoincrement, userid integer not null references user(id), entityid text not null);
CREATE VIEW filter_condition_list as select fl.*, fc.id as conditionid, fc.key, fo.name as c_operator, fc.value from filter_list fl inner join filter_condition fc on fl.filterid = fc.filterid inner join filter_operator fo on fc.operator = fo.id;
CREATE VIEW filter_list as select f.id as filterid, f.name as filter, ft.name as type, fo.name as f_operator, f.sortorder from filter f inner join filter_type ft on f.type = ft.id inner join filter_operator fo on f.operator = fo.id;
CREATE VIEW user_filter_list as select u.id as userid, u.name as user, fcl.* from filter_condition_list fcl inner join user_filter uf on fcl.filterid = uf.filterid inner join user u on uf.userid = u.id order by fcl.sortorder, fcl.filter;
COMMIT;