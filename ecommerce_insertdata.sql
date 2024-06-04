USE DRAGONS_HOARD_SHOP;

INSERT INTO TAG VALUES
	("Expensive"),
    ("Cheap"),
    ("Shiny"),
    ("Smooth"),
    ("Low Quality"),
    ("High Quality"),
    ("Worth The Price"),
    ("Would Buy Again"),
    ("Great Gift"),
    ("Love"),
    ("Like"),
    ("Dislike"),
    ("Hate");

INSERT INTO CRYSTAL (ID, Name, Description, IsSynthetic, SourceName, SupplierName) VALUES
	(1, "Amber", "A yellow to brown stone formed from fossilized tree sap or resin, representing healing and prosperity.", false, "Samland Peninsula", "Alice's Amber"),
	(2, "Chrysanthemum Stone", "A black and white rock with beautiful flower patterns. Represents luck and achieving one's purpose.", false, "Japan", "Cool Rock Imports"),
    (3, "Rainbow Garnet", "A red and green gem from Africa which represents happiness and healing of the inner child.", false, "Africa", "Cool Rock Imports"),
    (4, "Black Jade", "A hard black stone that is said to grant protection and assist in spiritual journeys.", false, "Australia", "Cool Rock Imports"),
    (5, "Petrified Wood", "Wood that has fossilized, replacing plant matter with minerals. Represents steady growth and the past.", false, "Arizona, USA", "Bob's Rocks"),
    (6, "Pyrite", "Known as fool's gold, pyrite is a gold colored stone that represents ambition, confidence, and positivity.", false, "Virginia, USA", "Bob's Rocks"),
    (7, "Sunstone", "A warm orange stone representing abundance, leadership, positivity, and benevolence.", false, "Oregon, USA", "Bob's Cool Rocks"),
    (8, "Tiger Eye", "A striped gold and brown stone, representing balance, clarity, and fairness.", false, "Australia", "Cool Rock Imports"),
    (9, "Turqoise", "A light blue stone, popular in jewelry, that represents emotional peace, healing, and forgiveness.", false, "Mexico", "Cool Rock Imports"),
    (10, "Quartz", "A transparent white crystal that represents healing, memory, and cleansing.", true, "Arkansas, USA", "Bob's Cool Rocks");

-- placeholder data until Ken completes the other half
INSERT INTO ADDRESS VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15);
INSERT INTO PRODUCT VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
INSERT INTO WAREHOUSE VALUES ("W1", 1), ("W2", 2), ("W3", 3), ("W4", 4), ("W5", 5), ("W6", 6), ("W7", 7), ("W8", 8), ("W9", 9), ("W10", 10);

-- back to my data
INSERT INTO COLOR VALUES
	("White", "#ffffff"),
    ("Black", "#000000"),
    ("Red", "#F6766D"),
    ("Orange", "#FFAE16"),
    ("Yellow", "#FFFF14"),
    ("Green", "#3CE200"),
    ("Blue", "#608BFF"),
    ("Purple", "#D957FF"),
    ("Pink", "#FF7CEC"),
    ("Gray", "#9E9E9E"),
    ("Brown", "#a36546"),
    ("Clear", "#eeeeee");
    
INSERT INTO CRYSTAL_COLOR (CrystalID, ColorName) VALUES
	(10, "Clear"),
    (1, "Brown"),
    (1, "Yellow"),
    (2, "White"),
    (2, "Black"),
    (3, "Red"),
    (3, "Green"),
    (4, "Black"),
    (5, "Brown"),
    (6, "Yellow"),
    (7, "Orange"),
    (8, "Brown"),
    (8, "Yellow"),
    (9, "Blue");

INSERT INTO PROPERTY VALUES
	("Prosperity"),
    ("Luck"),
    ("Healing"),
    ("Protection"),
    ("Grounding"),
    ("Happiness"),
    ("Clarity"),
    ("Balance"),
    ("Spirituality"),
    ("Leadership"),
    ("Forgiveness");
    
INSERT INTO CRYSTAL_PROPERTY VALUES
	("Healing", 1),
    ("Prosperity", 1),
    ("Luck", 2),
    ("Happiness", 3),
    ("Healing", 3),
    ("Protection", 4),
    ("Spirituality", 4),
    ("Prosperity", 6),
    ("Leadership", 7),
    ("Balance", 8),
    ("Healing", 9),
    ("Forgiveness", 9),
    ("Healing", 10);
    
