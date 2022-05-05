/* Function */
DELIMITER $$
CREATE FUNCTION Patient_update (new_citizen_id BIGINT,health_ins_id BIGINT) 
RETURNS INT 
DETERMINISTIC
READS SQL DATA
BEGIN
    UPDATE patient
	SET citizen_id = new_citizen_id
	WHERE health_ins_id = 231561298;
    RETURN new_citizen_id;
END;

/*  Procedures */
DELIMITER $$
CREATE PROCEDURE Shift_department_doctor_id()
BEGIN
    select * from
	doctor_shift
	join doctor
	on doctor_shift.doctor_id = doctor.doctor_id
	join shift 
	on doctor_shift.shift_id = shift.shift_id
	where doctor_shift.d_id = 100000 & shift.shift_id = 435111 & doctor_shift.work_date = '2021-05-31';
END;

CREATE PROCEDURE Full_day_department_doctor_id ()
BEGIN
	select * from
	doctor_shift
	join doctor
	on doctor_shift.doctor_id = doctor.doctor_id
	join shift 
	on doctor_shift.shift_id = shift.shift_id
	where doctor.d_id = 2 && doctor_shift.work_date = '2021-05-31';
END;

CREATE PROCEDURE Shift_all_deparments_doctor_id  ()
BEGIN
	select * from
	doctor_shift
	join doctor
	on doctor_shift.doctor_id = doctor.doctor_id
	join shift 
	on doctor_shift.shift_id = shift.shift_id
	where shift.start_at = 7 && shift.end_at = 10 && doctor_shift.work_date = curDate();
END;

CREATE PROCEDURE Full_day_all_department_doctor_id  ()
BEGIN
	select * from
	doctor_shift
	join doctor
	on doctor_shift.doctor_id = doctor.doctor_id
	join shift 
	on doctor_shift.shift_id = shift.shift_id
	where doctor_shift.work_date = curDate();
END;

CREATE PROCEDURE Total_patients_shift_ward  ()
BEGIN
	select COUNT(*) from
	doctor_shift
	join doctor
	on doctor_shift.doctor_id = doctor.doctor_id
	join shift 
	on doctor_shift.shift_id = shift.shift_id
	join patient_case 
	on doctor_shift.doctor_id = patient_case.doctor_id
	where doctor.d_id = 2 && shift.start_at = 7 && shift.end_at = 10 && doctor_shift.work_date = curDate();
END;

CREATE PROCEDURE Total_inpatients_day_ward  ()
BEGIN
	select COUNT(*) from
	doctor_shift
	join doctor
	on doctor_shift.doctor_id = doctor.doctor_id
	join shift 
	on doctor_shift.shift_id = shift.shift_id
	join patient_case 
	on doctor_shift.doctor_id = patient_case.doctor_id
	join inpatient_case 
	on patient_case.case_id = inpatient_case.case_id
	where doctor.d_id = 2 && shift.start_at = 7 && shift.end_at = 10 && doctor_shift.work_date = curDate();
END;

CREATE PROCEDURE Total_outpatients_shift_ward  ()
BEGIN
	select COUNT(*) from
	doctor_shift
	join doctor
	on doctor_shift.doctor_id = doctor.doctor_id
	join shift 
	on doctor_shift.shift_id = shift.shift_id
	join patient_case 
	on doctor_shift.doctor_id = patient_case.doctor_id
	join outpatient_case 
	on patient_case.case_id = outpatient_case.case_id
	where doctor.d_id = 2 && shift.start_at = 7 && shift.end_at = 10 && doctor_shift.work_date = curDate();
END;

CREATE PROCEDURE Total_inpatients_case_all_ward  ()
BEGIN
	select COUNT(*) from
	doctor_shift
	join doctor
	on doctor_shift.doctor_id = doctor.doctor_id
	join shift 
	on doctor_shift.shift_id = shift.shift_id
	join patient_case 
	on doctor_shift.doctor_id = patient_case.doctor_id
	join inpatient_case 
	on patient_case.case_id = inpatient_case.case_id
	where shift.start_at = 7 && shift.end_at = 10 && doctor_shift.work_date = curDate();
END;

CREATE PROCEDURE Total_outpatients_case_ward  ()
BEGIN
	select COUNT(*) from
	doctor_shift
	join doctor
	on doctor_shift.doctor_id = doctor.doctor_id
	join shift 
	on doctor_shift.shift_id = shift.shift_id
	join patient_case 
	on doctor_shift.doctor_id = patient_case.doctor_id
	join outpatient_case 
	on patient_case.case_id = outpatient_case.case_id
	where shift.start_at = 7 && shift.end_at = 10 && doctor_shift.work_date = curDate();
END;

CREATE PROCEDURE Total_tests_day_ward  ()
BEGIN
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
	where doctor_shift.d_id = 2 && doctor_shift.work_date = curDate())
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
	where doctor_shift.d_id = 2 && doctor_shift.work_date = curDate())
	) as countTotal;
END;

CREATE PROCEDURE Total_tests_day_all_ward  ()
BEGIN
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
	where doctor_shift.work_date = curDate())
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
	where doctor_shift.work_date = curDate())
	) as countTotal;
END;

CREATE PROCEDURE Day_patient_id  ()
BEGIN
	SELECT DISTINCT Patient.*
	FROM Patient_Case, Patient
	WHERE
	DATE(Patient_Case.checkup_time) = '2021-12-12' AND
    Patient_Case.doctor_id = 1 AND
    Patient_Case.health_ins_id = Patient.health_ins_id;
END;

