CREATE DATABASE IF NOT EXISTS MCMP;
USE MCMP;

CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    StudentID VARCHAR(20) NOT NULL,
    StudentEmail VARCHAR(50) UNIQUE NOT NULL CHECK (StudentEmail LIKE '%@my.sctcc.edu'), -- Constraint for ensuring email ends in @my.sctcc.edu
    Username VARCHAR(20) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    UserAdmin TINYINT NOT NULL DEFAULT '0',
    UserBanned TINYINT NOT NULL DEFAULT '0', 
    UserCreated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Items (
	ItemID INT PRIMARY KEY AUTO_INCREMENT,
	ItemName VARCHAR(30) NOT NULL,
	ItemDesc VARCHAR(300) NOT NULL,
        ItemCondition VARCHAR(30) NOT NULL CHECK (ItemCondition IN ('Used - Like New', 'Used - Good', 'Used - Fair', 'New')), -- Constraint for checking item condition
	ItemAdded DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	ItemPrice FLOAT NOT NULL CHECK (ItemPrice >= 0), -- Constraint to ensure price is 0 or greater.
	ItemQuantity INT NOT NULL CHECK (ItemQuantity > 0), -- Constraint to ensure quantity is greater than 0.
	ItemWanted TINYINT NOT NULL CHECK (ItemWanted IN (0,1)), -- Constraint to check if an item is wanted.
	ItemImage VARCHAR(50) NOT NULL,
	UserID INT NOT NULL,
	FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

DROP TABLE Items;
DROP TABLE Users;
DROP DATABASE MCMP;

-- SAmple data for the users table
INSERT INTO Users (FirstName, LastName, StudentID, StudentEmail, Username, PasswordHash, UserAdmin, UserBanned)
VALUES 
('Brady', 'Peters', '123456', 'brady.peters@my.sctcc.edu', 'bradypeters', 'passwordhash1',  0, 0),
('RJ', 'Smith', '654321', 'rj.smith@my.sctcc.edu', 'rjsmith', 'passwordhash2', 1, 0),
('Kawhi', 'Leonard', '112233', 'kawhi.leonard@my.sctcc.edu', 'kawhileonard', 'passwordhash3', 0, 1);


-- Sample data for the items table
INSERT INTO Items (ItemName, ItemDesc, ItemCondition, ItemPrice, ItemQuantity, ItemWanted, ItemImage, UserID)
VALUES 
('Journeyman Textbook', 'Some random information about Journeyman.', 'Used - Like New', 20.99, 5, 0, 'image1.jpg', 1),
('Art of War', 'Some random information about Art of War.', 'New', 30.50, 10, 1, 'image2.jpg', 2),
('System Analysis', 'Some random information about System Analysis.', 'Used - Good', 25.99, 20, 0, 'image3.jpg', 3);

-- Query for User/Item information
SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    i.ItemID,
    i.ItemName,
    i.ItemDesc,
    i.ItemCondition,
    i.ItemPrice,
    i.ItemQuantity,
    i.ItemWanted,
    i.ItemImage
FROM 
    Users u
JOIN 
    Items i ON u.UserID = i.UserID;
    
-- Query for user information

SELECT *
FROM Users;
