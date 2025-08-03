-- Create Tables
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor VARCHAR(100)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert Sample Data
INSERT INTO Students VALUES
(1, 'Arjun', 20, 'Male'),
(2, 'Divya', 22, 'Female'),
(3, 'Rahul', 21, 'Male'),
(4, 'Priya', 23, 'Female');

INSERT INTO Courses VALUES
(101, 'Mathematics', 'Dr. Kumar'),
(102, 'Physics', 'Dr. Sharma'),
(103, 'Chemistry', 'Dr. Meena');

INSERT INTO Enrollments VALUES
(1, 1, 101, '2025-08-01'),
(2, 3, 101, '2025-08-03'),
(3, 2, 102, '2025-08-02'),
(4, 4, 103, '2025-08-04'),
(5, 2, 103, '2025-08-05');

-- Query 1: Show all enrollments with student names and course names
SELECT s.name, c.course_name, e.enroll_date
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- Query 2: Show number of students in each course
SELECT c.course_name, COUNT(*) AS total_students
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

-- Query 3: List all students and the courses they are enrolled in
SELECT s.name AS student_name, GROUP_CONCAT(c.course_name SEPARATOR ', ') AS courses
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
GROUP BY s.name;

-- Query 4: Find students who enrolled in more than one course
SELECT s.name, COUNT(e.course_id) AS course_count
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
GROUP BY s.name
HAVING course_count > 1;

-- Query 5: Number of students in each course
SELECT c.course_name, COUNT(*) AS total_students
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

-- Query 6: Latest enrolled student in each course
SELECT s.name, c.course_name, e.enroll_date
FROM Enrollments e
JOIN Students s ON s.student_id = e.student_id
JOIN Courses c ON c.course_id = e.course_id
WHERE (e.course_id, e.enroll_date) IN (
    SELECT course_id, MAX(enroll_date)
    FROM Enrollments
     GROUP BY course_id
);

--order by an enrolleent 
SELECT c.course_name, COUNT(*) AS total_enrollments
FROM Enrollments e
JOIN Courses c ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY total_enrollments DESC;

-- Task 1: List all students with the number of courses they enrolled in
SELECT s.name, COUNT(*) AS total_courses
FROM enrollement e
JOIN students s ON s.student_id = e.student_id
GROUP BY s.name;

-- Task 2: Show courses with no students enrolled
SELECT c.course_name
FROM courses c
LEFT JOIN enrollement e ON c.course_id = e.course_id
WHERE e.course_id IS NULL;

-- Task 3: Students who enrolled in more than 1 course
SELECT s.name, COUNT(*) AS total_enrollments
FROM enrollement e
JOIN students s ON s.student_id = e.student_id
GROUP BY s.name
HAVING COUNT(*) > 1;

-- Task 4: First student who enrolled in each course
SELECT c.course_name, s.name, e.enroll_date
FROM enrollement e
JOIN students s ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
WHERE (c.course_id, e.enroll_date) IN (
    SELECT course_id, MIN(enroll_date)
    FROM enrollement
    GROUP BY course_id
);

-- Task 5: Course-wise latest enrolled student
SELECT s.name, c.course_name, e.enroll_date
FROM enrollement e
JOIN students s ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
WHERE (c.course_id, e.enroll_date) IN (
    SELECT course_id, MAX(enroll_date)
    FROM enrollement
    GROUP BY course_id
);

-- Task 6: Students who enrolled in all available courses
SELECT s.name
FROM students s
JOIN enrollement e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(DISTINCT e.course_id) = (SELECT COUNT(*) FROM courses);

-- Task 7: Average number of students per course
SELECT AVG(student_count) AS avg_students_per_course
FROM (
    SELECT COUNT(DISTINCT student_id) AS student_count
    FROM enrollement
    GROUP BY course_id
) AS sub;


    








