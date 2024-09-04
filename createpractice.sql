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
    ID int UNIQUE NOT NULL,
    LastName varchar(255) UNIQUE NOT NULL,
    FirstName varchar(255),
    Age int,
    Email varchar(255),
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
