CREATE TABLE "Carts" (
    "id" SERIAL,
    "workspaceId" INT,
    PRIMARY KEY ("id")
);

CREATE TABLE "CartItems" (
    "id" SERIAL,
    "quantity" INT,
    "itemId" INT,
    "cartId" INT,
    PRIMARY KEY ("id")
);

CREATE TABLE "Items" (
    "id" SERIAL,
    "name" TEXT,
    "price" INT,
    PRIMARY KEY ("id")
);

CREATE TABLE "PriceOverrides" (
    "id" SERIAL,
    "workspaceId" INT,
    "itemId" INT,
    "price" INT,
    "percentage" INT,
    PRIMARY KEY ("id")
);

CREATE TABLE "Workspaces" (
    "id" SERIAL,
    "name" TEXT,
    PRIMARY KEY ("id")
);

CREATE TABLE "DietTags" (
    "id" SERIAL,
    "name" TEXT,
    PRIMARY KEY ("id")
);

CREATE TABLE "ItemDietTags" (
    "id" SERIAL,
    "itemId" INT,
    "dietTagId" INT,
    PRIMARY KEY ("id")
);

--

-- Insert 20 Workspaces with real company names
INSERT INTO "Workspaces" ("name") VALUES 
('Amazon'), ('Google'), ('Microsoft'), ('Apple'), ('Facebook'),
('Netflix'), ('Tesla'), ('SpaceX'), ('Nvidia'), ('Intel'),
('AMD'), ('IBM'), ('Cisco'), ('Oracle'), ('Adobe'),
('Salesforce'), ('Snapchat'), ('Twitter'), ('Uber'), ('Airbnb');

-- Insert 100 Items with real grocery item names
INSERT INTO "Items" ("name", "price") VALUES 
('Apple', 100), ('Banana', 150), ('Orange', 200), ('Grapes', 250), ('Watermelon', 300),
('Strawberries', 350), ('Blueberries', 400), ('Mango', 450), ('Pineapple', 500), ('Peach', 550),
('Broccoli', 600), ('Carrots', 650), ('Lettuce', 700), ('Tomatoes', 750), ('Cucumber', 800),
('Potatoes', 850), ('Onions', 900), ('Garlic', 950), ('Peppers', 1000), ('Spinach', 1050),
('Milk', 1100), ('Cheese', 1150), ('Yogurt', 1200), ('Butter', 1250), ('Eggs', 1300),
('Chicken', 1350), ('Beef', 1400), ('Pork', 1450), ('Fish', 1500), ('Shrimp', 1550),
('Bread', 1600), ('Rice', 1650), ('Pasta', 1700), ('Oats', 1750), ('Flour', 1800),
('Sugar', 1850), ('Salt', 1900), ('Pepper', 1950), ('Olive Oil', 2000), ('Vinegar', 2050),
('Cereal', 2100), ('Juice', 2150), ('Soda', 2200), ('Coffee', 2250), ('Tea', 2300),
('Cookies', 2350), ('Chips', 2400), ('Candy', 2450), ('Chocolate', 2500), ('Ice Cream', 2550),
('Toothpaste', 2600), ('Shampoo', 2650), ('Soap', 2700), ('Lotion', 2750), ('Deodorant', 2800),
('Toilet Paper', 2850), ('Paper Towels', 2900), ('Laundry Detergent', 2950), ('Dish Soap', 3000), ('Sponges', 3050),
('Almonds', 3100), ('Cashews', 3150), ('Peanuts', 3200), ('Walnuts', 3250), ('Pistachios', 3300),
('Raisins', 3350), ('Dates', 3400), ('Prunes', 3450), ('Cranberries', 3500), ('Applesauce', 3550),
('Ketchup', 3600), ('Mustard', 3650), ('Mayonnaise', 3700), ('BBQ Sauce', 3750), ('Hot Sauce', 3800),
('Pickles', 3850), ('Relish', 3900), ('Soy Sauce', 3950), ('Worcestershire Sauce', 4000), ('Teriyaki Sauce', 4050),
('Frozen Peas', 4100), ('Frozen Corn', 4150), ('Frozen Spinach', 4200), ('Frozen Berries', 4250), ('Frozen Pizza', 4300),
('Canned Beans', 4350), ('Canned Corn', 4400), ('Canned Tuna', 4450), ('Canned Tomatoes', 4500), ('Canned Soup', 4550),
('Beer', 4600), ('Wine', 4650), ('Whiskey', 4700), ('Vodka', 4750), ('Gin', 4800),
('Tortilla Chips', 4850), ('Salsa', 4900), ('Guacamole', 4950), ('Hummus', 5000), ('Pita Bread', 5050);

-- Insert 6 PriceOverrides with fixed price
INSERT INTO "PriceOverrides" ("workspaceId", "itemId", "price", "percentage") VALUES 
(1, 1, 500, NULL), (2, 3, 600, NULL), (3, 5, 700, NULL), (4, 5, 800, NULL), (5, 8, 900, NULL), (6, 9, 1000, NULL);

-- Insert 5 Diet Tags
INSERT INTO "DietTags" ("name") VALUES 
('Vegetarian'), ('Vegan'), ('Gluten-Free'), ('Keto'), ('Paleo');

-- Assign Diet Tags to some of the items
INSERT INTO "ItemDietTags" ("itemId", "dietTagId") VALUES 
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), -- Fruits
(11, 2), (12, 2), (13, 2), (14, 2), (15, 2), -- Vegetables
(21, 3), (22, 3), (23, 3), (24, 3), (25, 3), -- Dairy
(26, 4), (27, 4), (28, 4), (29, 4), (30, 4), -- Meat
(36, 5), (37, 5), (38, 5), (39, 5), (40, 5); -- Condiments

-- Insert 1 Cart per Workspace
INSERT INTO "Carts" ("workspaceId") VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20);

-- Insert random number of CartItems for each Cart with random quantities
INSERT INTO "CartItems" ("quantity", "itemId", "cartId") VALUES 
(2, 1, 1), (3, 2, 1), (1, 3, 1),
(1, 4, 2), (2, 5, 2), (4, 6, 2),
(5, 7, 3), (2, 8, 3), (3, 9, 3),
(1, 10, 4), (2, 11, 4), (1, 12, 4),
(3, 13, 5), (4, 14, 5), (2, 15, 5),
(5, 16, 6), (1, 17, 6), (3, 18, 6),
(2, 19, 7), (4, 20, 7), (1, 21, 7),
(3, 22, 8), (5, 23, 8), (2, 24, 8),
(4, 25, 9), (1, 26, 9), (3, 27, 9),
(2, 28, 10), (1, 29, 10), (4, 30, 10),
(5, 31, 11), (3, 32, 11), (2, 33, 11),
(1, 34, 12), (4, 35, 12), (5, 36, 12),
(2, 37, 13), (3, 38, 13), (1, 39, 13),
(4, 40, 14), (5, 41, 14), (2, 42, 14),
(3, 43, 15), (1, 44, 15), (4, 45, 15),
(5, 46, 16), (2, 47, 16), (3, 48, 16),
(1, 49, 17), (4, 50, 17), (5, 51, 17),
(2, 52, 18), (3, 53, 18), (1, 54, 18),
(4, 55, 19), (5, 56, 19), (2, 57, 19),
(3, 58, 20), (1, 59, 20), (4, 60, 20);
