-- ANSWER 4
-- 각 저자의 h-index 구하기
SELECT author_id, COUNT(*) AS hindex
FROM(
    SELECT author_id,
        COUNT(b.paper_id) AS citation_count,
        row_number() OVER (PARTITION BY author_id ORDER BY COUNT(b.paper_id) DESC) AS ranking
    FROM paper_author a
    LEFT JOIN paper_reference b
    ON a.paper_id = b.reference_paper_id
    GROUP BY a.author_id, a.paper_id
    )
WHERE ranking <= citation_count
GROUP BY author_id