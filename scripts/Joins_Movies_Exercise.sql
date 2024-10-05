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

SELECT d.company_name, r.worldwide_gross, s.mpaa_rating
FROM distributors AS d
FULL JOIN revenue AS r
FULL JOIN 