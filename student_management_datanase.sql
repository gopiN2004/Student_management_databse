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








