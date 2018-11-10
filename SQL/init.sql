CREATE TABLE `team` ( `team_id` VARCHAR ( 20 ) NOT NULL, `team_name` VARCHAR ( 20 ) NULL, PRIMARY KEY ( `team_id` ) );
CREATE TABLE `person` (
	`sid` VARCHAR ( 20 ) NOT NULL,
	`team_id` VARCHAR ( 20 ) NOT NULL,
	`school_id` VARCHAR ( 20 ) NULL,
	`name` VARCHAR ( 20 ) NULL,
	`rating` INT UNSIGNED NULL,
	PRIMARY KEY ( `sid` ) 
);
CREATE TABLE `school` ( `school_id` VARCHAR ( 20 ) NOT NULL, `school_name` VARCHAR ( 20 ) NULL, PRIMARY KEY ( `school_id` ) );
CREATE TABLE `login` ( `sid` VARCHAR ( 20 ) NOT NULL, `pwd` VARCHAR ( 20 ) NULL, PRIMARY KEY ( `sid` ) );
CREATE TABLE `exercise_record` (
	`sid` VARCHAR ( 20 ) NOT NULL,
	`submit_id` VARCHAR ( 20 ) NOT NULL,
	`oj_name` VARCHAR ( 10 ) NULL,
	`exercise_id` VARCHAR ( 10 ) NULL,
	`code` LONGTEXT NULL,
	`submit_time` datetime NULL ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY ( `sid`, `submit_id` ) 
);
CREATE TABLE `plan` ( `sid` VARCHAR ( 20 ) NOT NULL, `content` LONGTEXT NULL, `deadline` datetime NULL ON UPDATE CURRENT_TIMESTAMP, PRIMARY KEY ( `sid` ) );
CREATE TABLE `exercise` (
	`oj_name` VARCHAR ( 10 ) NOT NULL,
	`exercise_id` VARCHAR ( 10 ) NOT NULL,
	`statement` LONGTEXT NULL,
	`input_example` LONGTEXT NULL,
	`output_example` LONGTEXT NULL,
	PRIMARY KEY ( `oj_name`, `exercise_id` ) 
);
CREATE TABLE `contest` (
	`contest_id` VARCHAR ( 20 ) NOT NULL,
	`details` LONGTEXT NULL,
	`city` VARCHAR ( 20 ) NULL,
	`holds` datetime NULL ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY ( `contest_id` ) 
);
CREATE TABLE `participation` ( `team_id` VARCHAR ( 20 ) NOT NULL, `contest_id` VARCHAR ( 20 ) NOT NULL, PRIMARY KEY ( `team_id`, `contest_id` ) );


ALTER TABLE `person` ADD CONSTRAINT `fk_person_team_1` FOREIGN KEY ( `team_id` ) REFERENCES `team` ( `team_id` );
ALTER TABLE `person` ADD CONSTRAINT `fk_person_school_1` FOREIGN KEY ( `school_id` ) REFERENCES `school` ( `school_id` );
ALTER TABLE `exercise_record` ADD CONSTRAINT `fk_exercise_record_exercise_1` FOREIGN KEY ( `oj_name`, `exercise_id` ) REFERENCES `exercise` ( `oj_name`, `exercise_id` );
ALTER TABLE `exercise_record` ADD CONSTRAINT `fk_exercise_record_person_1` FOREIGN KEY ( `sid` ) REFERENCES `person` ( `sid` );
ALTER TABLE `plan` ADD CONSTRAINT `fk_plan_person_1` FOREIGN KEY ( `sid` ) REFERENCES `person` ( `sid` );
ALTER TABLE `participation` ADD CONSTRAINT `fk_participation_team_1` FOREIGN KEY ( `team_id` ) REFERENCES `team` ( `team_id` );
ALTER TABLE `participation` ADD CONSTRAINT `fk_participation_contest_1` FOREIGN KEY ( `contest_id` ) REFERENCES `contest` ( `contest_id` );