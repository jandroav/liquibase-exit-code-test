--liquibase formatted sql

--changeset jbennett:1 labels:release-1.0.0
CREATE TABLE ORGANIZATIONS (
    ID INT PRIMARY KEY NOT NULL,
    NAME VARCHAR(200),
    INDUSTRY VARCHAR(400),
    EMPLOYEE_COUNT INT
);
--rollback DROP TABLE ORGANIZATIONS;

--changeset jbennett:2 labels:release-1.1.0
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (1, 'Acme Corporation', 'Explosives', 1);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (2, 'Initech', 'Y2K', 50);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (3, 'Umbrella Corporation', 'Zombies', 10000);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (4, 'Soylent Corp', 'People', 100);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (5, 'Globex Corp', 'Widgets', 5000);
--rollback DELETE FROM ORGANIZATIONS WHERE ID BETWEEN 1 AND 5;

--changeset jbennett:3 labels:release-1.2.0
CREATE TABLE ADDRESSES (
    ID INT PRIMARY KEY NOT NULL,
    ADDRESS_LINE_1 VARCHAR(500),
    CITY VARCHAR(200),
    STATE VARCHAR(3),
    ZIP_CODE VARCHAR(9),
    ORG_ID INT
);
--rollback DROP TABLE ADDRESSES;

--changeset jbennett:4 labels:release-1.2.0
ALTER TABLE ADDRESSES
    ADD CONSTRAINT ORG_FK1
    FOREIGN KEY (ORG_ID)
    REFERENCES ORGANIZATIONS(ID);
--rollback ALTER TABLE ADDRESSES DROP CONSTRAINT ORG_FK1;

--changeset jbennett:5 labels:release-1.3.0
CREATE TABLE EMPLOYEES (
    ID INT PRIMARY KEY NOT NULL,
    FIRST_NAME VARCHAR(200),
    LAST_NAME VARCHAR(200),
    DATE_OF_BIRTH DATE,
    ORG_ID INT
);
--rollback DROP TABLE EMPLOYEES;

--changeset jbennett:6 labels:release-1.3.0
ALTER TABLE EMPLOYEES
    ADD CONSTRAINT ORG_FK2
    FOREIGN KEY (ORG_ID)
    REFERENCES ORGANIZATIONS(ID);
--rollback ALTER TABLE EMPLOYEES DROP CONSTRAINT ORG_FK2;

-- --changeset jbennett:7 labels:release-1.3.0
-- DELETE FROM ORGANIZATIONS;
-- --rollback empty

--changeset jbennett:8 labels:release-1.4.0 --splitStatements:false --runOnChange:true
CREATE OR REPLACE FUNCTION get_employees_by_org(p_org_id integer)
RETURNS TABLE (
    id integer,
    first_name varchar,
    last_name varchar,
    date_of_birth date
) AS $$
BEGIN
    RETURN QUERY
    SELECT e.id, e.first_name, e.last_name, e.date_of_birth
    FROM employees e
    WHERE e.org_id = p_org_id;
END;
$$ LANGUAGE plpgsql;
--rollback DROP FUNCTION IF EXISTS get_employees_by_org(integer);