						/* ORGANIZING THE TABLES AND COLUMNS FOR CLEANING */

/*
	-log_date and log_datetime formating to mm/dd/yyyy and mm/dd/yyyy hh:mm:ss
	-changing the log_datetime to military time
	-create a log_id, hour_id, and minute_id for the daily, hourly, and minute tables
*/

UPDATE
	Activity_Log
SET
	log_date = "0" || log_date;

	
UPDATE
	Activity_Log
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;

	
UPDATE
	Daily_Log
SET
	log_date = "0" || log_date;

	
UPDATE
	Daily_Log
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;

	
UPDATE
	Daily_Calories
SET
	log_date = "0" || log_date;

	
UPDATE
	Daily_Calories
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;

	
UPDATE
	Daily_Steps
SET
	log_date = "0" || log_date;

	
UPDATE
	Daily_Steps
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;

	
UPDATE
	Daily_Sleep
SET
	log_date = trim(substr(log_date, 1, 9));


UPDATE
	Daily_Sleep
SET
	log_date = "0" || log_date;

	
UPDATE
	Daily_Sleep
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;


UPDATE
	Calorie_Hour_Log
SET
	log_datetime = "0" || log_datetime;


UPDATE
	Calorie_Hour_Log
SET
	log_datetime = substr(log_datetime, 1, 3) || "0" ||substr(log_datetime, 4)
WHERE
	length(log_datetime) = 20;

	
CREATE TABLE "Calorie_Hour_Log_v2" AS

SELECT
	*,
	trim(substr(log_datetime, 1, 10)) AS [log_date],
	trim(substr(log_datetime, 11, 9)) AS [time],
	trim(substr(log_datetime, 20, 3)) AS [am_pm]
FROM
	Calorie_Hour_Log;


UPDATE
	Calorie_Hour_Log_v2
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;

	
UPDATE
	Calorie_Hour_Log_v2
SET
	time = (time + 12) || ":00:00"
WHERE
	am_pm = "PM" AND
	time NOT LIKE "12%";

	
UPDATE
	Calorie_Hour_Log_v2
SET
	time = "00:00:00"
WHERE
	am_pm = "AM" AND
	time LIKE "12%";

	
UPDATE
	Calorie_Hour_Log_v2
SET
	time = "0" || time
WHERE
	length(time) = 7;

	
UPDATE
	Intensity_Hour_Log
SET
	log_datetime = "0" || log_datetime;


UPDATE
	Intensity_Hour_Log
SET
	log_datetime = substr(log_datetime, 1, 3) || "0" ||substr(log_datetime, 4)
WHERE
	length(log_datetime) = 20;

	
CREATE TABLE "Intensity_Hour_Log_v2" AS

SELECT
	*,
	trim(substr(log_datetime, 1, 10)) AS [log_date],
	trim(substr(log_datetime, 11, 9)) AS [time],
	trim(substr(log_datetime, 20, 3)) AS [am_pm]
FROM
	Intensity_Hour_Log;

	
UPDATE
	Intensity_Hour_Log_v2
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;

	
UPDATE
	Intensity_Hour_Log_v2
SET
	time = (time + 12) || ":00:00"
WHERE
	am_pm = "PM" AND
	time NOT LIKE "12%";

	
UPDATE
	Intensity_Hour_Log_v2
SET
	time = "00:00:00"
WHERE
	am_pm = "AM" AND
	time LIKE "12%";

	
UPDATE
	Intensity_Hour_Log_v2
SET
	time = "0" || time
WHERE
	length(time) = 7;

	
UPDATE
	Step_Hour_Log
SET
	log_datetime = "0" || log_datetime;
	

UPDATE
	Step_Hour_Log
SET
	log_datetime = substr(log_datetime, 1, 3) || "0" ||substr(log_datetime, 4)
WHERE
	length(log_datetime) = 20;

	
CREATE TABLE "Step_Hour_Log_v2" AS

SELECT
	*,
	trim(substr(log_datetime, 1, 10)) AS [log_date],
	trim(substr(log_datetime, 11, 9)) AS [time],
	trim(substr(log_datetime, 20, 3)) AS [am_pm]
FROM
	Step_Hour_Log;

	
UPDATE
	Step_Hour_Log_v2
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;

	
UPDATE
	Step_Hour_Log_v2
SET
	time = (time + 12) || ":00:00"
WHERE
	am_pm = "PM" AND
	time NOT LIKE "12%";

	
UPDATE
	Step_Hour_Log_v2
SET
	time = "00:00:00"
WHERE
	am_pm = "AM" AND
	time LIKE "12%";

	
UPDATE
	Step_Hour_Log_v2
SET
	time = "0" || time
WHERE
	length(time) = 7;


CREATE TABLE "Calorie_Minute_Log_v2" AS

SELECT
	*,
	trim(substr(log_datetime, 1, 9)) AS [log_date],
	trim(trim(trim(substr(log_datetime, 10), "AM"), "P")) AS [time],
	trim(trim(substr(log_datetime, 18), "0")) AS [am_pm]
FROM
	Calorie_Minute_Log;


UPDATE
	Calorie_Minute_Log_v2
SET
	log_date = "0" || log_date;


UPDATE
	Calorie_Minute_Log_v2
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;


UPDATE
	Calorie_Minute_Log_v2
SET
	time = "0" || time
