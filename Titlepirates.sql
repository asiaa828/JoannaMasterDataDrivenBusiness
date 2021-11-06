ALTER TABLE movies ADD COLUMN IF NOT EXISTS lexemestitle tsvector;
ALTER TABLE movies ADD COLUMN IF NOT EXISTS rank float4;
UPDATE movies SET lexemestitle = to_tsvector(title);
UPDATE movies SET rank = ts_rank(lexemestitle,plainto_tsquery( ( SELECT title FROM movies WHERE url='pirates-of-the-caribbean-the-curse-of-the-black-pearl' ) ));
DROP TABLE IF EXISTS recommendationsBasedOntitlefield; 
CREATE TABLE recommendationsBasedOntitlefield AS SELECT url, rank FROM movies WHERE rank > 0.05 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOntitlefield) to '/home/pi/RSL/top50recommendationtitlepirates.csv'WITH csv;
