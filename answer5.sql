-- ANSWER 5
-- 각 저자의 h5-index 구하기
SELECT author_id, COUNT(*) as h5index
FROM(
    SELECT author_id, a.paper_id,
        COUNT(b.paper_id) AS citation_count,
        row_number() OVER (PARTITION BY author_id ORDER BY COUNT(b.paper_id) DESC) AS ranking
    FROM paper_author a
    LEFT JOIN paper_reference b
    ON a.paper_id = b.reference_paper_id
    WHERE published_at >= (SELECT MAX(strftime('%Y-%m-%d',datetime(published_at,'-5 years'))) FROM paper_author c WHERE a.author_id=c.author_id GROUP BY c.author_id)
    GROUP BY author_id, a.paper_id
    )
WHERE ranking <= citation_count
GROUP BY author_id