WHERE
	length(time) = 7;


CREATE TABLE "Calorie_Minute_Log_v3" AS
	
SELECT
	client_id,
	log_datetime,
	calories,
	log_date,
	substr(time, 1, 2) AS [hour],
	substr(time, 3) AS [minute_sec],
	am_pm
FROM
	Calorie_Minute_Log_v2;


UPDATE
	Calorie_Minute_Log_v3
SET
	hour = (hour + 12)
WHERE
	am_pm = "PM" AND
	hour <> "12";


UPDATE
	Calorie_Minute_Log_v3
SET
	hour = "00"
WHERE
	am_pm = "AM" AND
	hour = "12";

	
CREATE TABLE "Calorie_Minute_Log_v4" AS
	
SELECT
	client_id,
	log_datetime,
	calories,
	log_date,
	hour || minute_sec AS [time],
	am_pm
FROM
	Calorie_Minute_Log_v3;

	
CREATE TABLE "Intensity_Minute_Log_v2" AS

SELECT
	*,
	trim(substr(log_datetime, 1, 9)) AS [log_date],
	trim(trim(trim(substr(log_datetime, 10), "AM"), "P")) AS [time],
	trim(trim(substr(log_datetime, 18), "0")) AS [am_pm]
FROM
	Intensity_Minute_Log;


UPDATE
	Intensity_Minute_Log_v2
SET
	log_date = "0" || log_date;


UPDATE
	Intensity_Minute_Log_v2
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;


UPDATE
	Intensity_Minute_Log_v2
SET
	time = "0" || time
WHERE
	length(time) = 7;


CREATE TABLE "Intensity_Minute_Log_v3" AS
	
SELECT
	client_id,
	log_datetime,
	intensity_level_id,
	log_date,
	substr(time, 1, 2) AS [hour],
	substr(time, 3) AS [minute_sec],
	am_pm
FROM
	Intensity_Minute_Log_v2;


UPDATE
	Intensity_Minute_Log_v3
SET
	hour = (hour + 12)
WHERE
	am_pm = "PM" AND
	hour <> "12";


UPDATE
	Intensity_Minute_Log_v3
SET
	hour = "00"
WHERE
	am_pm = "AM" AND
	hour = "12";

	
CREATE TABLE "Intensity_Minute_Log_v4" AS
	
SELECT
	client_id,
	log_datetime,
	intensity_level_id,
	log_date,
	hour || minute_sec AS [time],
	am_pm
FROM
	Intensity_Minute_Log_v3;

	
CREATE TABLE "Step_Minute_Log_v2" AS

SELECT
	*,
	trim(substr(log_datetime, 1, 9)) AS [log_date],
	trim(trim(trim(substr(log_datetime, 10), "AM"), "P")) AS [time],
	trim(trim(substr(log_datetime, 18), "0")) AS [am_pm]
FROM
	Step_Minute_Log;


UPDATE
	Step_Minute_Log_v2
SET
	log_date = "0" || log_date;


UPDATE
	Step_Minute_Log_v2
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;


UPDATE
	Step_Minute_Log_v2
SET
	time = "0" || time
WHERE
	length(time) = 7;


CREATE TABLE "Step_Minute_Log_v3" AS
	
SELECT
	client_id,
	log_datetime,
	steps,
	log_date,
	substr(time, 1, 2) AS [hour],
	substr(time, 3) AS [minute_sec],
	am_pm
FROM
	Step_Minute_Log_v2;


UPDATE
	Step_Minute_Log_v3
SET
	hour = (hour + 12)
WHERE
	am_pm = "PM" AND
	hour <> "12";


UPDATE
	Step_Minute_Log_v3
SET
	hour = "00"
WHERE
	am_pm = "AM" AND
	hour = "12";

	
CREATE TABLE "Step_Minute_Log_v4" AS
	
SELECT
	client_id,
	log_datetime,
	steps,
	log_date,
	hour || minute_sec AS [time],
	am_pm
FROM
	Step_Minute_Log_v3;

	
CREATE TABLE "Sleep_Minute_Log_v2" AS
	
SELECT DISTINCT
	*
FROM
	Sleep_Minute_Log;
	
/*
SELECT
	*
FROM
	Sleep_Minute_Log_v2;
			{Result: 187978 rows returned}
*/


CREATE TABLE "Sleep_Minute_Log_v3" AS

SELECT
	*,
	trim(substr(log_datetime, 1, 9)) AS [log_date],
	trim(trim(trim(substr(log_datetime, 10), "AM"), "P")) AS [time],
	trim(trim(substr(log_datetime, 18), "0")) AS [am_pm]
FROM
	Sleep_Minute_Log_v2;


UPDATE
	Sleep_Minute_Log_v3
SET
	log_date = "0" || log_date;


UPDATE
	Sleep_Minute_Log_v3
SET
	log_date = substr(log_date, 1, 3) || "0" ||substr(log_date, 4)
WHERE
	length(log_date) = 9;


UPDATE
	Sleep_Minute_Log_v3
SET
	time = "0" || time
WHERE
	length(time) = 7;


CREATE TABLE "Sleep_Minute_Log_v4" AS
	
SELECT
	client_id,
	log_datetime,
	sleep_state_id,
	sleep_record_id,
	log_date,
	substr(time, 1, 2) AS [hour],
	substr(time, 3) AS [minute_sec],
	am_pm
