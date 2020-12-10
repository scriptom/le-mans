INSERT INTO evento VALUES (1,'ensayo',1930,16340),(2,'carrera',1930,16340),(3,'ensayo',1931,16340),(4,'carrera',1931,16340),
(5,'ensayo',1932,13492),(6,'carrera',1932,13492),(7,'ensayo',1933,13492),(8,'carrera',1933,13492),
(9,'ensayo',1934,13492),(10,'carrera',1934,13492),(11,'ensayo',1935,13492),(12,'carrera',1935,13492),
(13,'ensayo',1937,13492),(14,'carrera',1937,13492),(15,'ensayo',1938,13492),(16,'carrera',1938,13492),
(17,'ensayo',1939,13492),(18,'carrera',1939,13492),(19,'ensayo',1949,13492),(20,'carrera',1949,13492);


INSERT INTO fabricante VALUES (1,'Mercedes-Benz',3),(2,'Bentley',138),(3,'Stutz Motor Company',58),(4,'Sunbeam-Talbot',138),
(5,'Alfa Romeo',86),(6,'Lea-Francis',138),(7,'Meadows',138),(8,'Bugatti',64),(9,'Tracta',64),(10,'MG Cars',138),
(11,'Chrysler',58),(12,'Lorraine-Dietrich',64),(13,'Arrol-Aster',138),(14,'Aston Martin',138),(15,'Bollack Netter and Co',64),(16,'Ruby',64),
(17,'Automobiles Lombard',64),(18,'Amilcar',64),(19,'Salmson',64),(20,'Alta Car and Engineering Company',64),(21,'Automobiles Rally',64),(22,'Citroën',64),
(23,'Duesenberg',58),(24,'S.A.R.A',64),(25,'Riley Motors',64),(26,'Austin Motor Company',138),(27,'Derby',64),
(28,'Singer Motors',138),(29,'Lagonda',138),(30,'Delahaye',64),(31,'Frazer Nash',138),(32,'Fiat',64),(33,'Delage',64),
(34,'Adler',3),(35,'Peugeot',64),(36,'HRG Engineering Company',138),(37,'Ford Motor Company',58),(38,'Chenard-Walcker',64),(39,'BMW',3),
(40,'Morgan Motor Company',138),(41,'Atalanta Motors Ltd',138),(42,'Ferrari',86),(43,'Aero',55),(44,'Donald Healey Motor Company Limited',138),
(45,'Renault',64),(46,'Alvis Car and Engineering Company',138),(47,'Deletrez Brothers',64);

INSERT INTO motor VALUES (DEFAULT,150,'Mercedes-Benz 7.1L S6',FALSE,1);

