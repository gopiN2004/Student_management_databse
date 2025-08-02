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
(103, 'Chemistry








