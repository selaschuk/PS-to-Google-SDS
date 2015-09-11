# PS to Google SDS
Script for exporting PowerSchool data for use with [Google School Directory Sync](https://support.google.com/a/answer/6027781?vid=1-635775963625006254-4294363508)

google-export.bat is a simple bat file designed to be run as a scheduled task on the PowerSchool Database server to execute the google-export.sql query

* Exports Schools with their abbreviation instead of their whole name due to length concerns
* Exports Courses with their course number instead of their name due to length and naming concerns
* If grade level is 0, substitues K
* If grade level is less than 0, substitues ECS (you may call pre-K something else, adjust as necessary)
* Ignores Students/Staff that don't have Student_Web_ID/TeacherLoginID set in powerschool

Once the requisite text files have been generated, you can run Google SDS to create your users and groups (although if you already have an directory infrastructure, [Google Apps Directory Sync](https://support.google.com/a/answer/106368?vid=1-635775963625006254-4294363508&vid=1-635775963625006254-4294363508) is better suited to creating the users)
