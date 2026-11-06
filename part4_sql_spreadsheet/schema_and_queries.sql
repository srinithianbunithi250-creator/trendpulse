-- ====================================================================
-- Part 4: SQL Database Schema and Comprehensive Query Suite
-- Database: trendpulse_db
-- ====================================================================

DROP DATABASE IF EXISTS trendpulse_db;
CREATE DATABASE trendpulse_db;
USE trendpulse_db;

-- 1. Table: categories (Parent Table)
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- 2. Table: videos (Child of categories, Parent of trending_records)
CREATE TABLE videos (
    video_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    channel_title VARCHAR(255) NOT NULL,
    category_id INT NOT NULL,
    publish_time DATETIME NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

-- 3. Table: trending_records (Child of videos)
CREATE TABLE trending_records (
    record_id INT PRIMARY KEY,
    video_id VARCHAR(50) NOT NULL,
    country VARCHAR(10) NOT NULL,
    trending_date DATE NOT NULL,
    views BIGINT NOT NULL DEFAULT 0,
    likes BIGINT NOT NULL DEFAULT 0,
    dislikes BIGINT NOT NULL DEFAULT 0,
    comment_count BIGINT NOT NULL DEFAULT 0,
    FOREIGN KEY (video_id) REFERENCES videos(video_id) ON DELETE CASCADE
);

-- Data Loading Examples (MySQL LOAD DATA)
-- LOAD DATA LOCAL INFILE 'data/categories.csv' INTO TABLE categories FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
-- LOAD DATA LOCAL INFILE 'data/videos.csv' INTO TABLE videos FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
-- LOAD DATA LOCAL INFILE 'data/trending_records.csv' INTO TABLE trending_records FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Verification Row Counts:
-- SELECT COUNT(*) AS categories_count FROM categories;
-- SELECT COUNT(*) AS videos_count FROM videos;
-- SELECT COUNT(*) AS trending_records_count FROM trending_records;

-- ====================================================================
-- QUERY SUITE (8+ Queries covering required clauses & joins)
-- ====================================================================

-- Query 1: Top 10 most-viewed trending records in US (SELECT, WHERE, ORDER BY, LIMIT, ALIASES)
SELECT 
    record_id AS id, 
    video_id, 
    views AS total_views, 
    likes AS total_likes, 
    trending_date AS date_captured
FROM trending_records
WHERE country = 'US'
ORDER BY views DESC
LIMIT 10;

-- Query 2: Distinct active country markets (DISTINCT)
SELECT DISTINCT 
    country AS active_market 
FROM trending_records 
ORDER BY active_market ASC;

-- Query 3: High engagement categories having average views > 1,500,000 (GROUP BY, HAVING)
SELECT 
    c.category_name, 
    ROUND(AVG(tr.views), 0) AS avg_views, 
    COUNT(tr.record_id) AS total_records
FROM trending_records tr
JOIN videos v ON tr.video_id = v.video_id
JOIN categories c ON v.category_id = c.category_id
GROUP BY c.category_name
HAVING avg_views > 1500000
ORDER BY avg_views DESC;

-- Query 4: Channels with at least 20 distinct trending videos (GROUP BY, HAVING, COUNT DISTINCT)
SELECT 
    channel_title, 
    COUNT(DISTINCT video_id) AS distinct_videos_count
FROM videos
GROUP BY channel_title
HAVING distinct_videos_count >= 20
ORDER BY distinct_videos_count DESC
LIMIT 15;

-- Query 5: INNER JOIN across all 3 tables with top view records
-- Justification: INNER JOIN returns records where category, video, and snapshot metrics are all present.
SELECT 
    tr.record_id, 
    v.title, 
    v.channel_title, 
    c.category_name, 
    tr.country, 
    tr.views, 
    tr.likes
FROM trending_records tr
INNER JOIN videos v ON tr.video_id = v.video_id
INNER JOIN categories c ON v.category_id = c.category_id
ORDER BY tr.views DESC
LIMIT 10;

-- Query 6: LEFT JOIN to detect categories with mapped video counts
-- Justification: LEFT JOIN preserves all defined categories even if zero videos exist for that category.
SELECT 
    c.category_id, 
    c.category_name, 
    COUNT(v.video_id) AS mapped_videos
FROM categories c
LEFT JOIN videos v ON c.category_id = v.category_id
GROUP BY c.category_id, c.category_name
ORDER BY mapped_videos ASC;

-- Query 7: RIGHT JOIN between trending records and videos
-- Justification: RIGHT JOIN preserves all catalogued videos regardless of snapshot activity in a specific window.
SELECT 
    v.video_id, 
    v.title, 
    v.channel_title, 
    COUNT(tr.record_id) AS total_snapshots
FROM trending_records tr
RIGHT JOIN videos v ON tr.video_id = v.video_id
GROUP BY v.video_id, v.title, v.channel_title
ORDER BY total_snapshots DESC
LIMIT 10;

-- Query 8: Multi-country summary grouping
SELECT 
    tr.country, 
    COUNT(tr.record_id) AS total_records, 
    COUNT(DISTINCT tr.video_id) AS unique_videos, 
    ROUND(AVG(tr.views), 0) AS avg_views, 
    ROUND(AVG(tr.likes), 0) AS avg_likes
FROM trending_records tr
GROUP BY tr.country
ORDER BY total_records DESC;
