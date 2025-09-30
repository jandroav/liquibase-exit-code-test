-- liquibase formatted sql

-- changeset JBennett:1753728799059-1 labels:"jira-1234" splitStatements:false
ALTER TABLE "employees" ADD "ssn" INTEGER;

-- changeset JBennett:1753728799059-2 labels:"jira-1234" splitStatements:false
CREATE OR REPLACE PROCEDURE public.birthdaysort()
 LANGUAGE plpgsql
AS $procedure$
BEGIN 
    SELECT employees.last_name as LastName, employees.date_of_birth as BirthDay
    FROM employees
    ORDER BY employees.date_of_birth ASC;
END; $procedure$;