FROM
	Sleep_Minute_Log_v3;


UPDATE
	Sleep_Minute_Log_v4
SET
	hour = (hour + 12)
WHERE
	am_pm = "PM" AND
	hour <> "12";


UPDATE
	Sleep_Minute_Log_v4
SET
	hour = "00"
WHERE
	am_pm = "AM" AND
	hour = "12";

	
CREATE TABLE "Sleep_Minute_Log_v5" AS
	
SELECT
	client_id,
	log_datetime,
	sleep_state_id,
	sleep_record_id,
	log_date,
	hour || minute_sec AS [time],
	am_pm
FROM
	Sleep_Minute_Log_v4;

	
UPDATE
	Sleep_Minute_Log_v5
SET
	time = substr(time, 1, 6) || "00";

	
/* creating primary and foreign keys */


CREATE TABLE "Activity_Log_v2" AS

SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	*
FROM
	Activity_Log;
	

CREATE TABLE "Daily_Log_v2" AS

SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	*
FROM
	Daily_Log;
	
	
CREATE TABLE "Daily_Sleep_v2" AS
	
SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	*
FROM
	Daily_Sleep;
	

CREATE TABLE "Daily_Calories_v2" AS

SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	*
FROM
	Daily_Calories;
	
	
CREATE TABLE "Daily_Steps_v2" AS

SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	*
FROM
	Daily_Steps;
	

CREATE TABLE "Calorie_Hour_Log_v3" AS

SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) ||  substr(time, 1, 2) AS [hour_id],
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	client_id,
	log_date || " " || time AS [log_datetime],
	calories
FROM
	Calorie_Hour_Log_v2;
	

CREATE TABLE "Intensity_Hour_Log_v3" AS

SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) ||  substr(time, 1, 2) AS [hour_id],
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	client_id,
	log_date || " " || time AS [log_datetime],
	intensity_total,
	avg_intensity
FROM
	Intensity_Hour_Log_v2;
	

CREATE TABLE "Step_Hour_Log_v3" AS

SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) ||  substr(time, 1, 2) AS [hour_id],
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	client_id,
	log_date || " " || time AS [log_datetime],
	steps
FROM
	Step_Hour_Log_v2;
	

CREATE TABLE "Calorie_Minute_Log_v5" AS

SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) ||  substr(time, 1, 2) || substr(time, 4, 2) AS [minute_id], 
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) ||  substr(time, 1, 2) AS [hour_id],
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	client_id,
	log_date || " " || time AS [log_datetime],
	calories
FROM
	Calorie_Minute_Log_v4;
	
	
CREATE TABLE "Intensity_Minute_Log_v5" AS
	
SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) ||  substr(time, 1, 2) || substr(time, 4, 2) AS [minute_id], 
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) ||  substr(time, 1, 2) AS [hour_id],
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	client_id,
	log_date || " " || time AS [log_datetime],
	intensity_level_id
FROM
	Intensity_Minute_Log_v4;
	
	
CREATE TABLE "Sleep_Minute_Log_v6" AS
	
SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) ||  substr(time, 1, 2) || substr(time, 4, 2) AS [minute_id], 
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) ||  substr(time, 1, 2) AS [hour_id],
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	client_id,
	log_date || " " || time AS [log_datetime],
	sleep_state_id,
	sleep_record_id
FROM
	Sleep_Minute_Log_v5;
	
	
CREATE TABLE "Step_Minute_Log_v5" AS
	
SELECT
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) ||  substr(time, 1, 2) || substr(time, 4, 2) AS [minute_id], 
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) ||  substr(time, 1, 2) AS [hour_id],
	substr(client_id, 1, 5) || substr(log_date, 1, 2) || substr(log_date, 4, 2) AS [log_id],
	client_id,
	log_date || " " || time AS [log_datetime],
	steps
FROM
	Step_Minute_Log_v4;

	
								/* CROSS-EXAMINING AND CLEANING */
/*
	-checking the values between daily, hourly and minute tables
	-updating information where there are indiscrepancies based on minute table information
	-removing excess rows that are not in the minute table information
	
	The matching, or validity, of the information between tables will be denoted with a '0 rows returned' 
since I will be using the conditional clause of not equal[<>].
*/

/*
SELECT
	hour_id,
	log_id,
	client_id,
	ROUND(total(calories)) AS [calories]
FROM
	Calorie_Minute_Log_v5
GROUP BY
	hour_id;
			{Result: 22093 rows returned}


SELECT
	*
FROM
	Calorie_Hour_Log_v3;
			{Result: 22099 rows returned}


SELECT
	a.*,
	b.calories
FROM
	(SELECT
		hour_id,
		log_id,
		client_id,
		ROUND(total(calories)) AS [calories]
	FROM
		Calorie_Minute_Log_v5
	GROUP BY
		hour_id) AS a
LEFT JOIN
	Calorie_Hour_Log_v3 AS b
ON
	a.hour_id = b.hour_id;
			{Result: 0 rows returned}
*/
		

CREATE TABLE "Calorie_Hour_Log_v4" AS

SELECT
	b.*
FROM
	(SELECT
		hour_id,
		log_id,
		client_id,
		ROUND(total(calories)) AS [calories]
	FROM
		Calorie_Minute_Log_v5
	GROUP BY
		hour_id) AS a
