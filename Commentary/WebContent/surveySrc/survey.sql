

-- 추가

ALTER TABLE `toursurvey`.`survey` 
ADD COLUMN `start_dt` VARCHAR(20) NULL AFTER `reg_id`,
ADD COLUMN `end_dt` VARCHAR(20) NULL AFTER `start_dt`;

ALTER TABLE `toursurvey`.`survey` 
ADD COLUMN `mod_dt` VARCHAR(20) NULL DEFAULT NULL AFTER `end_dt`;

ALTER TABLE `toursurvey`.`survey` 
ADD COLUMN `del_yn` VARCHAR(45) NULL DEFAULT 'N' AFTER `mod_dt`;

ALTER TABLE `toursurvey`.`survey` 
ADD COLUMN `send_method` VARCHAR(20) NULL AFTER `del_yn`;