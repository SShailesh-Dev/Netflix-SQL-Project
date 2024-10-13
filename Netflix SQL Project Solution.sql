-- TABLE NETFLIX

DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix
(
show_id	VARCHAR(10),
type VARCHAR(10),
title VARCHAR(110),
director VARCHAR(210),
casts VARCHAR(1000),
country	VARCHAR(150),
date_added  VARCHAR(20),
release_year INT,
rating  VARCHAR(10),
duration  VARCHAR(15),
listed_in  VARCHAR(100),
description  VARCHAR(300)
);

SELECT * FROM netflix;

SELECT
	COUNT(*) AS total_content
FROM netflix;

-- 14 Bussiness Problems

-- 1. Count the number of Movies vs TV Shows

SELECT
	type,
	count(*)
FROM netflix
GROUP BY type;

-- 2. Find the most common rating for movies and TV shows

-- most frequent rating for movie
SELECT 'Movie' AS type, rating, COUNT(*) AS count
FROM netflix
WHERE type = 'Movie'
GROUP BY rating
ORDER BY count DESC
LIMIT 1;

-- Get most frequent rating for TV shows

SELECT 'TV Show' AS type, rating, COUNT(*) AS count
FROM netflix
WHERE type = 'TV Show'
GROUP BY rating
ORDER BY count DESC
LIMIT 1;

-- 3. List all movies released in a specific year (e.g., 2020)

SELECT * FROM netflix
WHERE type = 'Movie' AND release_year = 2020;

-- 4. Find the top 5 countries with the most content on Netflix

SELECT 
	UNNEST(STRING_TO_ARRAY(country, ', ')) AS new_country,
	COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 5. Identify the longest movie

SELECT * FROM netflix
WHERE 
	type = 'Movie'
	AND
	duration = (
				SELECT MAX(duration)
				FROM netflix
				);
-- 6. Find content added in the last 5 years

SELECT 
	*
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
	
-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT title, director
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons

SELECT * FROM netflix
WHERE 
	type = 'TV Show'
	AND
	SPLIT_PART(duration, ' ', 1)::NUMERIC > 5
	
-- 9. Count the number of content items in each genre

SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
	COUNT(show_id)	AS total_content
FROM netflix
GROUP BY 1
ORDER BY total_content DESC;

-- 10. What is the total number of content added in a specific country for each year?

SELECT 
	EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
	COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC;

-- 11. List all movies that are documentaries

SELECT * FROM netflix
WHERE listed_in ILIKE '%Documentaries%'

-- 12. Find all content without a director

SELECT * FROM netflix
WHERE director IS NULL

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT * FROM netflix
WHERE
	CASTS ILIKE '%Salman Khan%'
	AND
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India

SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ', ')) AS actor,
    COUNT(*) AS total_movies
FROM netflix
WHERE country = 'India' AND type = 'Movie'
GROUP BY actor
ORDER BY total_movies DESC
LIMIT 10;