INSERT INTO CUSTOMER (FirstName, LastName, EmailURL, 			PhoneNumber, AddressID, CardNumber, CardType) VALUES 
	("Timmy",		"Jimmy",	"tj@yahoo.com", 				null, 		11, null, null),
	("Alice",		"Axwielder", "aaaaaaa@gmail.com", 			null, 		12, "**********1234", "Mastercard"),
	("Penelope",	"Petunia", 	"normalhuman@gmail.com", 		"1234567890", 13, null, null),
	("Bob", 		"Jones", 	"bob_jones27@gmail.com", 		"2345678901", 14, "************7382", null),
	("Tammy", 		"Jammy", 	"tj@gmail.com", 				"3456789012", 15, null, null),
	("Amanda", 		"", 		"amanda@amanda.com", 			null, 		11, null, null),
	("Richard", 	"the Crab",	"courageousecrustacean@yahoo.com", null, 	12, null, "Visa"),
	("Killing", 	"Time", 	"i_love_murder@gmail.com", 		null, 		13, null, null),
	("Bartholomew",	"Baggins", 	"bb@yahoo.com", 				"9789012345", 14, null, null),
	("Roxie",		"Hart", 	"rocks@gmail.com", 				"0000000000", 15, null, null);
    
INSERT INTO REWARDS_MEMBER (CustomerID, UserName, UserPassword, IsSubscribed) VALUES
	(1, "timmyjimmy", "T@mdi9fA", true),
    (2, "aaaaaaaaaaa", "aaaAAA!9", true),
    (3, "peepee", "Petun1a!", false),
    (4, "BobJones", "Password!1", true),
    (5, "tj", "TJtjTJ*3", true),
    (6, "amanda", "Khduwb8*", false),
    (7, "crab", "Crab2Crab!", true),
    (8, "killinIt", "Knjias!7", false),
    (9, "bb", "B&pasw0rd", false),
    (10, "rxhrt", "R0xieHr+", true);
    
INSERT INTO REVIEW (SKU_ID, RatingNumber, TitleName, Description) VALUES
	(1, 5, "Great product!", "Perfect for my grandkids who love shiny rocks"),
	(2, 3, "Okay, not very shiny", "Needs a good polish, otherwise good"),
	(3, 4, "Great rock for the price!", "Added to my collection :)"),
	(4, 2, "Purchased 'Discounted, Extremely Broken Rock' and it was broken!", "I demand a refund for this no returns no exchanges broken discontinued item"),
	(5, 5, "Beautiful rock!", "Can't believe it was being sold for such a great price! Ordering more!"),
	(6, 4, "Nice and textured, good fidgeting rock", null),
	(7, 4, null, null),
	(8, 3, null, null),
	(9, 4, null, "cool rock thanks"),
    (2, 1, "Shattered upon dropping from the roof", null);
    
INSERT INTO REVIEW_TAGS (ReviewID, TagName) VALUES
	(1, "Shiny"),
    (1, "Great Gift"),
    (1, "Love"),
    (2, "Dislike"),
    (3, "Cheap"),
    (3, "Would Buy Again"),
    (3, "Like"),
    (5, "Cheap"),
    (6, "High Quality"),
    (10, "Expensive");
    
INSERT INTO INVENTORY VALUES
	(1, "W3", 32),
    (2, "W3", 15),
    (3, "W1", 9),
    (4, "W5", 64),
    (5, "W1", 12),
    (6, "W8", 200),
    (7, "W6", 0),
    (8, "W8", 2),
    (9, "W9", 99),
    (10, "W2", 76);
    
INSERT INTO WAREHOUSE_ORDER (OrderDate, WarehouseName, ExpectDelivDate, DeliveryDate) VALUES
	('2021-01-01', "W1", '2021-01-10', '2021-01-11'),
	('2021-06-11', "W9", '2021-06-12', '2021-07-23'),
	('2022-05-07', "W8", '2022-05-12', '2022-05-12'),
	('2022-09-30', "W6", '2022-10-05', '2022-10-04'),
	('2023-01-01', "W5", '2023-01-02', '2023-01-12'),
	('2023-06-09', "W1", '2023-06-15', '2023-06-17'),
	('2023-08-30', "W4", '2023-09-03', '2023-09-03'),
	('2023-10-14', "W1", '2023-10-17', '2023-10-17'),
	('2024-05-01', "W3", '2024-05-15', '2024-05-15'),
	('2024-06-01', "W2", '2024-06-15', null);
    
INSERT INTO ORDERED_PRODUCT (OrderID, SKU_ID, UnitPrice) VALUES
	(1, 1, 10.99),
    (1, 2, 5.99),
    (1, 3, 19.99),
    (2, 1, 10.49),
    (2, 6, 12.99),
    (3, 5, 8.99),
    (5, 2, 9.99),
    (7, 9, 18.75),
    (4, 9, 17.99),
    (9, 4, 9.75);