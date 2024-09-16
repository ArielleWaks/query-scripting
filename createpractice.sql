-- Create table
CREATE TABLE Tasks (
    ID INT PRIMARY KEY,
    Category ENUM('household', 'personal', 'jobapp', 'coding'),
    Description VARCHAR(255),
    PointsGuess INT,
    DueDate DATE
);

-- Add table column
ALTER TABLE Tasks
ADD Status VARCHAR(255) DEFAULT 'Not Started';

-- Create table with constraints
CREATE TABLE Persons (
    ID int UNIQUE NOT NULL AUTO_INCREMENT,
    LastName varchar(255) UNIQUE NOT NULL,
    FirstName varchar(255),
    Age int,
    Email varchar(255),
    City varchar(255) DEFAULT 'St. Louis',
    CONSTRAINT PK_Person PRIMARY KEY (ID,LastName)
);

-- Drop column
ALTER TABLE Persons
DROP COLUMN Email;

-- Create table using another table
CREATE TABLE OldPersons AS
    SELECT LastName, FirstName, Age
    FROM Persons
    WHERE Age > 50;


-- Insert Into statement with multiple values
INSERT INTO Persons (LastName, FirstName, Age, Email)
VALUES
    ('Waks', 'Arielle', 30, 'aw@aol.com'),
    ('Witherspoon', 'Theo', 30, 'tw@hotmail.com'),
    ('Waks', 'Ruth', 59, 'rs@yearthlink.net');

-- Insert Into Select statement
INSERT INTO OldPersons
SELECT LastName, FirstName, Age FROM Persons
WHERE Age > 50;

-- Update statement
UPDATE Persons
SET LastName = 'Sontag', Age = 60
WHERE FirstName = 'Ruth';

-- Update multiple records
UPDATE Persons
SET City = 'Asheville'
WHERE Age < 40;

-- Update data basaed on another table using a sub query in the WHERE clause
UPDATE Persons
SET Email = 'outdated'
WHERE LastName IN (
    SELECT LastName
    FROM OldPersons
    );