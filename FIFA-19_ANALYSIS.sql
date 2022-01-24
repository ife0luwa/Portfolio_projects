USE Portfolio_projects


 
-- CREATING AN IDEAL MODERN FULLBACK AND MIDFIELD OPTIONS FOR MAN 
*/* Change the data type of the needed columns to integer using the CAST Function 
(after extracting the original ratings from LB and LWB columns with the LEFT function) */*

--LEFTBACK OPTIONS

SELECT DISTINCT Name,
ID,Overall,
CAST(Age AS int) AS Age_new,
CASE WHEN Age <= 21 THEN 'Youngster'
     WHEN Age BETWEEN 22 AND 27 THEN 'Mature'
	 WHEN Age  BETWEEN 28 AND 33 THEN 'Experienced' ELSE 'Veteran' END AS Age_group,
Club,Nationality,latitude,longitude,
(CAST(LEFT(LB,2) AS int)+ CAST(LEFT(LWB,2)AS int))/2  AS Tactial_awareness,
CAST(Crossing AS int) Crossing, CAST(Curve AS int) Curve, CAST(BallControl AS int) Ball_control, CAST(SprintSpeed AS int) Sprint_speed, 
CAST(ShortPassing AS int) Short_passing,  CAST(Agility AS int) Agility, CAST(Reactions AS int)Reactions,
CAST(Stamina AS int) Stamina, CAST(Positioning AS int) Positioning, CAST(Dribbling AS int) Dribbling, CAST(Composure AS int) Composure,
CAST(Marking AS int) Marking, CAST(StandingTackle AS int)Standing_tackle, CAST(SlidingTackle AS int) Sliding_tackle, 
CAST(Vision AS int) AS Vision,

(CAST(Crossing AS int)+CAST(Curve AS int)+CAST(BallControl AS int)+CAST(SprintSpeed AS int)+CAST(ShortPassing AS int)+ CAST(Agility AS int)+
CAST(Reactions AS int)+CAST(Stamina AS int)+CAST(Positioning AS int)+CAST(Dribbling AS int)+CAST(Composure AS int)+CAST(Marking AS int)+
CAST(StandingTackle AS int)+CAST(SlidingTackle AS int)+CAST(Vision AS int))/15 AS All_attributes,
Wage,
YEAR(Contract_Valid_Until) AS Contract_due
FROM fifa19data
INNER JOIN world_country_lat_and_long
ON fifa19data.Nationality = world_country_lat_and_long.country
WHERE Preferred_Foot = 'Left'
ORDER BY Tactial_awareness DESC, All_attributes DESC 

--RIGHTBACK OPTIONS
SELECT DISTINCT Name,
ID,Overall,
CAST(Age AS int) AS Age_new,
CASE WHEN Age <= 21 THEN 'Youngster'
     WHEN Age BETWEEN 22 AND 27 THEN 'Mature'
	 WHEN Age  BETWEEN 28 AND 33 THEN 'Experienced' ELSE 'Veteran' END AS Age_group,
Club,Nationality,latitude,longitude,
(CAST(LEFT(RB,2) AS int)+ CAST(LEFT(RWB,2)AS int))/2  AS Tactial_awareness,
CAST(Crossing AS int) Crossing, CAST(Curve AS int) Curve, CAST(BallControl AS int) Ball_control, CAST(SprintSpeed AS int) Sprint_speed, 
CAST(ShortPassing AS int) Short_passing,  CAST(Agility AS int) Agility, CAST(Reactions AS int)Reactions,
CAST(Stamina AS int) Stamina, CAST(Positioning AS int) Positioning, CAST(Dribbling AS int) Dribbling, CAST(Composure AS int) Composure,
CAST(Marking AS int) Marking, CAST(StandingTackle AS int)Standing_tackle, CAST(SlidingTackle AS int) Sliding_tackle, 
CAST(Vision AS int) AS Vision,

(CAST(Crossing AS int)+CAST(Curve AS int)+CAST(BallControl AS int)+CAST(SprintSpeed AS int)+CAST(ShortPassing AS int)+ CAST(Agility AS int)+
CAST(Reactions AS int)+CAST(Stamina AS int)+CAST(Positioning AS int)+CAST(Dribbling AS int)+CAST(Composure AS int)+CAST(Marking AS int)+
CAST(StandingTackle AS int)+CAST(SlidingTackle AS int)+CAST(Vision AS int))/15 AS All_attributes,
Wage,
YEAR(Contract_Valid_Until) AS Contract_due
FROM fifa19data
INNER JOIN world_country_lat_and_long
ON fifa19data.Nationality = world_country_lat_and_long.country
WHERE Preferred_Foot = 'Right'
ORDER BY Tactial_awareness DESC, All_attributes DESC 

-- MIDEFIELD OPTIONS
SELECT ID,Name,
CAST(Age AS int) AS Age_new,
CASE WHEN Age <= 21 THEN 'Youngster'
     WHEN Age BETWEEN 22 AND 27 THEN 'Mature'
	 WHEN Age  BETWEEN 28 AND 33 THEN 'Experienced' ELSE 'Veteran' END AS Age_group,
Overall,Club,Nationality,latitude,longitude,
(CAST(LEFT(CAM,2) AS int)+CAST(LEFT(CM,2) AS int) +CAST(LEFT(CDM,2) AS int))/3 AS  Tactical_awareness,
(CAST(BallControl AS int)+CAST(SprintSpeed AS int)+CAST(Reactions AS int)+CAST(Stamina AS int)+CAST(Positioning AS int)+CAST(Composure AS int)
+CAST(Marking AS int)+CAST(Vision AS int)+CAST(ShortPassing AS int)+CAST(LongPassing AS int)+CAST(Interceptions AS int))/11 AS All_attributes,
CASE WHEN Height < '06:00' THEN 3
     WHEN Height >= '06:00' THEN 5 END AS Height_point,
Wage,
YEAR(Contract_Valid_Until) AS Contract_due
FROM fifa19data
INNER JOIN world_country_lat_and_long
ON fifa19data.Nationality = world_country_lat_and_long.country
ORDER BY Age_new ASC,Tactical_awareness DESC,All_attributes DESC



-- Analyzing England Top 6 football Club Wage bill

-- Using The SUBSTRING and CHARINDEX function to extract the Wage_new (in integer) from the Wage column
*/* Also I joined the fifa19data table with the world_country_lat_and_long table on (Nationality and country) 
to get the latitude and longitude column for the purpose of map visualization */*

SELECT Name,Age,Overall,Club,Release_Clause,Wage,
CAST (SUBSTRING(Wage, (CHARINDEX ('€',Wage))+1,(CHARINDEX ('K',Wage) - (CHARINDEX ('€',Wage)+1))) AS int) Wage_new,
Nationality,latitude,longitude,
Contract_Valid_Until AS Contract_due
FROM fifa19data
INNER JOIN world_country_lat_and_long
ON fifa19data.Nationality = world_country_lat_and_long.country
WHERE  Club ='Chelsea' OR Club = 'Manchester United' OR Club = 'Liverpool' OR Club = 'Manchester City' OR Club = 'Arsenal' 
 OR Club = 'Tottenham Hotspur' 
 ORDER BY Wage_new DESC