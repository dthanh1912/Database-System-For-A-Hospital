USE hospital_system;

/*(ii.1). Cập nhật hoạt động khám/chữa bệnh cho bệnh nhân ngoại trú trong một ca trực.*/


/*(ii.2). Cập nhật hoạt động khám/chữa bệnh cho bệnh nhân nội trú trong một ca trực.*/


/*(ii.3). Xem danh sách bệnh nhân trong một ngày mà mình đã phụ trách.*/
SELECT DISTINCT Patient.*
FROM Patient_Case, Patient
WHERE
	DATE(Patient_Case.checkup_time) = '2021-12-12' AND
    Patient_Case.doctor_id = 1 AND
    Patient_Case.health_ins_id = Patient.health_ins_id;

/*(ii.4). Xem các chẩn đoán bệnh của một bệnh nhân mà mình đã phụ trách.*/
SELECT Patient_Case.diagnosis
FROM Patient_Case 
WHERE 
	Patient_Case.health_ins_id = ( 
		SELECT DISTINCT Patient_Case.health_ins_id 
			FROM Patient_Case
			WHERE
				Patient_Case.doctor_id = 2 AND
				Patient_Case.health_ins_id = 1);

/*(ii.5). Xem các thuốc đã được dùng qua các ngày của một bệnh nhân nội trú mà mình đã phụ trách.*/
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

/*(ii.6). Xem các chỉ định xét nghiệm đã làm qua các ngày của một bệnh nhân nội trú mà mình đã phụ trách.*/
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

/*(ii.7). Xem các chỉ định chụp phim đã làm qua các ngày của một bệnh nhân nội trú mà mình đã phụ trách.*/
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

/*(ii.8). Xem các bệnh nhân của cùng một bệnh mà mình đã chẩn đoán.*/
SELECT DISTINCT Patient.*
FROM Patient_Case, Patient
WHERE
    Patient_Case.doctor_id = 1 AND
    Patient_Case.diagnosis = "COVID" AND
    Patient.health_ins_id = Patient_Case.health_ins_id;

/*(ii.9). Xem các bệnh nhân có ghi chú “bất thường” trong kết quả xét nghiệm của cùng một bệnh mà mình đã chẩn đoán.*/
SELECT DISTINCT Patient.*
FROM Patient_Case, Patient, Test_Result, Test_Result_Index
WHERE
    Patient_Case.doctor_id = 1 AND
    Patient_Case.diagnosis = "COVID" AND
    Patient_Case.health_ins_id = Patient.health_ins_id AND
    Test_Result.case_id = Patient_Case.case_id AND
    Test_Result.test_id = Test_Result_Index.test_id AND
    Test_Result_Index.result = "UNUSUAL";

/*(ii.10). Xem các bệnh nhân đã xuất viện mà mình đã phụ trách.*/
SELECT DISTINCT Patient.*
FROM Patient_Case, Inpatient_Case, Medical_Record, Patient
WHERE 
    Medical_Record.discharge_info_id IS NOT NULL AND
    Inpatient_Case.medical_record_id = Medical_Record.medical_record_id AND
    Inpatient_Case.case_id = Patient_Case.case_id AND
    Patient_Case.doctor_id = 1 AND
    Patient.health_ins_id = Patient_Case.health_ins_id;

/*(ii.11). Xem các bệnh nhân nội trú có số lượng dùng của một loại thuốc giảm dần trong 3 lần dùng thuốc liên tiếp mà mình đã phụ trách.*/

/*(ii.12). Xem các bệnh nhân có ghi chú “bình thường” của một chỉ số xét nghiệm trong kết quả xét nghiệm gần nhất nhưng có ghi chú “bất thường” của cùng một chỉ số xét nghiệm trong kết quả xét nghiệm trước đó mà mình đã phụ trách.*/