LEFT JOIN
	 Calorie_Hour_Log_v3 AS b
ON
	a.hour_id = b.hour_id;


/*	
SELECT
	log_id,
	client_id,
	total(calories)
FROM
	Calorie_Hour_Log_v4
GROUP BY
	log_id;
			{Result: 934 rows returned}
			
SELECT
	*
FROM
	Daily_Calories_v2;
			{Result: 940 rows returned}
			
SELECT
	*
FROM
	(SELECT
		log_id,
		client_id,
		total(calories) AS [calories]
	FROM
		Calorie_Hour_Log_v4
	GROUP BY
		log_id) AS a
LEFT JOIN
	 Daily_Calories_v2 AS b
ON
	a.log_id = b.log_id
WHERE
	a.calories <> b.calories;
			{Result: 802 rows returned}
*/
		
			
CREATE TABLE "Daily_Calories_v3" AS

SELECT
	b.log_id,
	b.client_id,
	b.log_date,
	a.calories
FROM
	(SELECT
		log_id,
		client_id,
		log_datetime,
		CAST(total(calories) AS INTEGER) AS [calories]
	FROM
		Calorie_Hour_Log_v4
	GROUP BY
		log_id) AS a
LEFT JOIN
	 Daily_Calories_v2 AS b
ON
	a.log_id = b.log_id;

	
/*			
SELECT
	hour_id,
	log_id
	client_id,
	CAST(total(intensity_level_id) AS INTEGER) AS [intensity_total]
FROM
	Intensity_Minute_Log_v5
GROUP BY
	hour_id;
			{Result: 22093 rows returned}
			
SELECT
	*
FROM
	Intensity_Hour_Log_v3;
			{Result: 22099 rows returned}
			
SELECT
	*
FROM
	(SELECT
		hour_id,
		log_id
		client_id,
		CAST(total(intensity_level_id) AS INTEGER) AS [intensity_total]
	FROM
		Intensity_Minute_Log_v5
	GROUP BY
		hour_id) AS a
LEFT JOIN
	 Intensity_Hour_Log_v3 AS b
ON
	a.hour_id = b.hour_id
WHERE
	a.intensity_total <> b.intensity_total;
			{Result: 0 rows returned}
*/
			
			
CREATE TABLE "Intensity_Hour_Log_v4" AS

SELECT
	b.*
FROM
	(SELECT
		hour_id,
		log_id
		client_id,
		CAST(total(intensity_level_id) AS INTEGER) AS [intensity_total]
	FROM
		Intensity_Minute_Log_v5
	GROUP BY
		hour_id) AS a
LEFT JOIN
	 Intensity_Hour_Log_v3 AS b
ON
	a.hour_id = b.hour_id;
	
	
CREATE TABLE "Activity_Log_Check" AS

SELECT
	a.*,
	b.light_activity_minutes,
	c.moderate_activity_minutes,
	d.high_activity_minutes
FROM
	(SELECT
		log_id,
		client_id,
		count(minute_id) AS [sedentary_minutes]
	FROM
		Intensity_Minute_Log_v5
	WHERE
		intensity_level_id = 0
	GROUP BY
		log_id) AS a
LEFT JOIN
	(SELECT
		log_id,
		client_id,
		count(minute_id) AS [light_activity_minutes]
	FROM
		Intensity_Minute_Log_v5
	WHERE
		intensity_level_id = 1
	GROUP BY
		log_id) AS b
ON
	a.log_id = b.log_id
LEFT JOIN
	(SELECT
		log_id,
		client_id,
		count(minute_id) AS [moderate_activity_minutes]
	FROM
		Intensity_Minute_Log_v5
	WHERE
		intensity_level_id = 2
	GROUP BY
		log_id) AS c
ON
	a.log_id = c.log_id
LEFT JOIN
	(SELECT
		log_id,
		client_id,
		count(minute_id) AS [high_activity_minutes]
	FROM
		Intensity_Minute_Log_v5
	WHERE
		intensity_level_id = 3
	GROUP BY
		log_id) AS d
ON
	a.log_id = d.log_id;
	
	
UPDATE
	Activity_Log_Check
SET
	light_activity_minutes = 0
WHERE
	light_activity_minutes IS NULL;
	
	
UPDATE
	Activity_Log_Check
SET
	moderate_activity_minutes = 0
WHERE
	moderate_activity_minutes IS NULL;
	
	
UPDATE
	Activity_Log_Check
SET
	high_activity_minutes = 0
WHERE
	high_activity_minutes IS NULL;

			
/*			
SELECT
	*
FROM
	Activity_Log_v2;
			{Result: 940 rows returned}


SELECT
	*
FROM
	Activity_Log_Check;
			{Result: 934 rows returned}

		
SELECT
	*
FROM
	Activity_Log_Check AS a
LEFT JOIN
	 Activity_Log_v2 AS b
ON
	a.log_id = b.log_id
WHERE
	a.sedentary_minutes <> b.sedentary_minutes OR
	a.light_activity_minutes <> b.light_activity_minutes OR
	a.moderate_activity_minutes <> b.moderate_activity_minutes OR
	a.high_activity_minutes <> b.high_activity_minutes;
			{Result: 465 rows returned}
			
			
SELECT
	a.log_id,
	a.client_id,
	a.sedentary_minutes,
	b.sedentary_minutes,
	a.light_activity_minutes,
	b.light_activity_minutes,
	a.moderate_activity_minutes,
	b.moderate_activity_minutes,
	a.high_activity_minutes,
	b.high_activity_minutes
FROM
	Activity_Log_Check AS a
LEFT JOIN
	 Activity_Log_v2 AS b
ON
	a.log_id = b.log_id
WHERE
	a.sedentary_minutes <> b.sedentary_minutes;
			{Result: 465 rows returned}
*/

			
CREATE TABLE "Activity_Log_v3" AS

