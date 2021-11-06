ALTER TABLE movies ADD COLUMN IF NOT EXISTS lexemeStarring tsvector;
ALTER TABLE movies ADD COLUMN IF NOT EXISTS rank float4;
UPDATE movies SET lexemesStarring = to_tsvector(Starring);
UPDATE movies SET rank = ts_rank(lexemesStarring,plainto_tsquery( ( SELECT Starring FROM movies WHERE url='avengers' ) ));
DROP TABLE IF EXISTS recommendationsBasedOnStarringfield; 
CREATE TABLE recommendationsBasedOnStarringfield AS SELECT url, rank FROM movies WHERE rank > 0.05 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOnStarringfield) to '/home/pi/RSL/top50recommendationsstarring.csv'WITH csv;