INSERT INTO motor VALUES (DEFAULT,180,'Bentley 6.6L S6',FALSE,2),(DEFAULT,113,'Stutz 5.4L S8',FALSE,3),
(DEFAULT,130,'Bentley 4.4L S6',FALSE,2),(DEFAULT,80,'Talbot 2.3L S6',FALSE,4),(DEFAULT,76,'Alfa Romeo 1768cc S6',FALSE,5),(DEFAULT,40,'Meadows 1495cc S4',FALSE,7),(DEFAULT,120,'Bugatti 1496cc S4',FALSE,8),(DEFAULT,45,'SCAP 999cc S4',FALSE,9),
(DEFAULT,50,'MG 847cc S4',FALSE,10),(DEFAULT,147,'Chrysler 6.3L S8',FALSE,11),(DEFAULT,114,'Stutz 5.3L S8',FALSE,3),(DEFAULT,140,'Bugatti 5.0L S8',FALSE,8),(DEFAULT,130,'Bentley 4.4L S4',FALSE,2),(DEFAULT,48,'Chrysler 4.0L S8',FALSE,11),
(DEFAULT,100,'Lorraine-Dietrich 3.4L S6',FALSE,12),(DEFAULT,120,'Talbot 3.0L S6',FALSE,4),(DEFAULT,50,'Arrol-Aster 2.4L S6',FALSE,13),(DEFAULT,140,'Alfa Romeo 2.3L S8',FALSE,5),(DEFAULT,123,'Bugatti 2.3L S8',FALSE,8),(DEFAULT,62,'Aston Martin 1495cc S4',FALSE,14),
(DEFAULT,60,'Ruby 1087cc S4',FALSE,16),(DEFAULT,47,'Lombard 1097cc S4',FALSE,17),(DEFAULT,163,'Alfa Romeo 2.34L S8',FALSE,5),(DEFAULT,64,'Alfa Romeo 1746cc S8',FALSE,5),(DEFAULT,83,'Amilcar 1092cc S6',FALSE,18),(DEFAULT,55,'Bugatti 2.26L S8',FALSE,8),
(DEFAULT,76,'Alta 1074cc S4',FALSE,20),(DEFAULT,265,'Duesenberg 6.9L s/c',FALSE,23),(DEFAULT,70,'SARA 1818cc S6',FALSE,24),(DEFAULT,118,'Bugatti 1493cc S8',FALSE,8),(DEFAULT,69,'Aston Martin 1496cc S4',FALSE,14),(DEFAULT,69,'Salmson 1362cc S4',FALSE,19),
(DEFAULT,25,'Salmson 1092cc S4',FALSE,19),(DEFAULT,9,'Riley 1091cc S4',FALSE,25),(DEFAULT,35,'Amilcar 1074cc S4',FALSE,18),(DEFAULT,83,'Amicar 1094cc S6',FALSE,18),(DEFAULT,31,'Singer 972cc S4',FALSE,28),(DEFAULT,36,'MG 745cc S4',FALSE,10),
(DEFAULT,10,'Austin 742cc S4',FALSE,26),(DEFAULT,160,'Bugatti 4.9L I8',FALSE,8),(DEFAULT,12,'Lorraine-Dietrich 3.5L I6',FALSE,12),(DEFAULT,80,'Bugatti 3.0L I8',FALSE,8),(DEFAULT,160,'Alfa Romeo 2.4L I8',FALSE,5),(DEFAULT,170,'Alfa Romeo 2.4L Supercharged I8',FALSE,5),
(DEFAULT,160,'Bugatti 2.3L Supercharged I8',FALSE,8),(DEFAULT,113,'Derby 2.0L V8',FALSE,27),(DEFAULT,70,'Aston Martin 1.5L I4',FALSE,14),(DEFAULT,48,'Singer 1.5L I4',FALSE,28),(DEFAULT,20,'Riley 1.5L I6',FALSE,25),(DEFAULT,40,'Salmson 1.1L I4',FALSE,19),
(DEFAULT,39,'Amilcar 1.1L I6',FALSE,18),(DEFAULT,40,'MG 1.1L Supercharged I4',FALSE,10),(DEFAULT,9,'Riley 1.1L I4',FALSE,25),(DEFAULT,50,'Lagonda 1.1L I4',FALSE,29),(DEFAULT,39,'Amilcar 1.1L I4',FALSE,18),(DEFAULT,40,'Tracta 1.0L I4',FALSE,9),
(DEFAULT,60,'Rally 1.0L I4',FALSE,21),(DEFAULT,265,'Duesenberg 7.0L I8',FALSE,23),(DEFAULT,470,'Bugatti 5.0L I8',FALSE,8),(DEFAULT,160,'Meadows 4.5L I6',FALSE,7),(DEFAULT,15,'Lorraine 3.5L I6',FALSE,12),(DEFAULT,210,'Bugatti 3.3L I8',FALSE,8),
(DEFAULT,18,'Delahaye 3.2L I6',FALSE,30),(DEFAULT,160,'Talbot 3.0L I6',FALSE,4),(DEFAULT,160,'Bugatti 2.3L I6',FALSE,8),(DEFAULT,135,'Bugatti 2.0L Supercharged I8',FALSE,8),(DEFAULT,12,'Gough 1.5L I4',FALSE,31),(DEFAULT,68,'Riley 1.5L I4',FALSE,25),
(DEFAULT,59,'MG 1.1L Supercharged I6',FALSE,10),(DEFAULT,20,'Fiat 1.0L I4',FALSE,32),(DEFAULT,56,'MG 0.8L I4',FALSE,10),(DEFAULT,60,'Austin 0.7L I4',FALSE,26),(DEFAULT,95,'Delahaye 3.6L I6',FALSE,30),(DEFAULT,78,'Delage 3.0L I6',FALSE,33),
(DEFAULT,32,'Adler 1.7L I4',FALSE,34),(DEFAULT,90,'Peugeot 2.0L I4',FALSE,35),(DEFAULT,15,'Aston Martin 2.0L I4',FALSE,14),(DEFAULT,12,'Meadows 1.5L I4',FALSE,7),(DEFAULT,56,'Adler 1.0L I4',FALSE,34),(DEFAULT,43,'MG 0.9L I4',FALSE,10),
(DEFAULT,12,'Fiat 0.6L I4',FALSE,32),(DEFAULT,20,'Chenard et Walcker 1.1L I4',FALSE,38),(DEFAULT,32,'Fiat 1.1L I4',FALSE,32),(DEFAULT,31,'Singer 1.0L I4',FALSE,28),(DEFAULT,79,'BMW 2.0L I6',FALSE,39),(DEFAULT,32,'Adler 1.5L I4',FALSE,34),
(DEFAULT,30,'Chenard et Walcker 1.8L Supercharged I4',FALSE,38),(DEFAULT,225,'Alfa Romeo 2.9L Supercharged I8',FALSE,5),(DEFAULT,160,'Talbot 4.0L I6',FALSE,4),(DEFAULT,56,'MG 1.0L I4',FALSE,10),(DEFAULT,40,'Coventry Climax 1.1L I4',FALSE,40),(DEFAULT,75,'Amilcar 2.5L I4',FALSE,18),
(DEFAULT,170,'Talbot 4.5L I6',FALSE,4),(DEFAULT,216,'Alfa Romeo 2.9L Supercharged I6',FALSE,5),(DEFAULT,78,'Atalanta 1.5L I4',FALSE,41),(DEFAULT,210,'Bugatti 3.3L Supercharged I8',FALSE,8),(DEFAULT,180,'Lagonda 4.5L V12',FALSE,29),(DEFAULT,105,'Alfa Romeo 2.4L I6',FALSE,5),
(DEFAULT,138,'Ferrari 2.0L V12',FALSE,42),(DEFAULT,100,'Bristol 2.0L I6',FALSE,31),(DEFAULT,110,'Bentley 4.3L I6',FALSE,2),(DEFAULT,100,'Simca 1.1L I4',FALSE,32),(DEFAULT,20,'Aero 0.7L Flat-2(2-Stroke)',FALSE,43),(DEFAULT,80,'Citroën 1.5L I4',FALSE,22),
(DEFAULT,17,'Simca 0.6L I4',FALSE,32),(DEFAULT,104,'Riley 2.4L I4',FALSE,25),(DEFAULT,20,'Talbot-Lago 4.5L I6',FALSE,4),(DEFAULT,221,'Delahaye 4.5L I6',FALSE,30),(DEFAULT,55,'MG 1.3L I4',FALSE,10),(DEFAULT,70,'Delettrez 4.4L I6(Diesel)',FALSE,47),
(DEFAULT,21,'Renault 0.8L I4',FALSE,45),(DEFAULT,27,'Alvis 1.9L I4',FALSE,46);