SELECT
	b.log_id,
	b.client_id,
	b.log_date,
	a.sedentary_minutes,
	a.light_activity_minutes,
	a.moderate_activity_minutes,
	a.high_activity_minutes,
	b.sedentary_km,
	b.light_activity_km,
	b.moderate_activity_km,
	b.high_activity_km
FROM
	Activity_Log_Check AS a
LEFT JOIN
	 Activity_Log_v2 AS b
ON
	a.log_id = b.log_id;
			

/*	
SELECT
	*
FROM
	Activity_Log_v3;
			{Result: 934 rows returned}

	
SELECT
	*
FROM
	Step_Hour_Log_v3;
			{Result: 22099 rows returned}
			
SELECT
	hour_id,
	client_id,
	total(steps) AS [steps]
FROM
	Step_Minute_Log_v5
GROUP BY
	hour_id;	
			{Result: 22093 rows returned}
			
			
SELECT
	*
FROM
	(SELECT
		hour_id,
		client_id,
		CAST(total(steps) AS INTEGER) AS [steps]
	FROM
		Step_Minute_Log_v5
	GROUP BY
		hour_id) AS a
LEFT JOIN
	Step_Hour_Log_v3 AS b
ON
	a.hour_id = b.hour_id
WHERE
	a.steps <> b.steps;
			{Result: 0 rows returned}
*/
			
			
CREATE TABLE "Step_Hour_Log_v4" AS

SELECT
	b.*
FROM
	(SELECT
		hour_id,
		client_id,
		CAST(total(steps) AS INTEGER) AS [steps]
	FROM
		Step_Minute_Log_v5
	GROUP BY
		hour_id) AS a
LEFT JOIN
	Step_Hour_Log_v3 AS b
ON
	a.hour_id = b.hour_id;


/*
SELECT
	*
FROM
	Step_Hour_Log_v4;
			{Result: 22093 rows returned}

			
SELECT
	*
FROM
	(SELECT
		log_id,
		client_id,
		CAST(total(steps) AS INTEGER) AS [steps]
	FROM
		Step_Hour_Log_v4
	GROUP BY
		log_id) AS a
LEFT JOIN
	Daily_Steps_v2 AS b
ON
	a.log_id = b.log_id
WHERE
	a.steps <> b.steps;
			{Result: 159 rows returned}
*/
			
			
CREATE TABLE "Daily_Steps_v3" AS

SELECT
	b.log_id,
	b.client_id,
	b.log_date,
	a.steps
FROM
	(SELECT
		log_id,
		client_id,
		CAST(total(steps) AS INTEGER) AS [steps]
	FROM
		Step_Hour_Log_v4
	GROUP BY
		log_id) AS a
LEFT JOIN
	Daily_Steps_v2 AS b
ON
	a.log_id = b.log_id;

		
/*
SELECT
	*
FROM
	Daily_Steps_v3;
			{Result: 934 rows returned}

						
SELECT
	*
FROM
	Daily_Log_v2;
			{Result: 940 rows returned}
			
SELECT
	*
FROM
	(SELECT
		log_id,
		client_id,
		log_date,
		ROUND(tracked_km, 2) AS [tracked_km]
	FROM
		Daily_Log_v2) AS a
LEFT JOIN
	(SELECT
		log_id,
		client_id,
		log_date,
		ROUND((high_activity_km + moderate_activity_km + light_activity_km + sedentary_km), 2) AS [tracked_km]
	FROM
		Daily_Log_v2)AS b
ON
	a.log_id = b.log_id
WHERE
	a.tracked_km <> b.tracked_km;
			{Result: 331 rows returned}
*/
			
			
CREATE TABLE "Daily_Log_v3" AS

SELECT
	log_id,
	client_id,
	log_date,
	logged_km,
	(high_activity_km + moderate_activity_km + light_activity_km + sedentary_km) AS [tracked_km],
	logged_workout_km,
	steps,
	calories
FROM
	Daily_Log_v2;

	
/*
SELECT
	*
FROM
	Activity_Log_v3 AS a
LEFT JOIN
	Daily_Log_v2 AS b
ON
	a.log_id = b.log_id
WHERE
	a.sedentary_km <> b.sedentary_km OR
	a.light_activity_km <> b.light_activity_km OR
	a.moderate_activity_km <> b.moderate_activity_km OR
	a.high_activity_km <> b.high_activity_km;
			{Result: 0 rows returned}
*/

	
CREATE TABLE "Daily_Log_v4" AS

SELECT
	a.*,
	b.logged_km,
	b.tracked_km,
	b.logged_workout_km,
	c.steps
FROM
	Daily_Calories_v3 AS a
LEFT JOIN
	Daily_Log_v3 AS b
ON
	a.log_id = b.log_id
LEFT JOIN
	Daily_Steps_v3 AS c
ON
	a.log_id = c.log_id;
	

