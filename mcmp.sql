CREATE DATABASE IF NOT EXISTS MCMP;
USE MCMP;

CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    StudentID VARCHAR(20),
StudentEmail VARCHAR(50) UNIQUE NOT NULL CHECK (StudentEmail LIKE '%@my.sctcc.edu' OR StudentEmail LIKE '%@sctcc.edu'), -- Constraint for emails to ensure it ends in either @my.sctcc.edu or @sctcc.edu
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

