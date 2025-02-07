# World_Life_Expectancy

## Data Cleaning 
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


## Exploratory Data Analysis
This project involved exploratory data analysis (EDA) of the World Life Expectancy dataset using SQL. The analysis aimed to uncover trends, correlations, and insights related to life expectancy across countries and years. Below are the key steps performed:

1. **Life Expectancy Analysis**
  A) Global Trends in Life Expectancy
  - Calculated the average life expectancy per year to observe global trends over time.
  - Excluded zero values to avoid skewing the results.
    
  B) Country-Level Life Expectancy Changes
  - Measured improvements or declines in life expectancy for each country by comparing their minimum and maximum recorded life expectancy values.
  - Ranked countries based on the largest increase in life expectancy over the years.

    
2. **Correlation Analysis**
  ***Life Expectancy vs. GDP***
  - Computed the average life expectancy and GDP per country to examine their relationship.
  - Analyzed whether higher GDP is associated with longer life expectancy by categorizing countries into High GDP (≥1500) and Low GDP (<1500) groups.
  - Compared the average life expectancy for High-GDP and Low-GDP countries.

    
3. **Status-Based Analysis**
   Compared Developed vs. Developing countries in terms of:
    - Average life expectancy
    - Number of distinct countries in each group
    - Checked for possible data skewness due to fewer developed countries in the dataset.

      
4. **BMI and Life Expectancy**
  - Investigated the relationship between Body Mass Index (BMI) and life expectancy.
  - Ranked countries based on their average BMI and observed its potential influence on life expectancy.


5. **Adult Mortality Trends**
  - Examined Adult Mortality trends in the United States over time.
  - Used a rolling sum calculation to track cumulative adult mortality per year.

    
### Final Insights
This project provides a comprehensive view of factors affecting life expectancy globally. It highlights the influence of GDP, BMI, and adult mortality while also examining improvements in life expectancy over time. The full SQL scripts are available in this repository.
