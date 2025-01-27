-- Write query to get count of assignments in each grade
SELECT grade, COUNT(*) AS graded_assignments
FROM assignments
WHERE state = 'GRADED' AND grade IS NOT NULL
GROUP BY grade;
