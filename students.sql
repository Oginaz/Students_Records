-- Create the database
CREATE DATABASE IF NOT EXISTS students_records;
USE students_records;

-- Create the Students table
CREATE TABLE Students (
    StudentId INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhysicalAddress VARCHAR(255),
    EnrollmentDate DATE DEFAULT CURRENT_DATE
);

-- Create the Teachers table
CREATE TABLE Teachers (
    TeacherId INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Department VARCHAR(50) NOT NULL
);

-- Create the Guardians table
CREATE TABLE Guardians (
    GuardianId INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Relationship ENUM('Parent', 'Sibling', 'Other') NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Address VARCHAR(255)
);

-- Junction table for Students and Guardians (Many-to-Many relationship)
CREATE TABLE StudentGuardians (
    StudentId INT,
    GuardianId INT,
    PRIMARY KEY (StudentId, GuardianId),
    FOREIGN KEY (StudentId) REFERENCES Students(StudentId) ON DELETE CASCADE,
    FOREIGN KEY (GuardianId) REFERENCES Guardians(GuardianId) ON DELETE CASCADE
);

-- Create the Classes table
CREATE TABLE Classes (
    ClassId INT AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(50) NOT NULL,
    TeacherId INT,
    Schedule VARCHAR(100),
    FOREIGN KEY (TeacherId) REFERENCES Teachers(TeacherId) ON DELETE SET NULL
);

-- Create the Couses table
CREATE TABLE Courses (
    CourseId INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    CourseCode VARCHAR(10) UNIQUE NOT NULL,
    Description TEXT
);

-- Enrollment table for Students and Course (Many-to-Many relationship)
CREATE TABLE Enrollments (
    EnrollmentId INT AUTO_INCREMENT PRIMARY KEY,
    StudentId INT,
    CourseId INT,
    EnrollmentDate DATE DEFAULT CURRENT_DATE,
    Grade CHAR(2),
    FOREIGN KEY (StudentId) REFERENCES Students(StudentId) ON DELETE CASCADE,
    FOREIGN KEY (CourseId) REFERENCES Courses(CourseId) ON DELETE CASCADE,
    UNIQUE (StudentId, CourseId)
);

-- Create the Attendance table
CREATE TABLE Attendance (
    AttendanceId INT AUTO_INCREMENT PRIMARY KEY,
    StudentId INT,
    ClassId INT,
    AttendanceDate DATE NOT NULL,
    Status ENUM('Present', 'Absent', 'Late') NOT NULL,
    FOREIGN KEY (StudentId) REFERENCES Students(StudentId) ON DELETE CASCADE,
    FOREIGN KEY (ClassId) REFERENCES Classes(ClassId) ON DELETE CASCADE
);

-- Create the Exams table
CREATE TABLE Exams (
    ExamId INT AUTO_INCREMENT PRIMARY KEY,
    CourseId INT,
    ExamDate DATE NOT NULL,
    TotalMarks INT NOT NULL,
    FOREIGN KEY (CourseId) REFERENCES Courses(CourseId) ON DELETE CASCADE
);

-- Create the grades table
CREATE TABLE Grades (
    GradeId INT AUTO_INCREMENT PRIMARY KEY,
    EnrollmentId INT NOT NULL,
    ExamId INT,
    TeacherId INT,
    Grade Char(2) NOT NULL,
    GradedDate DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (EnrollmentId) REFERENCES Enrollments(EnrollmentId) ON DELETE CASCADE,
    FOREIGN KEY (ExamId) REFERENCES Exams(ExamId) ON DELETE CASCADE,
    FOREIGN KEY (TeacherId) REFERENCES Teachers(TeacherId) ON DELETE SET NULL,
    UNIQUE (EnrollmentId, ExamId, TeacherId)
);
