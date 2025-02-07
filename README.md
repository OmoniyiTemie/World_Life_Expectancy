# World_Life_Expectancy

## Data Cleaning ##
This project involved cleaning the World Life Expectancy dataset using SQL, focusing on removing duplicates, handling missing values, and standardizing data to ensure accuracy for further analysis. Below is a structured summary of the key cleaning steps:

1. **Removing Duplicates**
  - Identified duplicate records based on the Country-Year combination, which serves as the unique identifier.
  - Used GROUP BY and COUNT() to detect duplicate entries.
  - Assigned a row number to each duplicate instance using the ROW_NUMBER() function and partitioning by Country-Year.
  - Deleted duplicate records while retaining only the first occurrence for each Country-Year.


2. **Handling Missing Values**

A) ***Status*** Column ('Developed' / 'Developing')
  - Identified records with blank Status values.
  - Used a self-join to populate missing values based on other rows where the same country had a valid Status.

B) ***Life Expectancy*** Column
  - Identified missing values in Life Expectancy.
  - Applied a trend-based imputation strategy, filling missing values by calculating the average of the previous and next year's values for the same country.
  - Implemented this using self-joins and an UPDATE query to replace blanks with interpolated values.
    
### Final Validation
Performed final checks to ensure no duplicate records or missing values remained. This project demonstrates a structured SQL-based data cleaning approach to ensure high quality data. The complete SQL scripts are included in this repository. 




------------------------------
