--Show all tables
SHOW TABLES;

--Show table structure
DESCRIBE ART_OBJECTS;
DESCRIBE PAINTING;
DESCRIBE SCULPTURE_STATUE;
DESCRIBE OTHER_ART_OBJECTS;
DESCRIBE ARTIST;
DESCRIBE EXHIBITIONS;
DESCRIBE COLLECTIONS;
DESCRIBE USERS;
DESCRIBE BORROWED;
DESCRIBE PERMANENT_COLLECTION;

--Basic retrieval query
SELECT * FROM ART_OBJECTS;

--Retrieval query with ordered results
SELECT * FROM ART_OBJECTS ORDER BY Year;

--Nested Retrieval query
SELECT * FROM ARTIST
WHERE Name IN (
    SELECT DISTINCT Artist
    FROM ART_OBJECTS
    WHERE Year > 1600
);

--Retrieval query using joined tables
SELECT ART_OBJECTS.Id_no, ART_OBJECTS.Title, ARTIST.Name AS ArtistName
FROM ART_OBJECTS
JOIN ARTIST ON ART_OBJECTS.Artist = ARTIST.Name;

--Update operation with any necessary triggers (none)
UPDATE ART_OBJECTS
SET Year = 1600
WHERE Id_no = 1;

--Delete operation with any necessary triggers (trigger implemented in main script)
DELETE FROM ART_OBJECTS
WHERE Id_no = 1;



