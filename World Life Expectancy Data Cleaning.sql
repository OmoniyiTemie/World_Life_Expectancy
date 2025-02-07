# World Life Expectancy Project (Data Cleaning)


SELECT * 
FROM world_life_expectancy
;

# N.B --> Create a STAGING/BACKUP!!!

# First Step - Remove Duplicates
# The Unique Identifier is the 'Country-Year Combination'


									#1) REMOVING DUPLICATES

##A)

SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year) # We have an aggregation in the 'SELECT' statement
;
# For example, we notice that we have "Zimbabwe2019" occuring twice in the output of the above query


##B)

SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year) # We have an aggregation in the 'SELECT' statement
HAVING COUNT(CONCAT(Country, Year)) > 1
;

# From the table we can see that each row has a unique "Row_ID", we need to identify the duplicates in those "Row_IDs"
# Splitting the duplicates, we can assign a 'ROW_NUMBER/PARTITION BY'


##C)

SELECT Row_ID, 
	CONCAT(Country, Year),
    ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS row_num
FROM world_life_expectancy
;

# Filtering the above: we have to use the above as a subquery


##D)

SELECT *
FROM (
	SELECT Row_ID, 
			CONCAT(Country, Year),
			ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS row_num
	FROM world_life_expectancy) AS row_table
WHERE row_num > 1 								# ------------Filtering
;
# The resulting table shows the actual duplicates.


##E)

# Deleting Duplicates

DELETE FROM world_life_expectancy
WHERE Row_ID IN (
				SELECT Row_ID
				FROM (
						SELECT Row_ID, 
								CONCAT(Country, Year),
								ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS row_num
						FROM world_life_expectancy) AS row_table
						WHERE row_num > 1 
				)
;

# FIRST STEP CONCLUDED: DUPLICATES REMOVED!!!!!!!




									#2) CHECKING FOR BLANKS
							
##A)     ----     "STATUS"   ---- 'Developing' / 'Developed'

# Checking for the blanks in this column

SELECT * 
FROM world_life_expectancy
WHERE Status = ''
;


#Checking the possible entry options/values for the column

SELECT DISTINCT(Status)
FROM world_life_expectancy
;

# Joining the table to itself, while "UPDATING"

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2			# Joining the table to itself
	ON t1.Country = t2. Country
    
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.status <> ''
AND t2.Status = 'Developing'
;
# Changes effected for "Developing Countries"

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2			# Joining the table to itself
	ON t1.Country = t2. Country
    
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.status <> ''
AND t2.Status = 'Developed'
;
# Changes effected for "Developing Countries"




##B)     ----     "LIFE_EXPECTANCY"  

SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;
# We have two rows in question
# I noticed that the "Life_Expectancy" follows a certain trend and it might be best to populate the cells with an AVERAGE value of the preceding and following row

SELECT t1.Country, t1.Year, t1.`Life expectancy`, 
		t2.Country, t2.Year, t2.`Life expectancy`,
        t3.Country, t3.Year, t3.`Life expectancy`
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	on t1.Country = t2. Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	on t1.Country = t3. Country
    AND t1.Year = t3.Year + 1
    # FILTERING DOWN
WHERE t1.`Life expectancy` = ''
;

# UPDATING:
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2. Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
# SETTING
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2 , 1)
WHERE t1.`Life expectancy` = ''
;

# CHECKING:
SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
;








