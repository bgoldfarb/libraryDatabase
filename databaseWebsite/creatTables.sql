use l;

CREATE TABLE LIBRARY (
ID INT NOT NULL,
Nme varchar(255) NOT NULL,
PRIMARY KEY(ID)
);


CREATE TABLE BRANCH (
	BranchID INT NOT NULL PRIMARY KEY,	
	Nme varchar(255) NOT NULL,
	PhoneNo BIGINT,
	Addrss varchar(255),
	LibraryID INT NOT NULL,
	CONSTRAINT Branch2LibID FOREIGN KEY(LibraryID) REFERENCES LIBRARY(ID)
);


CREATE TABLE MEMBER (
	MemberID INT NOT NULL PRIMARY KEY,
	Nme varchar(255) NOT NULL,
	PhoneNo BIGINT,
	Addrss varchar(255),
	Expiration date NOT NULL,
	Balance decimal NOT NULL,
	LibraryID INT NOT NULL,
	CONSTRAINT Mem2LibID FOREIGN KEY(LibraryID) REFERENCES LIBRARY(ID)
);
create index memname on MEMBER(Nme);


CREATE TABLE MEMDEP (
	MID INT NOT NULL,
	Nme varchar(255) NOT NULL,
	PRIMARY KEY (MID, Nme),
	CONSTRAINT MemDep2MID FOREIGN KEY(MID) REFERENCES MEMBER(MemberID)
);


CREATE TABLE EMPLOYEE (
	SSN INT NOT NULL PRIMARY KEY,
	Nme varchar(255) NOT NULL,
	PhoneNo BIGINT,
	Addrss varchar(255),
	Salary decimal,
	ManagerSSN INT,
	BranchID INT NOT NULL,
	Sflag Bit NOT NULL,
	SectionID INT,
	Dflag Bit NOT NULL,	
	DeptNo INT,	
	CONSTRAINT ssnChk CHECK (SSN != ManagerSSN),
	CONSTRAINT Emp2SSN FOREIGN KEY(ManagerSSN) REFERENCES EMPLOYEE(SSN),
	CONSTRAINT Emp2BranchID FOREIGN KEY(BranchID) REFERENCES BRANCH(BranchID)
);
create index empname on EMPLOYEE(Nme);


CREATE TABLE DEPARTMENT (
	BranchID INT NOT NULL,
	DeptNo INT NOT NULL,
	DeptNme varchar(255),
	ManagerSSN INT NOT NULL,
	PRIMARY KEY(BranchID, DeptNo),
	CONSTRAINT Dep2SSN FOREIGN KEY(ManagerSSN) REFERENCES EMPLOYEE(SSN),
	CONSTRAINT Dep2BranchID FOREIGN KEY(BranchID) REFERENCES BRANCH(BranchID)
);


CREATE TABLE SECTION (
	BranchID INT NOT NULL,
	SectionID INT NOT NULL,
	Nme varchar(255) NOT NULL,
	PRIMARY KEY(BranchID, SectionID),
	CONSTRAINT Sec2BranchID FOREIGN KEY(BranchID) REFERENCES BRANCH(BranchID)
);


CREATE TABLE EMPDEP (
	ESSN INT NOT NULL,
	Nme varchar(255) NOT NULL,
	PRIMARY KEY(ESSN, Nme),
	CONSTRAINT EmpDep2SSN FOREIGN KEY(ESSN) REFERENCES EMPLOYEE(SSN)
);


CREATE TABLE PUBLISHER (
	PubID INT NOT NULL PRIMARY KEY,
	Nme varchar(255) NOT NULL,
	PhoneNo BIGINT,
	Addrss varchar(255)
);


CREATE TABLE ITEM (
	ItemID INT NOT NULL PRIMARY KEY,
	Book BIT NOT NULL,
	Audiobook BIT NOT NULL,
	Movie BIT NOT NULL,
	Music BIT NOT NULL,
	Game BIT NOT NULL	
);


CREATE TABLE BOOK (
	BookID INT NOT NULL PRIMARY KEY,
	Title varchar(255) NOT NULL,
	Author varchar(255),
	PubID INT,
	Pages INT,
	Descr TEXT,
	CONSTRAINT Book2PubID FOREIGN KEY(PubID) REFERENCES PUBLISHER(PubID),
	CONSTRAINT Book2ItemID FOREIGN KEY(BookID) REFERENCES ITEM(ItemID)
);
CREATE INDEX index_bookname
ON Book (Title);


CREATE TABLE AUDIOBOOK (
	ABID INT NOT NULL PRIMARY KEY,
	Title varchar(255) NOT NULL,
	Author varchar(255),
	PubID INT,
	RunTime INT,
	Descr TEXT,
	CONSTRAINT Audiobook2PubID FOREIGN KEY(PubID) REFERENCES PUBLISHER(PubID),
	CONSTRAINT Audiobook2ItemID FOREIGN KEY(ABID) REFERENCES ITEM(ItemID)
);
CREATE INDEX index_audiobooktitle
ON Audiobook (Title);


