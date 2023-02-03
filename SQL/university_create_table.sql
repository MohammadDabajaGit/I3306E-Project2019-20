
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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `pass` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
CREATE TABLE IF NOT EXISTS `student` (
  `stid` int(11) NOT NULL AUTO_INCREMENT,
  `snum` varchar(6) COLLATE utf8_bin NOT NULL,
  `sname` varchar(50) COLLATE utf8_bin NOT NULL,
  `pass` char(32) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`stid`),
  UNIQUE KEY `snum` (`snum`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
CREATE TABLE IF NOT EXISTS `teacher` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `tnum` varchar(6) COLLATE utf8_bin NOT NULL,
  `tname` varchar(50) COLLATE utf8_bin NOT NULL,
  `pass` char(32) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`tid`),
  UNIQUE KEY `tnum` (`tnum`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
CREATE TABLE IF NOT EXISTS `course` (
  `cid` varchar(6) COLLATE utf8_bin NOT NULL,
  `cnum` varchar(6) COLLATE utf8_bin NOT NULL,
  `cname` varchar(50) COLLATE utf8_bin NOT NULL,
  `description` varchar(1024) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cnum` (`cnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `rname` varchar(50) COLLATE utf8_bin NOT NULL,
  `capacity` int(11) NOT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `course_registration`
--

DROP TABLE IF EXISTS `course_registration`;
CREATE TABLE IF NOT EXISTS `course_registration` (
  `stid` int(11) NOT NULL,
  `cid` varchar(6) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`cid`,`stid`) USING BTREE,
  KEY `stid` (`stid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `course_registration`
  ADD CONSTRAINT `course_registration_ibfk_2` FOREIGN KEY (`stid`) REFERENCES `student` (`stid`),
  ADD CONSTRAINT `course_registration_ibfk_3` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`);

-- --------------------------------------------------------

--
-- Table structure for table `teaches`
--

DROP TABLE IF EXISTS `teaches`;
CREATE TABLE IF NOT EXISTS `teaches` (
  `cid` varchar(6) COLLATE utf8_bin NOT NULL,
  `tid` int(11) NOT NULL,
  PRIMARY KEY (`cid`,`tid`),
  KEY `tid` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `teaches`
  ADD CONSTRAINT `teaches_ibfk_3` FOREIGN KEY (`tid`) REFERENCES `teacher` (`tid`),
  ADD CONSTRAINT `teaches_ibfk_4` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`);

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
CREATE TABLE IF NOT EXISTS `session` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `sname` varchar(50) COLLATE utf8_bin NOT NULL,
  `cid` varchar(6) COLLATE utf8_bin NOT NULL,
  `date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` varchar(1024) COLLATE utf8_bin DEFAULT NULL,
  `rid` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  PRIMARY KEY (`sid`),
  KEY `rid` (`rid`),
  KEY `tid` (`tid`),
  KEY `cid` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `session`
  ADD CONSTRAINT `session_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `room` (`rid`),
  ADD CONSTRAINT `session_ibfk_3` FOREIGN KEY (`tid`) REFERENCES `teacher` (`tid`),
  ADD CONSTRAINT `session_ibfk_4` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`);

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
CREATE TABLE IF NOT EXISTS `attendance` (
  `attid` int(11) NOT NULL AUTO_INCREMENT,
  `attender_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `attended_from` datetime DEFAULT NULL,
  `attended_to` datetime DEFAULT NULL,
  PRIMARY KEY (`attid`),
  KEY `sid` (`sid`),
  KEY `attender_id` (`attender_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `session` (`sid`),
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`attender_id`) REFERENCES `student` (`stid`);

-- --------------------------------------------------------

COMMIT;

