ALTER TABLE movies ADD COLUMN IF NOT EXISTS lexemeSummary tsvector;
ALTER TABLE movies ADD COLUMN IF NOT EXISTS rank float4;
UPDATE movies SET lexemesSummary = to_tsvector(Summary);
UPDATE movies SET rank = ts_rank(lexemesSummary,plainto_tsquery( ( SELECT Summary FROM movies WHERE url='pirates-of-the-caribbean-the-curse-of-the-black-pearl' ) ));
DROP TABLE IF EXISTS recommendationsBasedOnSummaryfield; 
CREATE TABLE recommendationsBasedOnSummaryfield AS SELECT url, rank FROM movies WHERE rank > 0.05 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOnSummaryfield) to '/home/pi/RSL/top50recommendationssummarypirates.csv'WITH csv;