CREATE TABLE MOVIE (
	MovieID INT NOT NULL PRIMARY KEY,
	Title varchar(255) NOT NULL,
	Director varchar(255),
	PubID INT,
	RunTime INT,
	Descr TEXT,
	CONSTRAINT Movie2PubID FOREIGN KEY(PubID) REFERENCES PUBLISHER(PubID),
	CONSTRAINT Movie2ItemID FOREIGN KEY(MovieID) REFERENCES ITEM(ItemID)
);
CREATE INDEX index_movietitle
ON Movie (Title);


CREATE TABLE MUSIC (
	MusicID INT NOT NULL PRIMARY KEY,
	Title varchar(255) NOT NULL,
	Artist varchar(255),
	PubID INT,
	TrackCount INT,
	Descr TEXT,
	CONSTRAINT Music2PubID FOREIGN KEY(PubID) REFERENCES PUBLISHER(PubID),
	CONSTRAINT Music2ItemID FOREIGN KEY(MusicID) REFERENCES ITEM(ItemID)
);
CREATE INDEX index_musictitle
ON Music (Title);


CREATE TABLE GAME (
	GameID INT NOT NULL PRIMARY KEY,
	Title varchar(255) NOT NULL,
	Developer varchar(255),
	PubID INT,
	Rating char,
	Descr TEXT,
	CONSTRAINT Game2PubID FOREIGN KEY(PubID) REFERENCES PUBLISHER(PubID),
	CONSTRAINT Game2ItemID FOREIGN KEY(GameID) REFERENCES ITEM(ItemID)
);
CREATE INDEX index_gametitle
ON Game (Title);


CREATE TABLE CPY (
	ItemID INT NOT NULL,
	CopyID INT NOT NULL PRIMARY KEY,
	BranchID INT NOT NULL,
	PurchaseDate date,
	CONSTRAINT Copy2BranchID FOREIGN KEY(BranchID) REFERENCES BRANCH(BranchID),
	CONSTRAINT Copy2ItemID FOREIGN KEY(ItemID) REFERENCES ITEM(ItemID)
);


CREATE TABLE CURSTATUS (
	CopyID INT NOT NULL PRIMARY KEY,
	DateOut date,
	DateIn date,
	LastMID INT,
	DateDue date,	
	CONSTRAINT Status2MemID FOREIGN KEY(LastMID) REFERENCES MEMBER(MemberID),
	CONSTRAINT Status2CopyID FOREIGN KEY(CopyID) REFERENCES CPY(CopyID)
);


CREATE TABLE CHECKAUDIT (	
	Occurance date,
	Member int,
	Item int,
	CheckIn bit,
	CheckOut bit
);




INSERT INTO LIBRARY VALUES
(1000, 'Not Bad Library LLC'),
(1001, 'Not Great Library LLC');


INSERT INTO BRANCH VALUES
(565, 'North Branch', 6142443232, '100 Not That Bad Lane', 1000),
(566, 'South Branch', 6142453332, '100 Not That Great Lane', 1001),
(567, 'West Branch', 6142443232, '100 Good Enough Lane', 1000);


INSERT INTO MEMBER VALUES
(12345, 'Brian Goldfarb', 7326543432, '3 Awesome Drive', '2017-09-10', 0, 1000),	
(12245, 'Chance Lytle', 7324323432, '1 Awesome Drive', '2017-04-10', 500, 1001),
(22245, 'Alice Smith', 7321113432, '5 China Court', '2017-02-10', 1000, 1000),
(12395, 'Krish Krishnasamy', 7326443432, '96 Awesome Drive', '2017-09-10', 0, 1000);
 

INSERT INTO MEMDEP VALUES
(12345, 'John'),
(12345, 'Rupert'),
(12345, 'Molly'),
(22245, 'Brett'),
(12245, 'Apple');


INSERT INTO EMPLOYEE VALUES
(043221202, 'Denzel Washington', 6142991295, '123 Washington Court', 100000, NULL, 565, 1, 11, 0, NULL),
(030203028, 'George Washington', 614291294, '143 Washington Court', 50000, 043221202, 566, 1, 20, 0, NULL),
(123495320, 'George Carver', 6142990294, '103 Washington Court', 65000, NULL, 567, 0, NULL, 1, 2),
(239394024, 'Irving Washington', 6142991949, '101 Washington Court', 65000, 123495320, 567, 0, NULL, 1, 11),
(394999492, 'Mat Damon', 6142991234, '104 Washington Court', 55000, NULL, 565, 1, 31, 0, NULL),
(349394939, 'Mail Daemon', 6142931249, '140 Washington Court', 12, 394999492, 567,1, 10, 0, NULL),
(231924929, 'Chuck Norris', 61429912949, '110 Washington Court', 1000000, NULL, 565,1, 1, 0, NULL),
(194912484, 'Paper Mache', 6142991194, '140 Washington Court', 45000, 231924929, 567,0, NULL, 1, 13),
(194192490, 'Jacket Twins', 6142391294, '103 Washington Court', 65000, NULL, 567,1, 23, 0, NULL),
(194912040, 'Lib Simmons', 6141991294, '110 Washington Court', 7, 194192490, 567, 1, 2, 0, NULL);