/*
SELECT
	*
FROM
	Daily_Log_v4;
			{Result: 934 rows returned}
			
			
SELECT
	log_id,
	count(sleep_record_id) AS [total_sleep_records]
FROM
	(SELECT
		log_id,
		sleep_record_id
	FROM
		Sleep_Minute_Log_v6
	GROUP BY
		log_id,
		sleep_record_id)
GROUP BY
	log_id;
			{Result: 449 rows returned}
			
SELECT
	*
FROM
	Daily_Sleep_v2;
			{Result: 413 rows returned}
			
SELECT DISTINCT
	*
FROM
	Daily_Sleep_v2;
			{Result: 410 rows returned}
			
SELECT
	a.*,
	b.total_sleep_records
FROM
	(SELECT
		log_id,
		count(sleep_record_id) AS [total_sleep_records]
	FROM
		(SELECT
			*
		FROM
			Sleep_Minute_Log_v6
		GROUP BY
			log_id,
			sleep_record_id)
	GROUP BY
		log_id) AS a
LEFT JOIN
	(SELECT DISTINCT
		*
	FROM
		Daily_Sleep_v2) AS b
ON
	a.log_id = b.log_id
WHERE
	a.total_sleep_records <> b.total_sleep_records;
			{Result: 215 rows returned}
*/
			

CREATE TABLE "Daily_Sleep_v3" AS

SELECT
	log_id,
	client_id,
	substr(log_datetime, 1, 10) AS [log_date],
	count(sleep_record_id) AS [total_sleep_records]
FROM
	(SELECT
		*
	FROM
		Sleep_Minute_Log_v6
	GROUP BY
		log_id,
		sleep_record_id)
GROUP BY
	log_id;
	
	
/*
SELECT
	*
FROM
	Daily_Sleep_v3;
			{Result: 449 rows returned}
*/
				

CREATE TABLE "Daily_Sleep_v4" AS

SELECT
	a.*,
	b.minutes_asleep,
	c.time_in_bed
FROM
	Daily_Sleep_v3 AS a
LEFT JOIN
	(SELECT
		log_id,
		count(minute_id) AS [minutes_asleep]
	FROM
		Sleep_Minute_Log_v6
	WHERE
		sleep_state_id = 1
	GROUP BY
		log_id) AS b
ON
	a.log_id = b.log_id
LEFT JOIN
	(SELECT
		log_id,
		count(minute_id) AS [time_in_bed]
	FROM
		Sleep_Minute_Log_v6
	GROUP BY
		log_id) AS c
ON
	a.log_id = c.log_id;
	
	
/*
SELECT
	*
FROM
	Daily_Sleep_v4;
			{Result: 449 rows returned}
*/

	
UPDATE
	Daily_Sleep_v4
SET
	minutes_asleep = 0
WHERE
	minutes_asleep IS NULL;

	
CREATE TABLE "Sleep_Cycle_Record" AS

SELECT
	log_id,
	client_id,
	min(log_datetime) AS [sleep_cycle_start],
	max(log_datetime) AS [sleep_cycle_end],
	sleep_record_id
FROM
	Sleep_Minute_Log_v6
WHERE
	sleep_record_id IS NOT NULL
GROUP BY
	sleep_record_id
ORDER BY
	client_id,
	log_id;
	
	
CREATE TABLE "Sleep_Cycle_Record_v2" AS

SELECT
	*,
	substr(client_id, 1, 5) || substr(sleep_cycle_start, 1, 2) || substr(sleep_cycle_start, 4, 2) AS [log_id_new]
FROM
	Sleep_Cycle_Record;


/*
SELECT
	*
FROM
	Sleep_Cycle_Record_v2;
			{Result: 459 rows returned}


SELECT
	*
FROM
	Sleep_Minute_Log_v6 AS a
LEFT JOIN
	Sleep_Cycle_Record_v2 AS b
ON
	a.log_id = b.log_id AND
	a.sleep_record_id = b.sleep_record_id;
			{Result: 187978 rows returned}
*/
			
			
CREATE TABLE "Sleep_Minute_Log_v8" AS

SELECT
	a.*,
	b.log_id_new
FROM
	Sleep_Minute_Log_v7 AS a
LEFT JOIN
	Sleep_Cycle_Record_v2 AS b
ON
	a.log_id = b.log_id AND
	a.sleep_record_id = b.sleep_record_id;

	
UPDATE
	Sleep_Minute_Log_v8
SET
	log_id = log_id_new
WHERE
	log_id <> log_id_new;
	
	
CREATE TABLE "Sleep_Cycle_Record_v3" AS

SELECT
	log_id_new AS [log_id],
	client_id,
	sleep_cycle_start,
	sleep_cycle_end,
	sleep_record_id
FROM
	Sleep_Cycle_Record_v2;


UPDATE
	Sleep_Cycle_Record_v3
SET
	log_id = (log_id + 1)
WHERE
	sleep_cycle_start LIKE "% 0%:%";
	

CREATE TABLE "Sleep_Minute_Log_v9" AS

SELECT
	a.*,
	b.log_id AS [log_id_new]
FROM
	Sleep_Minute_Log_v8 AS a
LEFT JOIN
	Sleep_Cycle_Record_v3 AS b
ON
	a.sleep_record_id = b.sleep_record_id;

	
UPDATE
	Sleep_Minute_Log_v9
