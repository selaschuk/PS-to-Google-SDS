set ECHO off
set HEADING off
set FEEDBACK off
set PAGESIZE 0
SET TRIMOUT ON
SET TRIMSPOOL ON
SET LINESIZE 32000
SET LONG 32000
SET LONGCHUNKSIZE 32000
set TERMOUT off
SET VERIFY OFF
set recsep off
alter session set nls_date_format = 'mm/dd/yyyy';

define CURRENT_YEAR = 25

spool E:\exports\Google\schools.csv
PROMPT school_id,school_name
select
School_Number||','||
Abbreviation
FROM Schools
spool off

spool E:\exports\Google\students.csv
PROMPT school_id,student_id,first_name,last_name,grade_level,user_name
select
Schools.School_Number||','||
Students.ID||','||
Students.First_Name||','||
Students.Last_Name||','||
CASE
WHEN Students.Grade_Level = '0' THEN 'K'
WHEN Students.Grade_Level < '0' THEN 'ECS' --Enter in your abbreviation for Pre-K instead of ECS
ELSE TO_CHAR(Students.Grade_Level)
END||','||
Students.Student_Web_ID
FROM Students
JOIN Schools ON Students.SchoolID = Schools.School_Number
WHERE Students.Enroll_Status = '0'
AND Students.Student_Web_ID IS NOT NULL;
spool off

spool E:\exports\Google\staff.csv
PROMPT school_id,staff_id,first_name,last_name,user_name
select
Schools.School_Number||','||
Teachers.ID||','||
Teachers.First_Name||','||
Teachers.Last_Name||','||
Teachers.TeacherLoginID
FROM Teachers
JOIN Schools ON Teachers.SchoolID = Schools.School_Number
WHERE Status = '1'
AND Teachers.TeacherLoginID IS NOT NULL
AND Teachers.HomeSchoolID = Teachers.SchoolID;
spool off

spool E:\exports\Google\classes.csv
PROMPT school_id,class_id,course_name,section_name,staff_id
select
Schools.School_Number||','||
Sections.ID||','||
Courses.Course_Number||','||
Sections.Section_Number||','||
Sections.Teacher
FROM Sections
JOIN Courses ON Sections.Course_Number = Courses.Course_Number
JOIN Schools ON Sections.SchoolID = Schools.School_Number
WHERE SUBSTR(Sections.TermID, 1, 2) = &CURRENT_YEAR;
spool off

spool E:\exports\Google\rosters.csv
PROMPT school_id,class_id,student_id
select
Schools.School_Number||','||
SectionID||','||
StudentID
FROM CC
JOIN Schools ON CC.SchoolID = Schools.School_Number
JOIN Students ON CC.StudentID = Students.ID
WHERE SectionID > 0
AND SUBSTR(TermID, 1, 2) = &CURRENT_YEAR;
spool off

exit;