INSERT INTO equipo VALUES (DEFAULT,'Rudolf Caracciola',3),(DEFAULT,'Bentley Motors Ltd',138),(DEFAULT,'Édouard Brisson',64),
(DEFAULT,'R. Parke',58),(DEFAULT,'Hon. Dorothy Paget',138),(DEFAULT,'Fox & Nicholl',138),(DEFAULT,'Earl Howe',138),(DEFAULT,'Lea-Francis Ltd',138),
(DEFAULT,'Marguerite Mareuse',64),(DEFAULT,'S.A des Automobiles Tracta',64),(DEFAULT,'Huskinson & Fane Ltd',138),(DEFAULT,' Francis Samuelson',138),
(DEFAULT,'V. Tatarinoff',146),(DEFAULT,'Henri de Costier',64),(DEFAULT,'Automobiles Ettore Bugatti',64),(DEFAULT,'Gerald Bevan',138),
(DEFAULT,'Roger Labric',64),(DEFAULT,'Peter Hope-Johnson',138),(DEFAULT,'S.A Alfa Romeo',86),(DEFAULT,'Antoine Schumann',64),
(DEFAULT,'Jean Sébilleau',64),(DEFAULT,'Aston Martin Ltd',138),(DEFAULT,' C. de Ricou',64),(DEFAULT,'Charles Charrier',64),(DEFAULT,'Joan Chetwynd',138),(DEFAULT,'Raymond Sommer',64),
(DEFAULT,'Arthur W. Fox',138),(DEFAULT,'Odette Siko',64),(DEFAULT,'Équipe de l''Ours',64),(DEFAULT,'Stanisław Czaykowski',136),(DEFAULT,'Just-Émile Vernet',64),(DEFAULT,'Charles Druck',64),
(DEFAULT,'Pierre-Louis Dreyfus',64),(DEFAULT,'Guy Bouriat',64),(DEFAULT,'H. Stoffel',64),(DEFAULT,'Prince Dimitri',67),(DEFAULT,'John Ludovic Ford',138),(DEFAULT,'Jean Danne',64),
(DEFAULT,'Henri de la Sayette',64),(DEFAULT,'Jean Trévoux',64),(DEFAULT,'Principe Nicholas of Romania',145),(DEFAULT,'Luigi Chinetti',86),(DEFAULT,'Louis Chiron',116),(DEFAULT,'Société des Automobiles Charley',64),
(DEFAULT,'André Rousseau',64),(DEFAULT,'Riley Motor Company Ltd.',138),(DEFAULT,'Alin Fréres',64),(DEFAULT,'Singer Motors',138),(DEFAULT,'N. Black',138),(DEFAULT,'H.B. Metchim',138),
(DEFAULT,'Norbert Jean Mahé',64),(DEFAULT,'Tim Rose-Richards',138),(DEFAULT,'Charles Brunet',64),(DEFAULT,'Max Fourney',64),(DEFAULT,'Louis Villeneuve',64),(DEFAULT,'Mrs. Gwenda Stewart',138),
(DEFAULT,'M.R.E. Tongue',138),(DEFAULT,'John Cecil Noël',138),(DEFAULT,'Frank Stanley Barnes',138),(DEFAULT,'A.A. Rigby',138),(DEFAULT,'Auguste Bodoignet',64),(DEFAULT,'Jean de Gavardie',64),
(DEFAULT,'Roy Eccles',138),(DEFAULT,'Miss Dorothy Champney',138),(DEFAULT,'Lord de Clifford',138),(DEFAULT,'Georges Boursin',64),(DEFAULT,'Charles Auguste Martin',64),(DEFAULT,'J.A. Grégoire',64),
(DEFAULT,'Raymond Gaillard',64),(DEFAULT,'Singer Ltd.',138),(DEFAULT,'Gordon Hendy',138),(DEFAULT,'R.P. Gardner',138),(DEFAULT,'Mme Anne-Cécile Rose-Itier',64),(DEFAULT,'Philippe Maillard-Brune',64),
(DEFAULT,'H. Bridgman Metchim',138),(DEFAULT,'Daniel Porthault',64),(DEFAULT,'Bernard de Souza Dantas',64),(DEFAULT,'Michel Paris',64),(DEFAULT,'Anthony Lago',64),(DEFAULT,'M. Rekip',64),
(DEFAULT,'Ecurie Argo',64),(DEFAULT,'Comte Georges d''Arnoux',64),(DEFAULT,'Derby',64),(DEFAULT,'Guy Don',138),(DEFAULT,'Tim Davies',138),(DEFAULT,'M.T.U. Collier',138),
(DEFAULT,'P.L. Donkin',138),(DEFAULT,'C.T. Thomas',138),(DEFAULT,'Maurice Faulkner',138),(DEFAULT,'André Hénon',64),(DEFAULT,'Maurice Baumer',138),(DEFAULT,'Eddie Hertzberger',18),
(DEFAULT,'Ecurie de l''Ours',64),(DEFAULT,'Amédée Gordini',64),(DEFAULT,'Gaston Duval',64),(DEFAULT,'Ian Connell',138),(DEFAULT,'J.R.H. Baker',138),(DEFAULT,'Guy Lapchin',64),
(DEFAULT,'Anthony Marsh',138),(DEFAULT,'Captain G.E.T. Eyston',138),(DEFAULT,'Philipee Maillard-Brune',64),(DEFAULT,'Austin',138),(DEFAULT,'John Carr',138),(DEFAULT,'Joseph Paul',64),
(DEFAULT,'Ecurie Bleue',64),(DEFAULT,'Société R.V.',64),(DEFAULT,'J.M. Skeffington',138),(DEFAULT,'Adler',3),(DEFAULT,'Émile Darl''mat',64),(DEFAULT,'A.C. Scott',138),
(DEFAULT,'M.K.H. Bilney',138),(DEFAULT,'H. Lesbros',64),(DEFAULT,'Yves Giraud-Cabantous',64),(DEFAULT,'R.H. Eccles',138),(DEFAULT,'André Parguel',64),(DEFAULT,'Raymond de Saugé Destrez',64),
(DEFAULT,'Jacques Savoye',64),(DEFAULT,'Team Autosports',138),(DEFAULT,'R. Marsh',138),(DEFAULT,'Frazer Nash',138),(DEFAULT,'Jacques Seylair',64),(DEFAULT,'Ecurie Eudel',64),
(DEFAULT,'Eugéne Chaboud',64),(DEFAULT,'André M. Embiricos',70),(DEFAULT,'BMW',3),(DEFAULT,'David Murray',138),(DEFAULT,'René Kippeurt',64),(DEFAULT,'Gaston Serraud',64),
(DEFAULT,'Jean Prenant',64),(DEFAULT,'Ecurie Lapin Blanc',138),(DEFAULT,'Victor Camerano',64),(DEFAULT,'Victor Camerano',64),(DEFAULT,'Miss P.M. Fawcett',138),(DEFAULT,'Robert P Hichens',138),
(DEFAULT,'Robert P Hichens',138),(DEFAULT,'Pierre Ferry',64),(DEFAULT,'Mme Fernande Roux',64),(DEFAULT,'Georges Monneret',64),(DEFAULT,'Marcel Horvilleur',64),(DEFAULT,'Miss Dorothy Stanley-Turner',138),(DEFAULT,'Raoul Forestier',64),
(DEFAULT,'Charles Morrison',138),(DEFAULT,'Jean-Pierre Wimille',64),(DEFAULT,'Ecurie Walter Watney',138),(DEFAULT,'Lagonda Ltd.',138),(DEFAULT,'Lord Selsdon',138),(DEFAULT,'Count Heyden',138),
(DEFAULT,'Joseph Chotard',64),(DEFAULT,'Robert Peverell Hichens',138),(DEFAULT,'Mrs. Majorie Fawcett',138),(DEFAULT,'Arthur W. Jones',138),(DEFAULT,'Ecuria Francia',64),(DEFAULT,'Victor Polledry',64),
(DEFAULT,'Robert Mazaud',64),(DEFAULT,'Archie Scott Brown',138),(DEFAULT,'Ecurie Francia',64),(DEFAULT,'T.A.S.O. Mathieson',138),(DEFAULT,'Jean Trémoulet',64),(DEFAULT,'Miles Collier',58),
(DEFAULT,'André Bellecroix',64),(DEFAULT,'Peter Mitchell-Thomson, Lord Selsdon',138),(DEFAULT,'Henri Louveau',64),(DEFAULT,'Mrs. P. Trevelyan',138),(DEFAULT,'W.S. Watney',138),
(DEFAULT,'Pierre Meyrat',64),(DEFAULT,'H.S.F. Hay',138),(DEFAULT,'Arthur Jones',138),(DEFAULT,'HRG Engineering',138),(DEFAULT,'René Bouchard',64),(DEFAULT,'Robert Lawrie',138),
(DEFAULT,'Monopole-Poissy',64),(DEFAULT,'N.J. Mahé / R. Crovetto',64),(DEFAULT,'Let-Aviation',55),(DEFAULT,'Auguste Lachaize',64),(DEFAULT,'Ecurie Verte',64),(DEFAULT,'Jacques Poch',64),
(DEFAULT,'Henry Leblanc',64),(DEFAULT,'Jack Bartlett',138),(DEFAULT,'André Guillard',64),(DEFAULT,'Auguste Veuillet',64),(DEFAULT,'Mrs. R.P. Hichens',64),(DEFAULT,'Ecurie Charles Pozzi',64),
(DEFAULT,'René Bonnet',64),(DEFAULT,'G.E. Phillips',138),(DEFAULT,'R.R.C. Walker Racing Team',138),(DEFAULT,'Etablissements Delettrez',64),(DEFAULT,'Écurie France',64),(DEFAULT,'Mme Vivianne Elder',64),
(DEFAULT,'Robert Redge',64),(DEFAULT,'Ecurie Lapin Blanche',138),(DEFAULT,'Marc Versini',64),(DEFAULT,'J.A. Plisson',64),(DEFAULT,'Peter Monkhouse',138),(DEFAULT,'Robert Tocheport',64),
(DEFAULT,'Dudley C. Folland',138),(DEFAULT,'Ecurie Rosier',64),(DEFAULT,'Camille Hardy',64),(DEFAULT,'Aston Martin Lagonda Ltd.',138),(DEFAULT,'Louis Eggen',18);



