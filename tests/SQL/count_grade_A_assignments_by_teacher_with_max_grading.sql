-- Write query to find the number of grade A's given by the teacher who has graded the most assignments
-- SELECT COUNT(*) AS grade_A_assignments FROM assignments WHERE grade = 'A';

-- SELECT teacher_id, COUNT(*) AS count 
-- FROM assignments 
-- WHERE state = 'GRADED' AND grade IS NOT NULL
-- GROUP BY teacher_id;

SELECT COUNT(*) AS grade_A_assignments
FROM assignments
WHERE state = 'GRADED'
  AND grade = 'A'
  AND teacher_id = (
    SELECT teacher_id
    FROM assignments
    WHERE state = 'GRADED' AND grade IS NOT NULL
    GROUP BY teacher_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

