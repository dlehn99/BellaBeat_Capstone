# BellaBeat_Capstone

## Introduction
For my project I wanted to look at the correlation between sleep quality and activity level. There is a common belief that you sleep better if you have a physically strenuous day so I wanted to exam fitness data to see if the belief holds true. If there is a correlation, I then want to exam and see what activity level results in the best sleep quality, or if too much physical activity can cause a detriment to a person’s sleep.</br>
</br>In this case study, I will be preparing the data for cleaning, checking the integrity of the data, updating any errors found, and lastly analyzing the data before creating a conclusive report.</br>

## Resources
The fitness dataset I pulled from is the Kaggle Fitbit dataset from the [FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit) that has eighteen tables where I pulled twelve for use.
 
**Tables used:**
- dailyActivity
- dailyCalories
- dailyIntensities
- dailySteps
- sleepDay
- hourlyCalories
- hourlySteps
- hourlyIntensities
- minutesSteps_Narrow
- minutesCalories_Narrow
- minutesSleep</br>

</br>The limitations of this dataset is that there are only twenty-four participants in it, some with activity level information but no sleep data to be used. There is also the limitation of this data being a secondary source as well as possible personal elements that could affect the person’s sleep quality. This could be anything from sleep apnea to medication that could skew the results of the dataset.</br>
</br>An additional resource used was the [Fitabase Data Dictionary](https://www.fitabase.com/media/1930/fitabasedatadictionary102320.pdf) to help organize and define the columns in the tables.</br>

## Preparing the Data
For the organizing and cleaning of the dataset I used SQL since it would allow me to easily view the tables for manipulation. To organize the dataset I first started by changing the format of the table and column names so they would be easier to read. This involved changing the table names to camel case, the columns to lower case, and both to snake case. I also changed the names of the tables and columns to be more concise while retaining their meaning. For the columns that mostly involved changing the date and datetime datatype to *log_date* and *log_datetime* and the *id*, which represents the individual participants, to *client_id*.</br>
</br>Below are the following name changes I made to the tables.

**Table Name Changes:**
- dailyActivity -> Daily_Log
- dailyCalories -> Daily_Calories
- dailyIntensities -> Activity_Log
- dailySteps -> Daily_Steps
- sleepDay -> Daily_Sleep
- hourlyCalories -> Calorie_Hour_Log
- hourlySteps -> Step_Hour_Log
- hourlyIntensities -> Intensity_Hour_Log
- minutesSteps_Narrow -> Step_Minute_Log
- minutesCalories_Narrow -> Calorie_Minute_Log
- minutesSleep -> Sleep_Minute_Log</br>

</br>After organizing the tables, the biggest issue I faced was in joining the tables to check the integrity of the information between them; the reason for this is because there was no primary or foreign keys to link them. To make these tables easy to group and join I decided to create a unique primary and foreign key for them. For the daily tables I created a *log_id*, the hour tables an *hour_id*, and the minute tables a *minute_id* columm. Though the minute tables had both an *hour_id* and *log_id* and the hour tables had a *log_id* as a foreign key for said joining.</br>
</br>Below is the guide used to create the primary keys.

**Primary Key Creation:**
- *log_id* -> (first five digits of *client_id*) + month + day
- *hour_id* -> (first five digits of *client_id*) + month + day + hour
- *minute_id* -> (first five digits of *client_id*) + month + day + hour + minute</br>

</br>To easily create the keys though I first needed to format the *log_date* and *log_datetime* columns into a "mm/dd/yyyy" format and the time portion from a standard time to military format. This was beneficial in multiple ways since it would also allow for the columns to have a unified length and be more easily organized by either ascending or descending.</br>

## Data Cleaning
The cleaning process, once the primary and foreign keys were added, had a couple different steps. The majority of it was cross-examining the column totals between tables and, if there was any discrepancies, they were updated based on the more detailed table information, in this case it was the minute tables. There was also instances of the minute tables having less information than the daily and hour tables, though it was few with only a six row difference. In this case, since the information was not able to be cross-examined, they were dropped from them.</br>

</br>The biggest endeavour in the cleaning was the sleep table information. They had both significantly less rows than the activity tables as well as the issue of joining of the daily sleep data with the activity information. This is because there was some *sleep_record_id*'s that had a different start *log_date* than the end date leading to the sleep data being grouped with the wrong activity data day. I was able to fix this by creating a new *log_id* based on the *sleep_cycle_start* date, though there is a flaw in this as well. This is because there was also individuals that go to bed after midnight and therefore will have a *log_id* joined on the next days information instead of the prior days activity. I fixed this problem by adding one to the *log_id* for those *sleep_record_id* entries.</br>

### Data Maniplution
After the cleaning I also added certain columns to help clarify the information in the tables. This information was pulled from the [Fitabase Data Dictionary](https://www.fitabase.com/media/1930/fitabasedatadictionary102320.pdf), such as defining the *intensity_level_id* and *sleep_state_id*. I also added from the data dictionary the *sleep_score* column which is calculated by multipling the *minutes_asleep* by one-hundred and then dividing by the *time_in_bed*.</br>

</br>I then consolidated the hour and minute tables while adding the daily sleep information to the daily log table. I then dropped duplicate information that was in both the activity log and the daily log table, because despite having the least amount of rows the daily tables has the most columns. To keep the tables easy to read I kept the activity log table seperate and got rid of duplicate information. I then condensed the rows of the daily datasets, both the daily log and activity log tables, to the information that had matching sleep data.</br>

### Final Data Integrity Check
Lastly, before I export the tables for analysis I did a final check of the data integrity. After doing so, I exported the tables as cvs files and saved the SQL cleaning information. SQL cleaning log will all be linked to the main repository.
