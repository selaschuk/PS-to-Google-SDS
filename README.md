# PS to Google SDS
Script for exporting PowerSchool data for use with Google School Directory Sync

google-export.bat is a simple bat file designed to be run as a scheduled task on the PowerSchool Database server to execute the google-export.sql query

* Exports Schools with their abbreviation instead of their whole name due to length concerns
* Exports Courses with their course number instead of their name due to length and naming concerns
* Checks to see if Alternate_School_Number is set and uses that (for cases where you have something like a summer school with a different school number, but technically reports as the normal school)
* If grade level is 0, substitues K
* If grade level is less than 0, substitues ECS (you may call pre-K something else, adjust as necessary)
* Ignores Students/Staff that don't have Student_Web_ID/TeacherLoginID set in powerschool
