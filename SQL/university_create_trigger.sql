SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `university`
--

USE `university2`;

-- --------------------------------------------------------

--
-- Triggers `course`
--
DROP TRIGGER IF EXISTS `onDeleteCourse`;
DELIMITER $$
CREATE TRIGGER `onDeleteCourse` BEFORE DELETE ON `course` FOR EACH ROW BEGIN
DELETE FROM course_registration WHERE course_registration.cid = OLD.cid;
DELETE FROM teaches WHERE teaches.cid = OLD.cid;
DELETE FROM session WHERE session.cid = OLD.cid;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Triggers `course_registration`
--
DROP TRIGGER IF EXISTS `onInsertCourseRegistration`;
DELIMITER $$
CREATE TRIGGER `onInsertCourseRegistration` BEFORE INSERT ON `course_registration` FOR EACH ROW IF (SELECT COUNT(*) FROM student s, course c WHERE s.stid=NEW.stid AND c.cid=NEW.cid ) < 0
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'either student or course not found';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Triggers `session`
--
DROP TRIGGER IF EXISTS `onDeleteSession`;
DELIMITER $$
CREATE TRIGGER `onDeleteSession` BEFORE DELETE ON `session` FOR EACH ROW DELETE FROM attendance WHERE attendance.sid = OLD.sid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Triggers `student`
--
DROP TRIGGER IF EXISTS `onDeleteStudent`;
DELIMITER $$
CREATE TRIGGER `onDeleteStudent` BEFORE DELETE ON `student` FOR EACH ROW BEGIN
DELETE FROM course_registration WHERE stid = OLD.stid;
DELETE FROM attendance WHERE attender_id = OLD.stid;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `onInsertStudent`;
DELIMITER $$
CREATE TRIGGER `onInsertStudent` BEFORE INSERT ON `student` FOR EACH ROW BEGIN
IF (SELECT COUNT(stid) FROM student) = 0
THEN
SET New.snum = 1;
SET NEW.stid = 1;
ELSE
SET New.snum=(SELECT MAX(stid) FROM student)+1;
SET New.stid=(SELECT MAX(stid) FROM student)+1;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Triggers `teacher`
--
DROP TRIGGER IF EXISTS `onDeleteTeacher`;
DELIMITER $$
CREATE TRIGGER `onDeleteTeacher` BEFORE DELETE ON `teacher` FOR EACH ROW BEGIN
DELETE FROM teaches WHERE teaches.tid = OLD.tid;
DELETE FROM session WHERE session.tid = OLD.tid;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `onInsertTeacher`;
DELIMITER $$
CREATE TRIGGER `onInsertTeacher` BEFORE INSERT ON `teacher` FOR EACH ROW BEGIN
IF (SELECT COUNT(tid) FROM teacher) = 0
THEN
SET New.tnum = 1;
SET NEW.tid = 1;
ELSE
SET New.tnum=(SELECT MAX(tid) FROM teacher)+1;
SET New.tid=(SELECT MAX(tid) FROM teacher)+1;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Triggers `room`
--
DROP TRIGGER IF EXISTS `onDeleteRoom`;
DELIMITER $$
CREATE TRIGGER `onDeleteRoom` BEFORE DELETE ON `room` FOR EACH ROW BEGIN
DELETE FROM session WHERE rid=OLD.rid;
END
$$
DELIMITER ;

-- --------------------------------------------------------

COMMIT;