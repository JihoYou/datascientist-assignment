-- ANSWER 1
-- 각 저자의 출판수(publication_count), 인용수(citation_count) 구하기
SELECT author_id,
    COUNT(DISTINCT a.paper_id) AS publication_count,
    COUNT(b.paper_id) AS citation_count
FROM paper_author a
LEFT JOIN paper_reference b
ON a.paper_id = b.reference_paper_id
GROUP BY author_id