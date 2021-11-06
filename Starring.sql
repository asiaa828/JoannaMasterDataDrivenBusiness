ALTER TABLE movies ADD lexemesStarring tsvector;
UPDATE movies SET lexemesStarring = to_tsvector(Starring);
UPDATE movies SET rank = ts_rank(lexemesStarring,plainto_tsquery( ( SELECT Starring FROM movies WHERE url='avengers' ) ));
CREATE TABLE recommendationsBasedOnStarringfield AS SELECT url, rank FROM movies WHERE rank > 0.05 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOnStarringfield) to '/home/pi/RSL/top50recommendationsstarring.csv'WITH csv;
