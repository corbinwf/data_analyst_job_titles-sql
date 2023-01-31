SELECT * FROM data_analyst_jobs;

/*
1. How many rows are in the data_analyst_jobs table?
*/

SELECT
	COUNT(*)
FROM data_analyst_jobs;

-- Output: 1793 **COUNT(*) count including null

/* Note
SELECT
	COUNT(company)
FROM data_analyst_jobs;

Output: 1787 **COUNT(column) count excluding null
*/


/*
2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
*/

SELECT
	*
FROM data_analyst_jobs
LIMIT 10;

-- A: ExxonMobil


/*
3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
*/

SELECT
	COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN';

-- 21


/*
4. How many postings in Tennessee have a star rating above 4?
*/

SELECT
	COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating >= 4;

-- A: 4


/*
5.	How many postings in the dataset have a review count between 500 and 1000?
*/

SELECT
	COUNT(title)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

-- A: 151


/*
6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?
*/

SELECT
	company,
	location AS state,
	AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE COMPANY IS NOT NULL
GROUP BY company, location;


/*
7.	Select unique job titles from the data_analyst_jobs table. How many are there?
*/

SELECT
	DISTINCT(title)
FROM data_analyst_jobs;

-- A: list

SELECT
	COUNT(DISTINCT(title))
FROM data_analyst_jobs;

-- A: 881


/*
8.	How many unique job titles are there for California companies?
*/

SELECT
	COUNT(title)
FROM data_analyst_jobs
WHERE location = 'CA';

-- A: 376


/*
9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
*/

SELECT
	company,
	AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company;

/* Not sure what is this question asking for
SELECT
	company,
	location,
	AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company, location
*/


/*
10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
*/

SELECT
	company,
	AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY AVG(star_rating) DESC;

-- A: "General Motors"

-- A: 4.1999998090000000


/*
11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 
*/

SELECT
	COUNT(DISTINCT(title))
FROM data_analyst_jobs
WHERE LOWER(title) LIKE LOWER('%Analyst%');

-- A: 774


/*
12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
*/

/* Note
SELECT
	DISTINCT(title)
FROM data_analyst_jobs
WHERE title NOT IN (
	'%Analyst%',
	'%Analytics%'
	)

	***NOT WORKING! because
	***IN >> A OR B condition
	***NOT IN >> A AND B condition
*/

SELECT
	COUNT(DISTINCT(title))
FROM data_analyst_jobs
WHERE LOWER(title) NOT LIKE LOWER('%Analyst%')
	AND LOWER(title) NOT LIKE LOWER('%Analytics%');
	
-- A: 4

/* Note
	Use LOWER() to ignore capital/lower case
	LOWER(column) = Lower('%KeYwOrD')
*/


/*
	BONUS
You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
Disregard any postings where the domain is NULL. 
Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?
*/

SELECT
	domain,
	COUNT(title) AS hard_to_fill
FROM data_analyst_jobs
WHERE days_since_posting > 3*7
	AND LOWER(SKILL) LIKE LOWER('%SQL')
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY COUNT(title) DESC
LIMIT 4;

/*
 A:
	"Consulting and Business Services"
	"Internet and Software"
	"Health Care"
	"Banks and Financial Services"

 A: 78
*/