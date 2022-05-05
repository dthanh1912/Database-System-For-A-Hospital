DROP ROLE IF EXISTS 'administrator'; 
CREATE ROLE 'administrator';
DROP ROLE IF EXISTS 'doctor'; 
CREATE ROLE 'doctor';
DROP ROLE IF EXISTS 'patient'; 
CREATE ROLE 'patient';
/* administrator */

GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_system.department to 'administrator';
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_system.doctor_shift to 'administrator';
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_system.shift to 'administrator';
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_system.doctor to 'administrator';
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_system.patient to 'administrator';

/* doctor */
GRANT SELECT ON hospital_system.doctor_shift to 'doctor';
GRANT SELECT ON hospital_system.shift to 'doctor';
GRANT SELECT, INSERT, UPDATE ON hospital_system.patient_case to 'doctor';
GRANT SELECT ON hospital_system.nurse to 'doctor';
GRANT INSERT, UPDATE ON hospital_system.medical_instruction to 'doctor';
GRANT INSERT, UPDATE ON hospital_system.test_result to 'doctor';
GRANT INSERT, UPDATE ON hospital_system.xray_result to 'doctor';
GRANT INSERT, UPDATE ON hospital_system.medical_record to 'doctor';
GRANT INSERT, UPDATE ON hospital_system.discharge_info to 'doctor';
GRANT INSERT, UPDATE ON hospital_system.take_home_precription to 'doctor';
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_system.medicine to 'doctor';

/* patient */
GRANT UPDATE ON hospital_system.patient to 'patient';
GRANT SELECT ON hospital_system.Medical_Record to 'patient';
GRANT SELECT ON hospital_system.take_home_precription to 'patient';
GRANT SELECT ON hospital_system.patient_case to 'patient';
GRANT SELECT ON hospital_system.test_result to 'patient';
GRANT SELECT ON hospital_system.xray_result to 'patient';

DROP USER IF EXISTS 'administrator'@'localhost';
CREATE USER 'administrator'@'localhost' IDENTIFIED BY 'password';
GRANT 'administrator' to 'administrator'@'localhost';
SHOW GRANTS FOR 'administrator'@'localhost';

DROP USER IF EXISTS 'doctor'@'localhost';
CREATE USER 'doctor'@'localhost' IDENTIFIED BY 'password';
GRANT 'doctor' to 'doctor'@'localhost';
SHOW GRANTS FOR 'doctor'@'localhost';

DROP USER IF EXISTS 'patient'@'localhost';
CREATE USER 'patient'@'localhost' IDENTIFIED BY 'password';
GRANT 'patient' to 'patient'@'localhost';
SHOW GRANTS FOR 'patient'@'localhost';
