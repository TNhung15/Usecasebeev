CREATE TABLE car_data (
    Make VARCHAR(255)NOT NULL,
    Model VARCHAR(255) NOT NULL,
    "Year" INTEGER NOT NULL,
    Price INTEGER,
    EngineType VARCHAR(255),
    PRIMARY KEY (Make, Model, "Year")
);
select * from car_data

CREATE TABLE consumer_data (
    Country VARCHAR(255),
    Make VARCHAR(255) NOT NULL,
    Model VARCHAR(255) NOT NULL,
    "Year" INTEGER NOT NULL,
    ReviewScore DECIMAL(5,1),
    SalesVolume INTEGER,
    PRIMARY KEY (ID),
    Constraint FK FOREIGN KEY (Make, Model, "Year") REFERENCES car_data(Make, Model, "Year")
);


copy public."car_data" FROM 'C:\Users\nghie\OneDrive\Desktop\Projet_Beev\car_data.csv'
DELIMITER ',' CSV HEADER;

-- find the total number of cars by model by country
SELECT 
    Country,
    Model,
    COUNT(*) AS TotalCars
FROM 
    consumer_data
GROUP BY 
    Country, Model;

-- which country has the most of each model
WITH Model_Counts AS (
    SELECT
        cr.Country,
        cr.Model,
        COUNT(*) AS ModelCount
    FROM
        consumer_data cr
    GROUP BY
        cr.Country, cr.Model
)
SELECT
    mc.Country,
	mc.Model,
    MAX(mc.ModelCount) AS MaxModelCount
FROM
    Model_Counts mc
GROUP BY
    mc.Country, mc.Model;


-- any model is sold in the USA but not in France.
SELECT DISTINCT cr.Model
FROM consumer_data cr
WHERE
    cr.Country = 'USA'
    AND cr.Model NOT IN (
        SELECT
            cr.Model
        FROM
            consumer_data cr
        WHERE
            cr.Country = 'France'
    );


-- how much the average car costs in every country by engine type.
SELECT
    Country, 
	EngineType,
    AVG(Price) AS AverageCarPrice
FROM
    car_data
NATURAL JOIN
    consumer_data 
GROUP BY
    Country, EngineType;


-- the average ratings of electric cars vs thermal cars
SELECT
    EngineType,
    AVG(ReviewScore) AS AverageRating
FROM
    consumer_data NATURAL JOIN car_data
WHERE
    EngineType IN ('Electric', 'Thermal')
GROUP BY
    EngineType;


-- the amount of electric vs thermal cars sold per year.
SELECT
    ca.Year,
    ca.EngineType,
    SUM(cr.SalesVolume) AS TotalSalesVolume
FROM car_data ca NATURAL JOIN consumer_data cr
WHERE
    ca.EngineType IN ('Electric', 'Thermal') 
GROUP BY
    ca.Year, ca.EngineType;