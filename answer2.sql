-- ANSWER 2
-- 각 저자의 년도yyyy별 출판수, 인용수 구하기
SELECT author_id,
    CAST(strftime('%Y', published_at) AS integer) AS year,
    COUNT(DISTINCT a.paper_id) AS publication_count,
    COUNT(b.paper_id) AS citation_count
FROM paper_author a
LEFT JOIN paper_reference b
ON a.paper_id = b.reference_paper_id
GROUP BY author_id, year