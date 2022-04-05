										/* DATA MANIPULATION */
										
/*
	-updated the log_id and client_id with text characters for the Sleep_State_Log, Intensity_Level_Log, 
Daily_Log_v7 and Minute_Log so that when the tables are exported as a cvs the text datatype is not lost
	-dropping rows from the hourly and minute tables that do not have matching a matching log_id in the 
daily tables
	-updating the Minute_Log_v3 intensity_level_id and intensity_level to be match the number of steps 
per minute
	-created a table with long intensity_level data and sleep_state data
*/

	
CREATE TABLE "Sleep_State_Asleep" AS

SELECT
	sleep_log_id,
	client_id,
	sleep_state_id,
	sleep_state,
	count(minute_id) AS [minutes]
FROM
	Minute_Log
WHERE
	sleep_record_id IS NOT NULL AND
	sleep_state_id = 1
GROUP BY
	log_id,
	sleep_state_id;
	
	
CREATE TABLE "Sleep_State_Restless" AS

SELECT
	sleep_log_id,
	client_id,
	sleep_state_id,
	sleep_state,
	count(minute_id) AS [minutes]
FROM
	Minute_Log
WHERE
	sleep_record_id IS NOT NULL AND
	sleep_state_id = 2
GROUP BY
	log_id,
	sleep_state_id;
	
	
CREATE TABLE "Sleep_State_Awake" AS

SELECT
	sleep_log_id,
	client_id,
	sleep_state_id,
	sleep_state,
	count(minute_id) AS [minutes]
FROM
	Minute_Log
WHERE
	sleep_record_id IS NOT NULL AND
	sleep_state_id = 3
GROUP BY
	log_id,
	sleep_state_id;
	
	
CREATE TABLE "Sleep_State_Log" AS

SELECT
	*
FROM
	Sleep_State_Asleep
UNION
	
SELECT
	*
FROM
	Sleep_State_Restless
UNION
	
SELECT
	*
FROM
	Sleep_State_Awake;
	
	
CREATE TABLE "Sleep_State_Log_v2" AS

SELECT
	"ID" || a.sleep_log_id AS [log_id],
	"CID" || a.client_id AS [client_id],
	b.log_date,
	a.sleep_state_id,
	a.sleep_state,
	a.minutes
FROM
	Sleep_State_Log AS a
LEFT JOIN
	Daily_Log_v7 AS b
ON
	a.sleep_log_id = b.log_id;
	
	
CREATE TABLE "Sleep_State_Log_v3" AS

SELECT
	b.*
FROM
	Daily_Log_v8 AS a
LEFT JOIN
	Sleep_State_Log_v2 AS b
ON
	a.log_id = b.log_id;
	
	
CREATE TABLE "Activity_Log_v5" AS

SELECT
	"ID" || log_id AS [log_id],
	"CID" || client_id AS [client_id],
	log_date,
	sedentary_minutes,
	light_activity_minutes,
	moderate_activity_minutes,
	high_activity_minutes,
	sedentary_km,
	light_activity_km,
	moderate_activity_km,
	high_activity_km
FROM
	Activity_Log_v4;
	
	
CREATE TABLE "Daily_Log_v8" AS

SELECT
	"ID" || log_id AS [log_id],
	"CID" || client_id AS [client_id],
	log_date,
	tracked_km,
	logged_workout_km,
	steps,
	calories,
	total_sleep_records,
	minutes_asleep,
	time_in_bed,
	sleep_score
FROM
	Daily_Log_v7;
	
	
CREATE TABLE "Hourly_Log_v3" AS

SELECT
	a.*
FROM
	Hourly_Log_v2 AS a
LEFT JOIN
	Daily_Log_v8 AS b
ON
	a.log_id = b.log_id
WHERE
	b.log_id IS NOT NULL;
	
	
CREATE TABLE "Minute_Log_v2" AS

SELECT
	"ID" || minute_id AS [minute_id],
	"ID" || hour_id AS [hour_id],
	"ID" || log_id AS [log_id],
	"CID" || client_id AS [client_id],
	log_datetime,
	calories,
	intensity_level_id,
	intensity_level,
	steps
FROM
	Minute_Log;
	
	
CREATE TABLE "Minute_Log_v3" AS

SELECT
	b.*
FROM
	Daily_Log_v8 AS a
LEFT JOIN
	Minute_Log_v2 AS b
ON
	a.log_id = b.log_id;

	
CREATE TABLE "Sleep_Minute_Log" AS

SELECT
	"ID" || minute_id AS [minute_id],
	"ID" || hour_id AS [hour_id],
	"ID" || sleep_log_id AS [log_id],
	"CID" || client_id AS [client_id],
	log_datetime,
	sleep_state_id,
	sleep_state,
	sleep_record_id