INSERT INTO DEPARTMENT VALUES
(565, 1, 'Management', 043221202),
(565, 10, 'Cleaning', 043221202),
(567, 2, 'Fundraising', 043221202),
(567, 11, 'IT', 043221202),
(566, 8, 'Lunch Staff', 043221202),
(567, 13, 'Marketing', 043221202);


INSERT INTO SECTION VALUES
(565, 1, 'Horror'),
(566, 7, 'Advanced Pickle Criticism'),
(567, 2, 'Criterion Collection'),
(567, 10, 'Self-Help'),
(565, 11, 'Thriller'),
(566, 20, 'Classical'),
(567, 23, 'Platformer'),
(566, 26, 'Shooter'),
(565, 31, 'Alternative'),
(567, 35, 'Educational');


INSERT INTO EMPDEP VALUES
(043221202, 'Gertrud'),
(239394024, 'Juan Carlos'),
(194192490, 'DGeorge'),
(194912484, 'Jimbo'),
(194912484, 'Bilbo');


INSERT INTO PUBLISHER VALUES
(1, 'Known Abode', 5555555555, 'Suite 67 665 Houston Street'),
(2, 'Tilde Studios', 9999999999, '23 Buena Vista Club Drive'),
(5, 'Big Games', 7777777777, '4 Lain Lane'),
(6, 'Hummmble Sounds', 88888888, '122 E North Ranch Blvd');


INSERT INTO ITEM VALUES
(880, 1, 0, 0, 0, 0),
(841, 1, 0, 0, 0, 0),
(122, 0, 1, 0, 0, 0),
(999, 0, 1, 0, 0, 0),
(67, 0, 0, 1, 0, 0),
(889, 0, 0, 1, 0, 0),
(42, 0, 0, 0, 1, 0),
(779, 0, 0, 0, 1, 0),
(790, 0, 0, 0, 0, 1),
(63, 0, 0, 0, 0, 1);


INSERT INTO MOVIE VALUES
(67, 'When Angels Had Wings', 'Alan Smithee', 2, 160, 'A movie about lost loves during the 1647 Congolese War'),
(889, 'Hard-Boiled Eggs', 'Herman Gorky', 2, 70, 'Unfinished pilot episode about two scrambled detectives on the hunt for an evil cannibal');


INSERT INTO GAME VALUES
(790, 'Super Metal Star', 'Small Games', 5, 'T', 'A vertical shooter set in space'),
(63, 'Bigsbys Adventure 6', 'Smaller Games', 5, 'M', 'The cult classic returns');


INSERT INTO MUSIC VALUES
(42, 'Dulcet Database Dirges', 'Mozart', 6, 88, 'Enter a world of mystery as the recently revived-from-the-dead composer is forced to compose more sounds for the modern age'),
(779, 'Modern Vietnam', 'Hands', 6, 45, 'The newest hit from the smash hit band HANDS featuring the single "You Brought Flowers, I Brought Napalm".');


INSERT INTO AUDIOBOOK VALUES
(122, 'How To Live Without Lice', 'Dr. Dougan McUldog', 1, 66, 'An anecdotal collection of essays regarding the esteemed doctors multiple encounters with vampiric parasites.'),
(999, 'The Hidden Lives of Foreign Keys', 'Edward VanBalcony', 1, 9786, 'The complete and total walkthrough of what your foreign keys are doing when youre not watching');


INSERT INTO BOOK VALUES
(880, 'C@rn', 'Michelle Wilson', 1, 255, 'Looking at corn in the digital age.'),
(841, 'Colonel Sanders: An Oral History', 'Colonel Sanders', 1, 30, 'The quintessential American dream in book form.');


INSERT INTO CPY VALUES 
(67, 100, 566, '2013-05-03'),
(790, 120, 567, '2016-04-09'),
(42, 130, 565, '2016-10-03'),
(122, 140, 565, '2016-09-03'),
(841, 199, 567, '2016-09-03');


INSERT INTO CURSTATUS VALUES	
(100, '2017-02-21', '2017-01-19', 12345, '2017-03-01'),
(120, '2017-02-14', '2017-01-01', 22245, '2017-03-15'),
(130, '2017-02-14', '2017-01-24', 12245, '2017-01-25'),
(140, '2017-02-25', '2017-02-25', 12245, '2017-02-26'),
(199, '2000-01-01', '2000-01-01', NULL, '2000-01-01');



