-- ANSWER 6
-- 각 저자의 년도yyyy별 해당 시점에서의 h5-index 구하기
SELECT author_id, year, h5index
FROM(
	SELECT author_id, year, COUNT(*) AS h5index,
	row_number() OVER (PARTITION BY author_id, year ORDER BY COUNT(*) DESC) AS ran
	FROM(
		SELECT a.author_id, a.paper_id, a.published_at AS publish_1,
		    strftime('%Y-%m-%d', DATETIME(a.published_at,'-5 year')) AS diff,
		    b.paper_id AS within5,
		    b.published_at AS publish_2,
		    CAST(strftime('%Y', a.published_at) AS INTEGER) AS year,
		    COUNT(DISTINCT c.paper_id) AS citation_count,
		    row_number() OVER (PARTITION BY a.author_id, a.paper_id ORDER BY COUNT(DISTINCT c.paper_id) DESC) AS ranking
		FROM paper_author a
		CROSS JOIN paper_author b
		ON a.author_id=b.author_id
		LEFT JOIN paper_reference c
		ON b.paper_id = c.reference_paper_id
		WHERE publish_2 BETWEEN diff AND publish_1
		GROUP BY a.author_id, a.paper_id, within5
        )
    WHERE ranking <= citation_count
    GROUP BY author_id, paper_id, year
    )
WHERE ran=1