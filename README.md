# Netflix Content Analysis Project

![Netflix Logo](https://github.com/SShailesh-Dev/Netflix-SQL-Project/blob/main/Netflix-SQL-Project.png)

## Overview

This project involves analyzing a dataset containing information about Netflix content. The analysis focuses on various business problems related to movies and TV shows, such as content distribution, ratings, and director-specific queries. The data is stored in a SQL table named `netflix`, which includes details like show ID, type, title, director, cast, country, date added, release year, rating, duration, genre, and description.

## Objectives

The main objectives of this project are:

1. **Understand Content Distribution**: Analyze the number of movies and TV shows available on Netflix and their distribution across different genres and countries.
2. **Rating Analysis**: Identify the most common ratings for movies and TV shows to understand viewer preferences.
3. **Content Trends**: Explore trends in content added to Netflix over the past few years and identify any patterns in releases.
4. **Director and Actor Insights**: Investigate the contributions of specific directors and actors to Netflix's library and how they influence viewer engagement.
5. **Identify Documentaries**: Highlight documentary content available on Netflix for audiences interested in educational and informative programming.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Table Structure

The `netflix` table is defined as follows:

```sql
DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix
(
    show_id VARCHAR(10),
    type VARCHAR(10),
    title VARCHAR(110),
    director VARCHAR(210),
    casts VARCHAR(1000),
    country VARCHAR(150),
    date_added VARCHAR(20),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(15),
    listed_in VARCHAR(100),
    description VARCHAR(300)
);
```
## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
SELECT
	type,
	count(*)
FROM netflix
GROUP BY type;
```

**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

#### most frequent rating for movie

```sql
SELECT 'Movie' AS type, rating, COUNT(*) AS count
FROM netflix
WHERE type = 'Movie'
GROUP BY rating
ORDER BY count DESC
LIMIT 1;
```

#### Get most frequent rating for TV shows

```sql
SELECT 'TV Show' AS type, rating, COUNT(*) AS count
FROM netflix
WHERE type = 'TV Show'
GROUP BY rating
ORDER BY count DESC
LIMIT 1;
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```sql
SELECT * FROM netflix
WHERE type = 'Movie' AND release_year = 2020;
```

**Objective:** Retrieve all movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```sql
SELECT 
	UNNEST(STRING_TO_ARRAY(country, ', ')) AS new_country,
	COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the Longest Movie

```sql
SELECT * FROM netflix
WHERE 
	type = 'Movie'
	AND
	duration = (
				SELECT MAX(duration)
				FROM netflix
				);
```

**Objective:** Find the movie with the longest duration.

### 6. Find Content Added in the Last 5 Years

```sql
SELECT 
	*
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```sql
SELECT title, director
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```sql
SELECT * FROM netflix
WHERE 
	type = 'TV Show'
	AND
	SPLIT_PART(duration, ' ', 1)::NUMERIC > 5
```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
	COUNT(show_id)	AS total_content
FROM netflix
GROUP BY 1
ORDER BY total_content DESC;
```

**Objective:** Count the number of content items in each genre.

### 10.What is the total number of content added in a specific country for each year

```sql
SELECT 
	EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
	COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC;
```

**Objective:** Calculate and rank years by the number of content releases by India.

### 11. List All Movies that are Documentaries

```sql
SELECT * FROM netflix
WHERE listed_in ILIKE '%Documentaries%';
```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Find All Content Without a Director

```sql
SELECT * FROM netflix
WHERE director IS NULL;
```

**Objective:** List content that does not have a director.

### 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

```sql
SELECT * FROM netflix
WHERE
	CASTS ILIKE '%Salman Khan%'
	AND
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.

### 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

```sql
SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ', ')) AS actor,
    COUNT(*) AS total_movies
FROM netflix
WHERE country = 'India' AND type = 'Movie'
GROUP BY actor
ORDER BY total_movies DESC
LIMIT 10;
```

**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.

## Findings

1. **Content Distribution**: The analysis reveals the ratio of movies to TV shows available on Netflix, indicating the platform's content strategy. For example, if there are significantly more movies than TV shows (or vice versa), it may reflect audience preferences or production capabilities.

2. **Most Common Ratings**: The findings show the most frequent ratings assigned to movies and TV shows. Understanding which ratings are most common can help inform content creators and marketers about what resonates with viewers.

3. **Trends in New Content**: The data on content added over the last five years highlights trends in Netflix's acquisition and production strategies. This analysis may show spikes in content releases during certain years, potentially correlating with significant events or changes in strategy.

4. **Director and Actor Insights**: By identifying key directors and actors, we can understand who contributes most to Netflix's library, which can help in marketing and viewer engagement strategies. For example, knowing the most prolific actors in movies produced in India can guide promotional efforts.

5. **Documentary Availability**: The identification of documentaries on the platform provides insights into the types of content that cater to educational and informational interests, which may attract a specific viewer demographic.

## Conclusion

The analysis of the Netflix dataset provides valuable insights into content distribution, viewer preferences, and trends in the streaming service. The findings can guide Netflix's content strategy by:

- Enhancing the understanding of viewer preferences regarding ratings and genres.
- Identifying key contributors to the content library, which can inform future partnerships and acquisitions.
- Tracking trends over the years, helping to predict future content strategies.

Overall, this project underscores the importance of data analysis in the entertainment industry, particularly for streaming platforms like Netflix, which rely on content diversity and viewer engagement to maintain their competitive edge.

## Author - Shailesh Kumar

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/sshailesh_dev)
