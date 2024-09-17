
-- Create table with constraints
CREATE TABLE Persons (
    PersonID INT UNIQUE NOT NULL AUTO_INCREMENT,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    Email VARCHAR(255),
    City VARCHAR(255) DEFAULT 'St. Louis',
    PRIMARY KEY (PersonID)
);

-- Drop column
ALTER TABLE Persons
DROP COLUMN Email;

DROP TABLE Tasks;

-- Create table using another table
CREATE TABLE OldPersons AS
    SELECT LastName, FirstName, Age
    FROM Persons
    WHERE Age > 50;

-- Create table
CREATE TABLE Tasks (
    TaskID INT,
    Category ENUM('household', 'personal', 'jobapp', 'coding'),
    Description VARCHAR(255),
    PointsGuess INT,
    DueDate DATE,
    PersonID INT,
    PRIMARY KEY (TaskID),
    FOREIGN KEY (PersonID) REFERENCES Persons(PersonID) ON DELETE CASCADE
);

-- Add table column
ALTER TABLE Tasks
    ADD Status VARCHAR(255) DEFAULT 'Not Started';


-- Add table foreign id
# ALTER TABLE Tasks
# ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID) ON DELETE CASCADE;

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

-- Add foreign id to table