SET
	log_id = log_id_new
WHERE
	log_id <> log_id_new;


/*	
SELECT
	*
FROM
	Sleep_Minute_Log_v9
WHERE
	log_id <> log_id_new;
			{Result: 0 rows returned}
*/
	
	
CREATE TABLE "Sleep_Minute_Log_v10" AS

SELECT
	minute_id,
	hour_id,
	log_id AS [sleep_log_id],
	client_id,
	log_datetime,
	sleep_state_id,
	sleep_state,
	sleep_record_id
FROM
	Sleep_Minute_Log_v9;


CREATE TABLE "Daily_Sleep_v6" AS

SELECT
	sleep_log_id,
	client_id,
	log_date,
	count(sleep_record_id) AS [total_sleep_records]
FROM
	(SELECT
	sleep_log_id,
	client_id,
	substr(log_datetime, 1, 10) AS [log_date],
	sleep_record_id
FROM
	Sleep_Minute_Log_v10
GROUP BY
	sleep_log_id,
	sleep_record_id)
GROUP BY
	sleep_log_id;

	
CREATE TABLE "Daily_Sleep_v7" AS

SELECT
	a.*,
	b.minutes_asleep,
	c.time_in_bed
FROM
	Daily_Sleep_v6 AS a
LEFT JOIN
	(SELECT
	sleep_log_id,
	count(minute_id) AS [minutes_asleep]
FROM
	Sleep_Minute_Log_v10
WHERE
	sleep_state_id = 1
GROUP BY
	sleep_log_id) AS b
ON
	a.sleep_log_id = b.sleep_log_id
LEFT JOIN
	(SELECT
	sleep_log_id,
	count(minute_id) AS [time_in_bed]
FROM
	Sleep_Minute_Log_v10
GROUP BY
	sleep_log_id) AS c
ON
	a.sleep_log_id = c.sleep_log_id;
	
	
/*
SELECT
	*
FROM
	Daily_Sleep_v7;
			{Result: 389 rows returned}
*/

			
									/* DATA MANIPULATION AND ADDITIONS */
									
/*
	-add a sleep_state to clarify sleep_state_id
	add a intensity_level to the intensity_level_id for clarification
	-create the column for the calculation for the sleep_score
*/
	
CREATE TABLE "Sleep_Minute_Log_v7" AS

SELECT
	*,
	CASE
	WHEN sleep_state_id = 1
	THEN "asleep"
	WHEN sleep_state_id = 2
	THEN "restless"
	ELSE "awake"
	END AS [sleep_state]
FROM
	Sleep_Minute_Log_v6;
	
CREATE TABLE "Intensity_Minute_Log_v6" AS

SELECT
	*,
	CASE
	WHEN intensity_level_id = 0
	THEN "sedentary"
	WHEN intensity_level_id = 1
	THEN "light"
	WHEN intensity_level_id = 2
	THEN "moderate"
	ELSE "high"
	END AS [intensity_level]
FROM
	Intensity_Minute_Log_v5;

	
CREATE TABLE "Daily_Sleep_v8" AS

SELECT
	*,
	((minutes_asleep * 100) / time_in_bed) AS [sleep_score]
FROM
	Daily_Sleep_v7;

	
									/* CONSOLIDATION */
									
/*
	-joined daily, hourly, and minute table information
	-dropped duplicate information that was in the Daily_Log_v5 table and the Activity_Log_v3 table
	-cut out fromm the daily table the rows that do not have a sleep_record_id
*/

CREATE TABLE "Daily_Log_v5" AS
	
SELECT
	log_id,
	client_id,
	log_date,
	logged_km,
	tracked_km,
	logged_workout_km,
	calories,
	steps
FROM
	Daily_Log_v4;


CREATE TABLE "Daily_Log_v6" AS

SELECT
	a.*,
	b.total_sleep_records,
	b.minutes_asleep,
	b.time_in_bed,
	b.sleep_score
FROM
	Daily_Log_v5 AS a
LEFT JOIN
	Daily_Sleep_v8 AS b
ON
	a.log_id = b.sleep_log_id;
	

CREATE TABLE "Minute_Log" AS

SELECT
	a.*,
	b.intensity_level_id,
	b.intensity_level,
	c.steps,
	d.sleep_state_id,
	d.sleep_state,
	d.sleep_log_id,
	d.sleep_record_id
FROM
	Calorie_Minute_Log_v5 AS a
LEFT JOIN
	Intensity_Minute_Log_v6 AS b
ON
	a.minute_id = b.minute_id
LEFT JOIN
	Step_Minute_Log_v5 AS c
ON
	a.minute_id = c.minute_id
LEFT JOIN
	Sleep_Minute_Log_v10 AS d
ON
	a.minute_id = d.minute_id;
	

CREATE TABLE "Hourly_Log" AS

SELECT
	a.*,
	b.intensity_total,
	b.avg_intensity,
	c.steps
FROM
	Calorie_Hour_Log_v4 AS a
LEFT JOIN
	Intensity_Hour_Log_v4 AS b
ON
	a.hour_id = b.hour_id
LEFT JOIN
	Step_Hour_Log_v4 AS c
ON
	a.hour_id = c .hour_id;
	
