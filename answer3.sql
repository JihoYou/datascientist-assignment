-- ANSWER 3
-- 각 저자의 년-월yyyy-mm별 출판수와 인용수 구하기
SELECT author_id,
    strftime('%Y-%m', published_at) AS yearmonth,
    COUNT(DISTINCT a.paper_id) AS publication_count,
    COUNT(b.paper_id) AS citation_count
FROM paper_author a
LEFT JOIN paper_reference b
ON a.paper_id = b.reference_paper_id
GROUP BY author_id, yearmonth