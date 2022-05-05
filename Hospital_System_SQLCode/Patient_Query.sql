/* Update demographic information and health insurance information. */
/*
UPDATE patient
SET citizen_id = 6067954738444
WHERE health_ins_id = 231561298;
*/

/* View a list of the medications you took during your last treatment. */
/*
(select (medicine.medicine_name)
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join take_home_precription
on take_home_precription.case_id = patient_case.case_id
join medicine
on medicine.medicine_id = take_home_precription.medicine_id
order by patient_case.checkup_time desc
limit 1)
union 
(select (medicine.medicine_name)
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join inpatient_case
on inpatient_case.case_id = patient_case.case_id
join medical_instruction
on medical_instruction.case_id = inpatient_case.case_id
join medical_medicine 
on medical_medicine.medical_instruction_id = medical_instruction.medical_instruction_id
join medicine
on medicine.medicine_id = medical_medicine.medicine_id 
order by patient_case.checkup_time desc
limit 1);
*/

/* See a list of medicines that you have taken in all of your treatments. */
/*
select (medicine.medicine_name)
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join take_home_precription
on take_home_precription.case_id = patient_case.case_id
join medicine
on medicine.medicine_id = take_home_precription.medicine_id
union 
select (medicine.medicine_name)
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join inpatient_case
on inpatient_case.case_id = patient_case.case_id
join medical_instruction
on medical_instruction.case_id = inpatient_case.case_id
join medical_medicine 
on medical_medicine.medical_instruction_id = medical_instruction.medical_instruction_id
join medicine
on medicine.medicine_id = medical_medicine.medicine_id;
*/
/* View test results from the last treatment. */
/*
select Test_Result.test_date, Test_Result_Index.result, Test_Index.index_name,Test_Index.threshhold
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join Test_Result
on Test_Result.case_id = Patient_Case.case_id
join Test_Result_Index 
on Test_Result_Index.test_id = Test_Result.test_id
join test_index
on test_index.test_index_id = test_result_index.test_index_id
order by patient_case.checkup_time desc
limit 1;
*/
/* See a list of all the tests you’ve done. */
/*
select *
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join Test_Result
on Test_Result.case_id = Patient_Case.case_id
*/
/* See a list of all tests with the “abnormal” note of a test metric experience that I did. */
/*
select *
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join Test_Result
on Test_Result.case_id = Patient_Case.case_id
join Test_Result_Index 
on Test_Result_Index.test_id = Test_Result.test_id
join test_index
on test_index.test_index_id = test_result_index.test_index_id
where index_name = 'Abnormal';
*/
/*  View the list of doctors who have treated the last treatment. */
/*
select doctor.fname,doctor.lname
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join doctor 
on patient_case.doctor_id = doctor.doctor_id
order by patient_case.checkup_time desc
limit 1;
*/
/* View a list of doctors who have treated in all treatments. */
/*
select doctor.fname,doctor.lname
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join doctor 
on patient_case.doctor_id = doctor.doctor_id
order by patient_case.checkup_time desc;
*/
/*  See the nutrition regimen if indicated during the last treatment. */
/*
(
select medical_nutrition.nutrition
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join inpatient_case
on inpatient_case.case_id = patient_case.case_id
join medical_instruction
on medical_instruction.case_id = inpatient_case.case_id
join medical_nutrition
on medical_nutrition.medical_instruction_id = medical_instruction.medical_instruction_id
order by patient_case.checkup_time desc
limit 1
)
union 
(
select (outpatient_case.nutrition)
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join outpatient_case
on Outpatient_Case.case_id = patient_case.case_id
order by patient_case.checkup_time desc
limit 1
);
*/
/* See list of diets if indicated in all treatments */
/*
(
select medical_nutrition.nutrition
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join inpatient_case
on inpatient_case.case_id = patient_case.case_id
join medical_instruction
on medical_instruction.case_id = inpatient_case.case_id
join medical_nutrition
on medical_nutrition.medical_instruction_id = medical_instruction.medical_instruction_id
order by patient_case.checkup_time desc
)
union 
(
select (outpatient_case.nutrition)
from patient
join patient_case
on patient_case.health_ins_id = patient.health_ins_id 
join outpatient_case
on Outpatient_Case.case_id = patient_case.case_id
order by patient_case.checkup_time desc
);
*/