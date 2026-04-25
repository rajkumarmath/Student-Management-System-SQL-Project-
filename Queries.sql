Student Course Management System

1.
SELECT s.name AS student, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

2.
SELECT s.name, c.course_name, g.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id;

3.
SELECT c.course_name,
AVG(
    CASE 
        WHEN g.grade = 'A' THEN 10
        WHEN g.grade = 'B' THEN 8
        WHEN g.grade = 'C' THEN 6
        ELSE 0
    END
) AS avg_score
FROM Grades g
JOIN Enrollments e ON g.enrollment_id = e.enrollment_id
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

4.
SELECT s.name, COUNT(*) AS A_count
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id
WHERE g.grade = 'A'
GROUP BY s.name
ORDER BY A_count DESC;

5.
SELECT course_name 
FROM Courses
WHERE course_id NOT IN (
    SELECT course_id FROM Enrollments
);

6.
SELECT name 
FROM Students
WHERE student_id NOT IN (
    SELECT student_id FROM Enrollments
);

7.
CREATE VIEW student_report AS
SELECT s.name, c.course_name, g.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id;

8.
DELIMITER //

CREATE TRIGGER default_grade
AFTER INSERT ON Enrollments
FOR EACH ROW
BEGIN
    INSERT INTO Grades (enrollment_id, grade)
    VALUES (NEW.enrollment_id, 'C');
END;
//

DELIMITER ;


