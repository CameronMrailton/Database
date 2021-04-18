SHOW DATABASES;

DROP DATABASE IF EXISTS crailtoassign2db;

CREATE DATABASE crailtoassign2db;

USE crailtoassign2db;

GRANT USAGE ON *.* TO 'ta'@'localhost';
DROP USER 'ta'@'localhost';
CREATE USER 'ta'@'localhost' IDENTIFIED BY 'cs3319';
GRANT ALL PRIVILEGES ON yourwesternuseridassign2db.* TO 'ta'@'localhost';
FLUSH PRIVILEGES;

SHOW TABLES;

CREATE TABLE universities(uniqueNumber int NOT NULL,
                          CHECK(uniqueNumber >0 AND uniqueNumber < 100),
                          officialName varchar(50) NOT NULL,
                          nickName varchar(20) NOT NULL,
                          city varchar(20) NOT NULL, 
                          province varchar(20) NOT NULL, 
                          PRIMARY KEY (uniqueNumber));
                          
CREATE TABLE WesternCourses(courseNumber varchar(6) NOT NULL,
                          CHECK(courseNumber LIKE 'CS####'),
                          courseName varchar(50) NOT NULL,
                          courseWeight varchar(3) NOT NULL,
                          courseSuffix varchar(20),
                          CHECK(courseSuffix LIKE 'A/B' or courseSuffix LIKE 'F/G' or courseSuffix LIKE 'E' or courseSuffix LIKE 'Y' or courseSuffix LIKE 'Z' or courseSuffix is NULL),                      
                          CHECK(courseWeight LIKE '.50' or courseWeight LIKE '1.0'),
                          PRIMARY KEY (courseNumber));

CREATE TABLE OutsideCourses(code varchar(10) NOT NULL,
                          CHECK(code LIKE 'CompSci###'),
                          courseName varchar(50) NOT NULL,
                          courseYear varchar(1) NOT NULL,
                          CHECK(courseYear LIKE '1' or courseYear LIKE '2' or courseYear LIKE '3' or courseYear LIKE '4'),
                          courseWeight varchar(3) NOT NULL, 
                          CHECK(courseWeight LIKE '.5' or courseWeight LIKE '1'),
                          uniqueNumber int NOT NULL,
                          FOREIGN KEY (uniqueNumber) REFERENCES universities(uniqueNumber) ,
                          PRIMARY KEY (code,uniqueNumber));
                  
                          
CREATE TABLE Equivalent(courseNumber varchar(6) NOT NULL,
                          code varchar(10) NOT NULL,
 			  uniqueNumber int NOT NULL,
                          equivalentDate DATE NOT NULL,
                          FOREIGN KEY (courseNumber) REFERENCES WesternCourses(courseNumber),
                          FOREIGN KEY (uniqueNumber)  REFERENCES universities(uniqueNumber) ON DELETE RESTRICT, 
			  FOREIGN KEY (code) REFERENCES OutsideCourses(code) ON UPDATE CASCADE,
                          PRIMARY KEY (courseNumber,code, uniqueNumber));
                          
SHOW TABLES;                    
                          