FROM
	Minute_Log
WHERE
	sleep_record_id IS NOT NULL;
	
	
CREATE TABLE "Sleep_Minute_Log_v2" AS

SELECT
	b.*
FROM
	Daily_Log_v8 AS a
LEFT JOIN
	Sleep_Minute_Log AS b
ON
	a.log_id = b.log_id;

	
/*
SELECT
	intensity_level,
	min(steps),
	max(steps),
	avg(steps)
FROM
	(SELECT
	hour_id,
	client_id,
	intensity_level_id,
	intensity_level,
	CAST(total(steps) AS INTEGER) AS [steps]
FROM
	Minute_Log_v3
GROUP BY
	minute_id,
	intensity_level_id)
GROUP BY
	intensity_level;

intensity_level		min		max		average
high				0		190		77.8672017121455
light				0		180		25.0262951586577
moderate			0		119		59.2562406015038
sedentary			0		65		0.000305408928880745
*/


UPDATE
	Minute_Log_v3
SET
	intensity_level_id = 0,
	intensity_level = "sedentary"
WHERE
	steps BETWEEN 0 AND 65;
	
	
UPDATE
	Minute_Log_v3
SET
	intensity_level_id = 1,
	intensity_level = "light"
WHERE
	steps BETWEEN 66 AND 100;
	
	
UPDATE
	Minute_Log_v3
SET
	intensity_level_id = 2,
	intensity_level = "moderate"
WHERE
	steps BETWEEN 101 AND 120;
	
	
UPDATE
	Minute_Log_v3
SET
	intensity_level_id = 3,
	intensity_level = "high"
WHERE
	steps > 120;
	
	
/*
intensity_level		min		max		average
sedentary			0		65		3.29038719836969
light				66		100		80.9518952127043
moderate			101		120		108.458809801634
high				121		190		137.284153005464
*/


CREATE TABLE "Intensity_Level_Sedentary" AS


SELECT
	log_id,
	client_id,
	log_datetime,
	intensity_level_id,
	intensity_level,
	count(minute_id) AS [minutes]
FROM
	Minute_Log_v3
WHERE
	intensity_level_id = 0
GROUP BY
	log_id,
	intensity_level_id;
	
	
CREATE TABLE "Intensity_Level_Light" AS


SELECT
	log_id,
	client_id,
	log_datetime,
	intensity_level_id,
	intensity_level,
	count(minute_id) AS [minutes]
FROM
	Minute_Log_v3
WHERE
	intensity_level_id = 1
GROUP BY
	log_id,
	intensity_level_id;
	
	
CREATE TABLE "Intensity_Level_Moderate" AS


SELECT
	log_id,
	client_id,
	log_datetime,
	intensity_level_id,
	intensity_level,
	count(minute_id) AS [minutes]
FROM
	Minute_Log_v3
WHERE
	intensity_level_id = 2
GROUP BY
	log_id,
	intensity_level_id;
	
	
CREATE TABLE "Intensity_Level_High" AS

SELECT
	log_id,
	client_id,
	log_datetime,
	intensity_level_id,
	intensity_level,
	count(minute_id) AS [minutes]
FROM
	Minute_Log_v3
WHERE
	intensity_level_id = 3
GROUP BY
	log_id,
	intensity_level_id;
	

CREATE TABLE "Intensity_Level_Log" AS 

SELECT
	*
FROM
	Intensity_Level_Sedentary
UNION
	
SELECT
	*
FROM
	Intensity_Level_Light
UNION
	
SELECT
	*
FROM
	Intensity_Level_Moderate
UNION
	
SELECT
	*
FROM
	Intensity_Level_High;

	
CREATE TABLE "Hourly_Log_v4" AS

SELECT
	b.hour_id,
	b.log_id,
	b.client_id,
	b.log_datetime,
	a.calories,
	a.intensity_total,
	a.steps
FROM
	(SELECT
	hour_id,
	log_id,
	client_id,
	CAST(ROUND(total(calories)) AS INTEGER) AS [calories],
	CAST(total(intensity_level_id) AS INTEGER) AS [intensity_total],
	CAST(total(steps) AS INTEGER) AS [steps]
FROM
	Minute_Log_v3
GROUP BY
	hour_id) AS a
LEFT JOIN
	Hourly_Log_v3 AS b
ON
	a.hour_id = b.hour_id;
	
	
CREATE TABLE "Hourly_Log_v5" AS

SELECT
	hour_id,
	log_id,
	client_id,
	log_datetime,
	calories,
	intensity_total,
	ROUND(CAST((CAST(intensity_total AS REAL) / 60) AS REAL), 6) AS [avg_intensity],
	steps
FROM
	Hourly_Log_v4;