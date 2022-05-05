CREATE DATABASE hospital_system;
USE hospital_system;

CREATE TABLE Department (
    d_id BIGINT PRIMARY KEY,
    d_name VARCHAR(20) NOT NULL
);
 
CREATE TABLE Shift (
    shift_id INT PRIMARY KEY,
    start_at TIME NOT NULL,
    end_at TIME NOT NULL
);
  
CREATE TABLE Doctor (
    doctor_id BIGINT PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    d_id BIGINT,
    FOREIGN KEY (d_id)
        REFERENCES Department (d_id)
);
 
CREATE TABLE Doctor_Shift (
    doctor_id BIGINT PRIMARY KEY,
    shift_id INT,
    work_date DATE,
    d_id BIGINT,
    FOREIGN KEY (doctor_id)
        REFERENCES Doctor (doctor_id),
    FOREIGN KEY (shift_id)
        REFERENCES Shift (shift_id),
    FOREIGN KEY (d_id)
        REFERENCES Department (d_id)
);
 
CREATE TABLE Nurse (
    nurse_id BIGINT PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL
);
 
CREATE TABLE Staff (
    staff_id BIGINT PRIMARY KEY,
    FOREIGN KEY (staff_id)
        REFERENCES Nurse (nurse_id)
);
 
CREATE TABLE Patient (
    health_ins_id BIGINT PRIMARY KEY,
    citizen_id BIGINT NOT NULL
);
 
CREATE TABLE Patient_Case (
    case_id BIGINT PRIMARY KEY,
    doctor_id BIGINT,
    nurse_id BIGINT,
    health_ins_id BIGINT NOT NULL,
    checkup_time DATETIME,
    FOREIGN KEY (doctor_id)
        REFERENCES Doctor (doctor_id),
    FOREIGN KEY (nurse_id)
        REFERENCES Nurse (nurse_id),
    FOREIGN KEY (health_ins_id)
        REFERENCES Patient (health_ins_id),
    symptom VARCHAR(20) NOT NULL,
    diagnosis VARCHAR(20) NOT NULL
);
 
CREATE TABLE Discharge_Info (
    discharge_info_id BIGINT PRIMARY KEY,
    doctor_id BIGINT,
    FOREIGN KEY (doctor_id)
        REFERENCES Doctor (doctor_id),
    diagnosis VARCHAR(20),
    discharged_status VARCHAR(20),
    discharged_time DATETIME NOT NULL,
    discharged_note VARCHAR(20),
    nutrition VARCHAR(20)
);

CREATE TABLE Medical_Record (
    medical_record_id BIGINT PRIMARY KEY,
    bed_no INT NOT NULL,
    room_no INT NOT NULL,
    doctor_id BIGINT,
    FOREIGN KEY (doctor_id)
        REFERENCES Doctor (doctor_id),
    diagnosis VARCHAR(20),
    hospitalized_status VARCHAR(20),
    hospitalized_time DATETIME NOT NULL,
    discharge_info_id BIGINT,
    FOREIGN KEY (discharge_info_id)
        REFERENCES Discharge_Info (discharge_info_id)
);

CREATE TABLE Inpatient_Case (
    case_id BIGINT PRIMARY KEY,
    FOREIGN KEY (case_id)
        REFERENCES Patient_Case (case_id),
    next_reexam_time DATE,
    medical_record_id BIGINT,
    FOREIGN KEY (medical_record_id)
        REFERENCES Medical_Record (medical_record_id)
);
 
CREATE TABLE Outpatient_Case (
    case_id BIGINT PRIMARY KEY,
    FOREIGN KEY (case_id)
        REFERENCES Patient_Case (case_id),
    nutrition VARCHAR(20),
    reexam_time DATETIME NOT NULL
);

CREATE TABLE Medicine (
    medicine_id BIGINT PRIMARY KEY,
    medicine_name VARCHAR(20),
    note VARCHAR(20)
);

CREATE TABLE Take_Home_Precription (
    case_id BIGINT PRIMARY KEY,
    medicine_id BIGINT,
    FOREIGN KEY (case_id)
        REFERENCES Patient_Case (case_id),
    FOREIGN KEY (medicine_id)
        REFERENCES Medicine (medicine_id),
    dose INT,
    note VARCHAR(20),
    guide VARCHAR(20)
);
 
CREATE TABLE Medical_Instruction (
    medical_instruction_id BIGINT PRIMARY KEY,
    case_id BIGINT,
    FOREIGN KEY (case_id)
        REFERENCES Patient_Case (case_id),
	release_date DATETIME
);
  
CREATE TABLE Medical_Medicine (
    medical_instruction_id BIGINT PRIMARY KEY,
    medicine_id BIGINT,
    FOREIGN KEY (medical_instruction_id)
        REFERENCES Medical_Instruction (medical_instruction_id),
    FOREIGN KEY (medicine_id)
        REFERENCES Medicine (medicine_id),
    dose INT,
    note VARCHAR(20)
);
  
CREATE TABLE Medical_Nutrition (
    medical_instruction_id BIGINT PRIMARY KEY,
    staff_id BIGINT,
    FOREIGN KEY (medical_instruction_id)
        REFERENCES Medical_Instruction (medical_instruction_id),
    FOREIGN KEY (staff_id)
        REFERENCES Staff (staff_id),
    nutrition VARCHAR(20)
);
  
CREATE TABLE Test_Result (
    test_id BIGINT PRIMARY KEY,
    doctor_id BIGINT,
    case_id BIGINT,
    test_date DATETIME,
    FOREIGN KEY (doctor_id)
        REFERENCES Doctor (doctor_id),
    FOREIGN KEY (case_id)
        REFERENCES Patient_Case (case_id)
);
 
CREATE TABLE Xray_Result (
    xray_id BIGINT PRIMARY KEY,
    doctor_id BIGINT,
    case_id BIGINT,
    xray_date DATETIME,
    FOREIGN KEY (doctor_id)
        REFERENCES Doctor (doctor_id),
    FOREIGN KEY (case_id)
        REFERENCES Patient_Case (case_id)
);
 
CREATE TABLE Test_Index (
    test_index_id BIGINT PRIMARY KEY,
    index_name VARCHAR(20),
    threshhold FLOAT
);
 
CREATE TABLE Test_Result_Index (
    test_id BIGINT PRIMARY KEY,
    test_index_id BIGINT,
    FOREIGN KEY (test_id)
        REFERENCES Test_Result (test_id),
    FOREIGN KEY (test_index_id)
        REFERENCES Test_Index (test_index_id),
    result VARCHAR(20)
);
 
CREATE TABLE Medical_Xray (
    medical_instruction_id BIGINT PRIMARY KEY,
    xray_id BIGINT,
    FOREIGN KEY (medical_instruction_id)
        REFERENCES Medical_Instruction (medical_instruction_id),
    FOREIGN KEY (xray_id)
        REFERENCES Xray_Result (xray_id)
);
 
CREATE TABLE Medical_Test (
    medical_instruction_id BIGINT PRIMARY KEY,
    nurse_id BIGINT,
    test_id BIGINT,
    FOREIGN KEY (medical_instruction_id)
        REFERENCES Medical_Instruction (medical_instruction_id),
    FOREIGN KEY (nurse_id)
        REFERENCES Nurse (nurse_id),
    FOREIGN KEY (test_id)
        REFERENCES Test_Result (test_id)
);
 
 
 
 