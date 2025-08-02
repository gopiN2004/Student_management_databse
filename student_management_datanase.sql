select s.name , e.enroll_date from 
enrollement e JOIN  students s
on e.student_id = s.student_id
where e.enroll_date > '2025-08-02';







