use l;

SELECT SSN, Nme 
FROM EMPLOYEE 
WHERE SSN IN (SELECT ESSN FROM EMPDEP)
UNION
SELECT SSN, Nme 
FROM EMPLOYEE 
WHERE SSN IN (SELECT ManagerSSN FROM EMPLOYEE);

SELECT SSN, Nme 
FROM EMPLOYEE 
WHERE SSN IN (SELECT ESSN FROM EMPDEP) AND
SSN IN(
SELECT SSN 
FROM EMPLOYEE 
WHERE SSN IN (SELECT ManagerSSN FROM EMPLOYEE));


SELECT SSN, Nme
FROM EMPLOYEE
WHERE Salary > 7000 AND
SSN NOT IN(
SELECT SSN 
FROM EMPLOYEE 
WHERE SSN IN (SELECT ManagerSSN FROM EMPLOYEE));

SELECT p.PubID, p.Nme
FROM PUBLISHER as p
WHERE NOT EXISTS (SELECT * FROM GAME as g WHERE g.PubID != p.PubID);

SELECT b.ID, b.Nme, COUNT(m.MemberID) as mem_count 
FROM LIBRARY AS b, MEMBER AS m
WHERE b.ID = m.LibraryID
GROUP BY b.ID, b.Nme;

SELECT b.BranchID, b.Nme as BranchName, e.SSN as EmpSSN, e.Nme as EmpName, e.Dflag as InDepartment, e.Sflag as InSection, d.DeptNo as DeptOrSectNum, d.DeptNme as DeptOrSectName
FROM BRANCH as b, EMPLOYEE as e, DEPARTMENT as d
WHERE b.BranchID = e.BranchID AND e.DeptNo = d.DeptNo AND e.BranchID = d.BranchID
UNION
SELECT bb.BranchID, bb.Nme as BranchName, ee.SSN as EmpSSN, ee.Nme as EmpName, ee.Dflag as InDepartment, ee.Sflag as InSection, ss.SectionID as DeptOrSectNum, ss.Nme as DeptOrSectName
FROM BRANCH as bb, EMPLOYEE as ee, SECTION as ss
WHERE bb.BranchID = ee.BranchID AND ee.SectionID = ss.SectionID AND ee.BranchID = ss.BranchID;


SELECT CopyID, MemberID as LastHolderID, Nme as LastHolderName
FROM MEMBER as m
RIGHT OUTER JOIN CURSTATUS c ON m.MemberID=c.LastMID;