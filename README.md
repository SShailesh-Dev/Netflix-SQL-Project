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
