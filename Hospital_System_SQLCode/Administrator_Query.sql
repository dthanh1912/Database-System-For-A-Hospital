/*
View the list of doctors on duty in a shift in a day in a department.
*/
/*
select * from
doctor_shift
join doctor
on doctor_shift.doctor_id = doctor.doctor_id
join shift
on doctor_shift.shift_id = shift.shift_id
where doctor_shift.d_id = 100000 and shift.shift_id = 435111 and doctor_shift.work_date = '2021-05-31';
*/
/* View a list of doctors on duty for a day in a department. */
/*
select * from
doctor_shift
join doctor
on doctor_shift.doctor_id = doctor.doctor_id
join shift
on doctor_shift.shift_id = shift.shift_id
where doctor_shift.d_id = 100000 and  doctor_shift.work_date = '2021-05-31';
*/
/* View the list of doctors on duty at one shift in a day in all departments. */
/*
select concat(doctor.fname,doctor.lname) from
doctor_shift
join doctor
on doctor_shift.doctor_id = doctor.doctor_id
join shift
on doctor_shift.shift_id = shift.shift_id
where shift.shift_id = 435111 and doctor_shift.work_date = '2021-05-31';
*/
/* View a list of doctors on duty for a day in all departments. */
/*
select concat(doctor.fname,doctor.lname) from
doctor_shift
join doctor
on doctor_shift.doctor_id = doctor.doctor_id
join shift
on doctor_shift.shift_id = shift.shift_id
where doctor_shift.work_date = '2021-05-31';
*/
/* View the total number of patients in a shift in a day in a ward. */
/*
select COUNT(*) from
doctor_shift
join doctor
on doctor_shift.doctor_id = doctor.doctor_id
join shift
on doctor_shift.shift_id = shift.shift_id
join patient_case
on  doctor_shift.doctor_id = patient_case.doctor_id
where doctor_shift.d_id = 100000 and shift.shift_id = 435111 and doctor_shift.work_date = '2021-05-31';
*/
/* View the total number of inpatients admitted to a hospital in a single day in a ward. */
/*
select COUNT(*) from
doctor_shift
join doctor
on doctor_shift.doctor_id = doctor.doctor_id
join shift
on doctor_shift.shift_id = shift.shift_id
join patient_case
on  doctor_shift.doctor_id = patient_case.doctor_id
join inpatient_case
on patient_case.case_id = inpatient_case.case_id
where doctor_shift.d_id = 100000 and shift.shift_id = 435111 and doctor_shift.work_date = '2021-05-31';
*/
/* View the total number of outpatients in a shift in a day in a ward. */
/*
select COUNT(*) from
doctor_shift
join doctor
on doctor_shift.doctor_id = doctor.doctor_id
join shift
on doctor_shift.shift_id = shift.shift_id
join patient_case
on  doctor_shift.doctor_id = patient_case.doctor_id
join outpatient_case
on patient_case.case_id = outpatient_case.case_id
where doctor_shift.d_id = 100000 and shift.shift_id = 435111 and doctor_shift.work_date = '2021-05-31';
*/
/* View the total number of inpatients admitted to the hospital in one case in a day in all department. */
/*
select COUNT(*) from
doctor_shift
join doctor
on doctor_shift.doctor_id = doctor.doctor_id
join shift
on doctor_shift.shift_id = shift.shift_id
join patient_case
on  doctor_shift.doctor_id = patient_case.doctor_id
join inpatient_case
on patient_case.case_id = inpatient_case.case_id
where shift.shift_id = 435111 and doctor_shift.work_date = '2021-05-31';
*/
/*  View the total number of outpatients in a case in a day in all departments. */
/*
select COUNT(*) from
doctor_shift
join doctor
on doctor_shift.doctor_id = doctor.doctor_id
join shift
on doctor_shift.shift_id = shift.shift_id
join patient_case
on  doctor_shift.doctor_id = patient_case.doctor_id
join outpatient_case
on patient_case.case_id = outpatient_case.case_id
where shift.shift_id = 435111 and doctor_shift.work_date = '2021-05-31';
*/
/* View the total number of tests done in a day in a ward. */
/*
select
(select COUNT(*) from
medical_instruction
join medical_test
on medical_instruction.medical_instruction_id = medical_test.medical_instruction_id
join patient_case
on medical_instruction.case_id = patient_case.case_id
join doctor
on patient_case.doctor_id = doctor.doctor_id
join doctor_shift
on doctor.doctor_id = doctor_shift.doctor_id
where doctor_shift.d_id = 100000 and doctor_shift.work_date = '2021-05-31')
+
(select COUNT(*) from
medical_instruction
join medical_xray
on medical_instruction.medical_instruction_id = medical_xray.medical_instruction_id
join patient_case
on medical_instruction.case_id = patient_case.case_id
join doctor
on patient_case.doctor_id = doctor.doctor_id
join doctor_shift
on doctor.doctor_id = doctor_shift.doctor_id
where doctor_shift.d_id = 100000 and doctor_shift.work_date = '2021-05-31'
) as sumCount;
*/
/* View the total number of tests done in a day in all departments. */
/*
select (
(select COUNT(*) from
medical_instruction
join medical_test
on medical_instruction.medical_instruction_id = medical_test.medical_instruction_id
join patient_case
on medical_instruction.case_id = patient_case.case_id
join doctor
on patient_case.doctor_id = doctor.doctor_id
join doctor_shift
on doctor.doctor_id = doctor_shift.doctor_id
where doctor_shift.work_date = '2021-05-31')
+
(select COUNT(*) from
medical_instruction
join medical_xray
on medical_instruction.medical_instruction_id = medical_xray.medical_instruction_id
join patient_case
on medical_instruction.case_id = patient_case.case_id
join doctor
on patient_case.doctor_id = doctor.doctor_id
join doctor_shift
on doctor.doctor_id = doctor_shift.doctor_id
where doctor_shift.work_date = '2021-05-31')
) as countTotal;
