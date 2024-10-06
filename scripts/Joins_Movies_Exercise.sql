SELECT *
FROM distributors

SELECT *
FROM rating

SELECT *
FROM revenue

SELECT *
FROM specs

--Question 1: Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT s.film_title, s.release_year, s.movie_id, r.worldwide_gross
FROM specs AS s
RIGHT JOIN revenue AS r
	USING (movie_id)
ORDER BY r.worldwide_gross

--Answer: Semi-Tough, released 1977 with a worldwide gross of $37,187,139.

--Question 2: What year has the highest average imdb rating?

SELECT r.imdb_rating, s.release_year
FROM rating AS r
LEFT JOIN specs AS s
	ON r.movie_id=s.movie_id
ORDER BY r.imdb_rating DESC

--Answer: 2008 had the highest IMDB rating of 9.0.

--Question 3: What is the highest grossing G-rated movie? Which company distributed it?

SELECT s.film_title AS movie_name, d.company_name, r.worldwide_gross, s.mpaa_rating
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

SELECT d.company_name, AVG(r.film_budget)
FROM distributors AS d
FULL JOIN specs AS s 
	ON d.distributor_id=s.domestic_distributor_id
RIGHT JOIN revenue AS r
	USING (movie_ID)
GROUP BY d.company_name
ORDER BY AVG(r.film_budget) DESC
LIMIT 5;

/* Answer: 
Walt Disney = 148735526.31578947
Sony Pictures = 139129032.25806452
Lionsgate = 122600000.00000000
DreamWorks = 121352941.17647059
Warner Bros. = 103430985.91549296
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

SELECT s.length_in_min, AVG(r.imdb_rating) AS avg_imdb_rating
FROM specs as s
FULL JOIN rating as r
	USING (movie_id)
GROUP BY s.length_in_min
ORDER BY avg_imdb_rating DESC

--Answer: Out of the top 25 IMDB ratings, 22 were over 2 hours in length.