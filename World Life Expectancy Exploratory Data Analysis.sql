# World Life Expectancy Project (EDA)


SELECT *
FROM world_life_expectancy
;




											# LIFE EXPECTANCY ANALYSIS
                  
						# A) Checking the Average Life Expectancy for each Year FOR THE WORLD

SELECT  Year , ROUND(AVG(`Life expectancy`), 2) AS AVG_LIFE_EXPECTANCY
FROM world_life_expectancy
WHERE `Life expectancy` <> 0				# This is done to avoid the zeroes from affecting the calculation of the averages
GROUP BY Year
ORDER BY Year
;
                  
                  
                  
						# B) Checking how the countries have managed to improve their Life Expectancy over the years(or not)
                  
SELECT Country,
				MIN(`Life expectancy`), 
				MAX(`Life expectancy`), 
				ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Incr
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0				# I noticed some zeroes
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Incr DESC
;



						# C) Correlation Analysis

# Life Expectancy vs GDP (per country)

SELECT Country, 
		ROUND(AVG(`Life expectancy`), 1) AS AVG_LIFE_EXP, 
        ROUND(AVG(GDP), 1) AS AVG_GDP
FROM world_life_expectancy
GROUP BY Country
HAVING AVG_LIFE_EXP > 0				# I noticed some zeroes
AND AVG_GDP > 0
ORDER BY AVG_GDP DESC
;



# Average Life Expectancy and Average GDP
SELECT Country, 
		ROUND(AVG(`Life expectancy`), 1) AS AVG_LIFE_EXP, 
        ROUND(AVG(GDP), 1) AS AVG_GDP,
        CASE 
			WHEN GDP >= 1500 THEN 1 
			ELSE 0
			END AS High_GDP
FROM world_life_expectancy
;



# Average Life Expectancy for Countries with a 'High GDP' AND 'Low GDP'

SELECT 
	SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS High_GDP_Count,
	AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) AS High_GDP_Life_Expectancy,
	SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) AS Low_GDP_Count,
	AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) AS Low_GDP_Life_Expectancy
FROM world_life_expectancy
;



							# D) STATUS

SELECT Status, ROUND(AVG(`Life expectancy`), 1)
FROM world_life_expectancy
GROUP BY Status
;


SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`), 1) 	# data might be possibly skewed as we don't have as much representation for developed countries
FROM world_life_expectancy
GROUP BY Status
;



							# D) BMI
                            
SELECT Country, BMI
FROM world_life_expectancy
;
                            
                            
SELECT Country, 
		ROUND(AVG(`Life expectancy`), 1) AS AVG_LIFE_EXP, 
        ROUND(AVG(BMI), 1) AS AVG_BMI
FROM world_life_expectancy
GROUP BY Country
HAVING AVG_LIFE_EXP > 0				
AND AVG_BMI > 0
ORDER BY AVG_BMI DESC
;                  


							# D) ADULT MORTALITY
                            
# For the United States: Adult Mortality over the years
SELECT Country,
		Year,
        `Life expectancy`,
        `Adult Mortality`,
        SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%America%'
        