CREATE PROCEDURE Diagnosis_day_patient_id  ()
BEGIN
	SELECT Patient_Case.diagnosis
	FROM Patient_Case 
	WHERE 
	Patient_Case.health_ins_id = ( 
	SELECT DISTINCT Patient_Case.health_ins_id 
	FROM Patient_Case
	WHERE
	Patient_Case.doctor_id = 2 AND
	Patient_Case.health_ins_id = 1);
END;

CREATE PROCEDURE Patient_same_diagnosis ()
BEGIN
	SELECT DISTINCT Patient.*
	FROM Patient_Case, Patient
	WHERE
    Patient_Case.doctor_id = 1 AND
    Patient_Case.diagnosis = "COVID" AND
    Patient.health_ins_id = Patient_Case.health_ins_id;
END;

CREATE PROCEDURE Patient_UNUSUAL_same_diagnosis  ()
BEGIN
	SELECT DISTINCT Patient.*
	FROM Patient_Case, Patient, Test_Result, Test_Result_Index
	WHERE
    Patient_Case.doctor_id = 1 AND
    Patient_Case.diagnosis = "COVID" AND
    Patient_Case.health_ins_id = Patient.health_ins_id AND
    Test_Result.case_id = Patient_Case.case_id AND
    Test_Result.test_id = Test_Result_Index.test_id AND
    Test_Result_Index.result = "UNUSUAL";
END;

CREATE PROCEDURE Patient_discharge ()
BEGIN
	SELECT DISTINCT Patient.*
	FROM Patient_Case, Inpatient_Case, Medical_Record, Patient
	WHERE 
    Medical_Record.discharge_info_id IS NOT NULL AND
    Inpatient_Case.medical_record_id = Medical_Record.medical_record_id AND
    Inpatient_Case.case_id = Patient_Case.case_id AND
    Patient_Case.doctor_id = 1 AND
    Patient.health_ins_id = Patient_Case.health_ins_id;
END;

CREATE PROCEDURE Medication_last_taken ()
BEGIN
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
END;

CREATE PROCEDURE Medication_all_taken ()
BEGIN
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
END;

CREATE PROCEDURE Test_last_treatment  ()
BEGIN
	select Test_Result.test_date, Test_Result_Index.result, 
	Test_Index.index_name,Test_Index.threshhold
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
END;

CREATE PROCEDURE Test_done ()
BEGIN
	select *
	from patient
	join patient_case
	on patient_case.health_ins_id = patient.health_ins_id 
	join Test_Result
	on Test_Result.case_id = Patient_Case.case_id
END;

DELIMITER $$
CREATE PROCEDURE Test_abnormal ()
BEGIN
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
END;

DELIMITER $$
CREATE PROCEDURE Doctor_ID_last_treatment ()
BEGIN
	select doctor.fname,doctor.lname
	from patient
	join patient_case
	on patient_case.health_ins_id = patient.health_ins_id 
	join doctor 
	on patient_case.doctor_id = doctor.doctor_id
	order by patient_case.checkup_time desc
	limit 1;
END;

DELIMITER $$
CREATE PROCEDURE Doctor_ID_all_treatment  ()
BEGIN
	select doctor.fname,doctor.lname
	from patient
	join patient_case
	on patient_case.health_ins_id = patient.health_ins_id 
	join doctor 
	on patient_case.doctor_id = doctor.doctor_id
	order by patient_case.checkup_time desc;
END;

CREATE PROCEDURE Nutrition_last_treatment ()
BEGIN
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
END;

DELIMITER $$
CREATE PROCEDURE Diet_all_treatment ()
BEGIN
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
END;

DELIMITER $$
CREATE PROCEDURE Medical_inpatient_record ()
BEGIN
SELECT Medical_Instruction.*, Medicine.*
FROM Medical_Instruction, Medical_Medicine, Medicine
WHERE 
	Medical_Instruction.medical_instruction_id = Medical_Medicine.medical_instruction_id AND
    Medical_Instruction.case_id = ( 
			SELECT DISTINCT Patient_Case.case_id 
			FROM Inpatient_Case, Patient_Case
			WHERE
				Patient_Case.doctor_id = 1 AND
				Patient_Case.case_id = 2 AND
                Patient_Case.case_id = Inpatient_Case.case_id) AND
	Medicine.medicine_id = Medical_Medicine.medicine_id;
END;

DELIMITER $$
CREATE PROCEDURE Test_inpatient_results ()
BEGIN
SELECT *
FROM Medical_Instruction, Medical_Test
WHERE 
	Medical_Instruction.medical_instruction_id = Medical_Test.medical_instruction_id AND
    Medical_Instruction.case_id = ( 
			SELECT DISTINCT Patient_Case.case_id 
			FROM Inpatient_Case, Patient_Case
			WHERE
				Patient_Case.doctor_id = 1 AND
				Patient_Case.case_id = 2 AND
                Patient_Case.case_id = Inpatient_Case.case_id);
END;

DELIMITER $$
CREATE PROCEDURE Xray_inpatient_results ()
BEGIN
SELECT *
FROM Medical_Instruction, Medical_Xray
WHERE 
	Medical_Instruction.medical_instruction_id = Medical_Xray.medical_instruction_id AND
    Medical_Instruction.case_id = ( 
			SELECT DISTINCT Patient_Case.case_id 
			FROM Inpatient_Case, Patient_Case
			WHERE
				Patient_Case.doctor_id = 1 AND
				Patient_Case.case_id = 2 AND
                Patient_Case.case_id = Inpatient_Case.case_id);
END;