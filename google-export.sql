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

spool C:\Exports\Google\schools.csv
PROMPT school_id,school_name
select
CASE
WHEN Alternate_School_Number IS NULL THEN TO_CHAR(School_Number)
WHEN Alternate_School_Number = '0' THEN TO_CHAR(School_Number)
ELSE TO_CHAR(Alternate_School_Number)
END||','||
Abbreviation
FROM Schools
WHERE School_Number != '999999';
spool off

spool C:\Exports\Google\students.csv
PROMPT school_id,student_id,first_name,last_name,grade_level,user_name
select
CASE
WHEN Schools.Alternate_School_Number IS NULL THEN TO_CHAR(Schools.School_Number)
WHEN Schools.Alternate_School_Number = '0' THEN TO_CHAR(Schools.School_Number)
ELSE TO_CHAR(Schools.Alternate_School_Number)
END||','||
Students.ID||','||
Students.First_Name||','||
Students.Last_Name||','||
CASE
WHEN Students.Grade_Level = '0' THEN 'K'
WHEN Students.Grade_Level < '0' THEN 'ECS'
ELSE TO_CHAR(Students.Grade_Level)
END||','||
Students.Student_Web_ID
FROM Students
JOIN Schools ON Students.SchoolID = Schools.School_Number
WHERE Students.SchoolID NOT IN ('999999','0')
AND Students.Enroll_Status = '0'
AND Students.Student_Web_ID IS NOT NULL;
spool off

spool C:\Exports\Google\staff.csv
PROMPT school_id,staff_id,first_name,last_name,user_name
select
CASE
WHEN Schools.Alternate_School_Number IS NULL THEN TO_CHAR(Schools.School_Number)
WHEN Schools.Alternate_School_Number = '0' THEN TO_CHAR(Schools.School_Number)
ELSE TO_CHAR(Schools.Alternate_School_Number)
END||','||
Teachers.ID||','||
Teachers.First_Name||','||
Teachers.Last_Name||','||
Teachers.TeacherLoginID
FROM Teachers
JOIN Schools ON Teachers.SchoolID = Schools.School_Number
WHERE SchoolID NOT IN ('999999','0')
AND Status = '1'
AND Teachers.TeacherLoginID IS NOT NULL
AND Teachers.HomeSchoolID = Teachers.SchoolID;
spool off

spool C:\Exports\Google\classes.csv
PROMPT school_id,class_id,course_name,section_name,staff_id
select
CASE
WHEN Schools.Alternate_School_Number IS NULL THEN TO_CHAR(Schools.School_Number)
WHEN Schools.Alternate_School_Number = '0' THEN TO_CHAR(Schools.School_Number)
ELSE TO_CHAR(Schools.Alternate_School_Number)
END||','||
Sections.ID||','||
Courses.Course_Number||','||
Sections.Section_Number||','||
Sections.Teacher
FROM Sections
JOIN Courses ON Sections.Course_Number = Courses.Course_Number
JOIN Schools ON Sections.SchoolID = Schools.School_Number;
spool off

spool C:\Exports\Google\rosters.csv
PROMPT school_id,class_id,student_id
select
CASE
WHEN Schools.Alternate_School_Number IS NULL THEN TO_CHAR(Schools.School_Number)
WHEN Schools.Alternate_School_Number = '0' THEN TO_CHAR(Schools.School_Number)
ELSE TO_CHAR(Schools.Alternate_School_Number)
END||','||
SectionID||','||
StudentID
FROM CC
JOIN Schools ON CC.SchoolID = Schools.School_Number
WHERE SectionID > 0
AND TermID > 0;
spool off

exit;
