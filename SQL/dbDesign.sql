CREATE TABLE `contest` (
`contest_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`details` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
`city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
`holds` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`contest_id`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;

CREATE TABLE `problem` (
`oj` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`pid` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`statement` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
`input_example` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
`output_example` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
PRIMARY KEY (`oj`, `pid`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;

CREATE TABLE `submission` (
`sid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`submit_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`oj` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
`pid` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
`code` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
`submit_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`sid`, `submit_id`) ,
INDEX `fk_exercise_record_exercise_1` (`oj` ASC, `pid` ASC) USING BTREE
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;

CREATE TABLE `login` (
`sid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
PRIMARY KEY (`sid`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;

CREATE TABLE `participation` (
`team_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`contest_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
PRIMARY KEY (`team_id`, `contest_id`) ,
INDEX `fk_participation_contest_1` (`contest_id` ASC) USING BTREE
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;

CREATE TABLE `member` (
`sid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`team_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
`school_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
`rating` int(10) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`sid`) ,
INDEX `fk_person_team_1` (`team_id` ASC) USING BTREE,
INDEX `fk_person_school_1` (`school_id` ASC) USING BTREE
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;

CREATE TABLE `plan` (
`sid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
`deadline` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`sid`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;

CREATE TABLE `school` (
`school_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`school_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
PRIMARY KEY (`school_id`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;

CREATE TABLE `team` (
`team_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`team_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
PRIMARY KEY (`team_id`) 
)
ENGINE = InnoDB
AUTO_INCREMENT = 0
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;


ALTER TABLE `submission` ADD CONSTRAINT `fk_submission_problem_1` FOREIGN KEY (`oj`, `pid`) REFERENCES `problem` (`oj`, `pid`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `submission` ADD CONSTRAINT `fk_submission_member_1` FOREIGN KEY (`sid`) REFERENCES `member` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `participation` ADD CONSTRAINT `fk_participation_contest_1` FOREIGN KEY (`contest_id`) REFERENCES `contest` (`contest_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `participation` ADD CONSTRAINT `fk_participation_team_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `member` ADD CONSTRAINT `fk_member_school_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`school_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `member` ADD CONSTRAINT `fk_member_team_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `plan` ADD CONSTRAINT `fk_plan_member_1` FOREIGN KEY (`sid`) REFERENCES `member` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT;