/*
SELECT
	*
FROM
	Minute_Log;
			{Result: 1325580 rows returned}
			

SELECT
	*
FROM
	Hourly_Log;
			{Result: 22093 rows returned}


SELECT
	*
FROM
	Daily_Sleep_v8 AS a
LEFT JOIN
	Daily_Log_v6 AS b
ON
	a.log_id = b.log_id
WHERE
	b.log_id IS NULL;
			{Result: 18 rows returned}

			
SELECT
	*
FROM
	Sleep_Minute_Log_v10 AS a
LEFT JOIN
	Minute_Log AS b
ON
	a.minute_id = b.minute_id
WHERE
	b.minute_id IS NULL;
			{Result: 979 rows returned}
*/

		
CREATE TABLE "Daily_Log_v7" AS

SELECT
	*
FROM
	Daily_Log_v6
WHERE
	total_sleep_records IS NOT NULL;

/*
SELECT
	*
FROM
	Daily_Log_v7;
			{Result: 371 rows returned}
*/

			
CREATE TABLE "Activity_Log_v4" AS

SELECT
	b.*
FROM
	Daily_Log_v7 AS a
LEFT JOIN
	Activity_Log_v3 AS b
ON
	a.log_id = b.log_id;


/*
SELECT
	*
FROM
	Activity_Log_v4;
			{Result: 371 rows returned}
*/
	

											/* FINAL CHECK */

/*		
SELECT
	*
FROM
	Hourly_Log AS a
LEFT JOIN
	(SELECT
		hour_id,
		log_id,
		client_id,
		ROUND(total(calories)) AS [calories],
		total(intensity_level_id) AS [intensity_total],
		total(steps) AS [steps]
	FROM
		Minute_Log
	GROUP BY
		hour_id) AS b
ON
	a.hour_id = b.hour_id
WHERE
	a.calories <> b.calories OR
	a.intensity_total <> b.intensity_total OR
	a.steps <> b.steps;
			{Result: 0 rows returned}	

			
SELECT
	*
FROM
	(SELECT
		log_id,
		calories,
		steps
	FROM
		Daily_Log_v7) AS a
LEFT JOIN
	(SELECT
		log_id,
		total(calories) AS [calories],
		total(steps) AS [steps]
	FROM
		Hourly_Log
	GROUP BY
		log_id) AS b
ON
	a.log_id = b.log_id
WHERE
	a.calories <> b.calories OR
	a.steps <> b.steps;
			{Result: 0 rows returned}


SELECT
	*
FROM
	(SELECT
	log_id,
	ROUND((sedentary_km + light_activity_km + moderate_activity_km + high_activity_km), 2) AS [tracked_km]
FROM
	Activity_Log_v4) AS a
LEFT JOIN
	(SELECT
	log_id,
	ROUND(tracked_km, 2) AS [tracked_km]
FROM
	Daily_Log_v7) AS b
ON
	a.log_id = b.log_id
WHERE
	a.tracked_km <> b.tracked_km;
			{Result: 0 rows returned}

			
SELECT
	*
FROM
	(SELECT
		log_id,
		total_sleep_records
	FROM
		Daily_Log_v7) AS a
LEFT JOIN
	(SELECT
		sleep_log_id,
		count(sleep_record_id) AS [total_sleep_records]
	FROM
		(SELECT
			*
		FROM
			Minute_Log
		WHERE
			sleep_record_id IS NOT NULL
		GROUP BY
			sleep_log_id,
			sleep_record_id)
	GROUP BY
		sleep_log_id) AS b
ON
	a.log_id = b.sleep_log_id
WHERE
	a.total_sleep_records <> b.total_sleep_records;		
			{Result: 0 rows returned}
			
SELECT
	*
FROM
	(SELECT
		log_id,
		sedentary_minutes,
		light_activity_minutes,
		moderate_activity_minutes,
		high_activity_minutes
	FROM
		Activity_Log_v4) AS a
LEFT JOIN
	(SELECT
		a.*,
		b.light_activity_minutes,
		c.moderate_activity_minutes,
		d.high_activity_minutes
	FROM
		(SELECT
			log_id,
			count(minute_id) AS [sedentary_minutes]
		FROM
			Minute_Log
		WHERE
			intensity_level_id = 0
		GROUP BY
			log_id) AS a
	LEFT JOIN
		(SELECT
			log_id,
			count(minute_id) AS [light_activity_minutes]
		FROM
			Minute_Log
		WHERE
			intensity_level_id = 1
		GROUP BY
			log_id) AS b
	ON
		a.log_id = b.log_id
	LEFT JOIN
		(SELECT
			log_id,
			count(minute_id) AS [moderate_activity_minutes]
		FROM
			Minute_Log
		WHERE
			intensity_level_id = 2
		GROUP BY
			log_id) AS c
	ON
		a.log_id = c.log_id
	LEFT JOIN
		(SELECT
			log_id,
			count(minute_id) AS [high_activity_minutes]
		FROM
			Minute_Log
		WHERE
			intensity_level_id = 3
		GROUP BY
			log_id) AS d
	ON	
		a.log_id = d.log_id) AS b
ON
	a.log_id = b.log_id
WHERE
	a.sedentary_minutes <> b.sedentary_minutes OR
	a.light_activity_minutes <> b.light_activity_minutes OR
	a.moderate_activity_minutes <> b.moderate_activity_minutes OR
	a.high_activity_minutes <> b.high_activity_minutes;
			{Result: 0 rows returned}
*/