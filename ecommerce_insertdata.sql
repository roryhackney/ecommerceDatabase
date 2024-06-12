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

INSERT INTO STATE (StateCode, CountryCode, StateName) VALUES
    ('CA', 'US', 'California'),
    ('TX', 'US', 'Texas'),
    ('NY', 'US', 'New York'),
    ('FL', 'US', 'Florida'),
    ('IL', 'US', 'Illinois'),
    ('PA', 'US', 'Pennsylvania'),
    ('OH', 'US', 'Ohio'),
    ('MI', 'US', 'Michigan'),
    ('GA', 'US', 'Georgia'),
    ('NC', 'US', 'North Carolina'),
    ('WA', 'US', 'Washington');

INSERT INTO ADDRESS (StateCode, AddressName, CityName, ZipID, CountryCode) VALUES
    ('CA', '123 Main St', 'Los Angeles', '90001', 'US'),
    ('TX', '456 Oak St', 'Houston', '77001', 'US'),
    ('NY', '789 Pine St', 'New York', '10001', 'US'),
    ('FL', '101 Maple St', 'Miami', '33101', 'US'),
    ('IL', '202 Birch St', 'Chicago', '60601', 'US'),
    ('PA', '303 Cedar St', 'Philadelphia', '19101', 'US'),
    ('OH', '404 Elm St', 'Columbus', '43201', 'US'),
    ('MI', '505 Spruce St', 'Detroit', '48201', 'US'),
    ('GA', '606 Walnut St', 'Atlanta', '30301', 'US'),
    ('NC', '707 Hickory St', 'Charlotte', '28201', 'US'),
    ('CA', '3851 Acacia Ave', 'Victorville', '92392', 'US'),
    ('WA', '81246 Birch Way', 'Lynnwood', '98036', 'US'),
    ('WA', '4121 Interlake Ave', 'Seattle', '98103', 'US'),
    ('CA', '917 Bamboo St', 'La Puente', '91744', 'US'),
    ('WA', '666 Cherry St', 'Seattle', '98104', 'US');

INSERT INTO WAREHOUSE (WarehouseName, AddressID) VALUES
    ('Warehouse A', 1),
    ('Warehouse B', 2),
    ('Warehouse C', 3),
    ('Warehouse D', 4),
    ('Warehouse E', 5),
    ('Warehouse F', 6),
    ('Warehouse G', 7),
    ('Warehouse H', 8),
    ('Warehouse I', 9),
    ('Warehouse J', 10);

-- TODO: insert real product names and descriptions?
INSERT INTO PRODUCT (SKU_ID, CrystalID, Name, Description, Price, WidthSize, HeightSize, Weight, PackCount) VALUES
    (1, 1, 'Product 1', 'Description 1', 10.00, 5.00, 5.00, 1.00, 10),
    (2, 2, 'Product 2', 'Description 2', 20.00, 10.00, 5.00, 2.00, 20),
    (3, 3, 'Product 3', 'Description 3', 30.00, 15.00, 5.00, 3.00, 30),
    (4, 4, 'Product 4', 'Description 4', 40.00, 20.00, 5.00, 4.00, 40),
    (5, 5, 'Product 5', 'Description 5', 50.00, 25.00, 5.00, 5.00, 50),
    (6, 6, 'Product 6', 'Description 6', 60.00, 30.00, 5.00, 6.00, 60),
    (7, 7, 'Product 7', 'Description 7', 70.00, 35.00, 5.00, 7.00, 70),
    (8, 8, 'Product 8', 'Description 8', 80.00, 40.00, 5.00, 8.00, 80),
    (9, 9, 'Product 9', 'Description 9', 90.00, 45.00, 5.00, 9.00, 90),
    (10, 10, 'Product 10', 'Description 10', 100.00, 50.00, 5.00, 10.00, 100);

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

INSERT INTO CUSTOMER (FirstName, LastName, EmailURL, PhoneNumber, AddressID, CardNumber, CardType) VALUES 
    ("Timmy", "Jimmy", "tj@yahoo.com", null, 11, null, null),
    ("Alice", "Axwielder", "aaaaaaa@gmail.com", null, 12, "**********1234", "Mastercard"),
    ("Penelope", "Petunia", "normalhuman@gmail.com", "1234567890", 13, null, null),
    ("Bob", "Jones", "bob_jones27@gmail.com", "2345678901", 14, "************7382", null),
    ("Tammy", "Jammy", "tj@gmail.com", "3456789012", 15, null, null),
    ("Amanda", "", "amanda@amanda.com", null, 11, null, null),
    ("Richard", "the Crab", "courageousecrustacean@yahoo.com", null, 12, null, "Visa"),
    ("Killing", "Time", "i_love_murder@gmail.com", null, 13, null, null),
    ("Bartholomew", "Baggins", "bb@yahoo.com", "9789012345", 14, null, null),
    ("Roxie", "Hart", "rocks@gmail.com", "0000000000", 15, null, null);

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
    (1, "Warehouse A", 32),
    (2, "Warehouse A", 15),
    (3, "Warehouse C", 9),
    (4, "Warehouse E", 64),
    (5, "Warehouse C", 12),
    (6, "Warehouse H", 200),
    (7, "Warehouse F", 0),
    (8, "Warehouse H", 2),
    (9, "Warehouse I", 99),
    (10, "Warehouse B", 76);

INSERT INTO WAREHOUSE_ORDER (OrderDate, WarehouseName, ExpectDelivDate, DeliveryDate) VALUES
    ('2021-01-01', "Warehouse A", '2021-01-10', '2021-01-11'),
    ('2021-06-11', "Warehouse I", '2021-06-12', '2021-07-23'),
    ('2022-05-07', "Warehouse H", '2022-05-12', '2022-05-12'),
    ('2022-09-30', "Warehouse F", '2022-10-05', '2022-10-04'),
    ('2023-01-01', "Warehouse E", '2023-01-02', '2023-01-12'),
    ('2023-06-09', "Warehouse A", '2023-06-15', '2023-06-17'),
    ('2023-08-30', "Warehouse D", '2023-09-03', '2023-09-03'),
    ('2023-10-14', "Warehouse A", '2023-10-17', '2023-10-17'),
    ('2024-05-01', "Warehouse C", '2024-05-15', '2024-05-15'),
    ('2024-06-01', "Warehouse B", '2024-06-15', null);

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
