SELECT *
FROM distributors

SELECT *
FROM rating

SELECT *
FROM revenue

SELECT *
FROM specs

--Question 1: Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT s.film_title, s.release_year, r.worldwide_gross
FROM specs AS s
LEFT JOIN revenue AS r
	USING (movie_id)
ORDER BY r.worldwide_gross

--Answer: Semi-Tough, released 1977 with a worldwide gross of $37,187,139.

--Question 2: What year has the highest average imdb rating?

SELECT AVG(r.imdb_rating), s.release_year
FROM rating AS r
LEFT JOIN specs AS s
	ON r.movie_id=s.movie_id
GROUP BY s.release_year
ORDER BY AVG(r.imdb_rating) DESC

--Answer: 1991 had the highest avg IMDB rating of 7.45.

--Question 3: What is the highest grossing G-rated movie? Which company distributed it?

SELECT s.film_title AS movie_name
	,	d.company_name
	,	r.worldwide_gross
	FROM specs AS s
RIGHT JOIN revenue AS r
	ON s.movie_id=r.movie_id
RIGHT JOIN distributors AS d
	ON s.domestic_distributor_id=d.distributor_ID
WHERE s.mpaa_rating='G'
ORDER BY r.worldwide_gross DESC

--Answer: Toy Story 4 is the highest grossing G-rated movie, and it was distributed by Walt Disney.

--Question 4: Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.


--Answer:
SELECT d.company_name, COUNT(s.film_title)
FROM distributors AS d
LEFT JOIN specs AS s
	ON d.distributor_ID=s.domestic_distributor_id
GROUP BY d.company_name
ORDER BY COUNT(s.film_title) DESC

--Question 5: Write a query that returns the five distributors with the highest average movie budget.

SELECT d.company_name, ROUND(AVG(r.film_budget), 2)::MONEY AS avg_movie_budget
FROM distributors AS d
FULL JOIN specs AS s 
	ON d.distributor_id=s.domestic_distributor_id
RIGHT JOIN revenue AS r
	USING (movie_ID)
GROUP BY d.company_name
ORDER BY AVG(r.film_budget) DESC
LIMIT 5;

/* Answer: 
Walt Disney = 148735526.32
Sony Pictures = 139129032.26
Lionsgate = 122600000.00000000
DreamWorks = 121352941.18
Warner Bros. = 103430985.92
*/

--Question 6: How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT s.film_title, d.headquarters, r.imdb_rating
FROM distributors AS d
LEFT JOIN specs AS s
	ON d.distributor_ID=s.domestic_distributor_id
RIGHT JOIN rating AS r
	USING (movie_id)
WHERE d.headquarters NOT LIKE '%CA'
ORDER BY r.imdb_rating DESC

--Answer: There are two movies that were distributed by a company which is not HQed in CA. Of these two movies, Dirty Dancing has a higher IMDB rating of 7.0

--Question 7: Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT 
CASE
	WHEN s.length_in_min >120 THEN 'Over 2 hours'
	ELSE 'Under 2 Hours'
	END AS length_range
	, AVG(r.imdb_rating) AS avg_imdb_rating
FROM specs as s
LEFT JOIN rating as r
	USING (movie_id)
GROUP BY length_range
ORDER BY avg_imdb_rating DESC

--Answer: Based on average rating, movies over 2 hours are rated higher.