INSERT INTO vehiculo VALUES (DEFAULT,,,'','',,,,array[
array[decode('','hex'),
decode('','hex')],
array[decode('','hex'),
null],
array[decode('','hex'),
null]]);

INSERT INTO vehiculo VALUES (DEFAULT,,,'','',,,,array[
array[decode('','hex'),
decode('','hex')],
array[decode('','hex'),
null],
array[decode('','hex'),
null]]);

INSERT INTO vehiculo VALUES (DEFAULT,,,'','',,,,array[
array[decode('','hex'),
decode('','hex')],
array[decode('','hex'),
null],
array[decode('','hex'),
null]]);

INSERT INTO vehiculo VALUES (DEFAULT,,,'','',,,,array[
array[decode('','hex'),
decode('','hex')],
array[decode('','hex'),
null],
array[decode('','hex'),
null]]);

INSERT INTO vehiculo VALUES (DEFAULT,,,'','',,,,array[
array[decode('','hex'),
decode('','hex')],
array[decode('','hex'),
null],
array[decode('','hex'),
null]]);

INSERT INTO vehiculo VALUES (DEFAULT,,,'','',,,,array[
array[decode('','hex'),
decode('','hex')],
array[decode('','hex'),
null],
array[decode('','hex'),
null]]);

INSERT INTO vehiculo VALUES (DEFAULT,,,'','',,,,array[
array[decode('','hex'),
decode('','hex')],
array[decode('','hex'),
null],
array[decode('','hex'),
null]]);