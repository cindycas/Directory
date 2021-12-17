-- CRUD STATEMENTS START --------------------------------------------------------------------------------------------------------------------
use final;
set sql_safe_updates = 0;

-- countries ----------------------------------------
drop table if exists countries_bak;
create table countries_bak as
select * from countries;

SELECT * FROM countries_bak;
UPDATE countries_bak SET country_name = 'afghanistanNes' WHERE country_id = 1;
DELETE FROM countries_bak WHERE country_id = 1;

-- states --------------------------------------------------------------
drop table if exists states_bak;
create table states_bak as
select * from states;

SELECT * FROM states_bak;
UPDATE states_bak SET state_name = 'aguascalientesunn' WHERE state_id = 1;
DELETE FROM states_bak WHERE state_id = 1;

-- cities --------------------------
drop table if exists cities_bak;
create table cities_bak as
select * from cities;

SELECT * FROM cities_bak;
UPDATE cities_bak SET city_name = 'TJ' WHERE city_id = 4;
DELETE FROM cities_bak WHERE city_id = 1;

-- persons ---------------------------
drop table if exists cities_bak;
create table cities_bak as
select * from cities;

SELECT * FROM cities_bak;
UPDATE cities_bak SET city_name = 'TJ' WHERE city_id = 4;
DELETE FROM cities_bak WHERE city_id = 1;

-- roles -----------------------------
drop table if exists roles_bak;
create table roles_bak as
select * from roles;

SELECT * FROM roles_bak;
UPDATE roles_bak SET role_name = 'unknown' WHERE role_id = 2;
DELETE FROM roles_bak WHERE role_id = 1;

-- isco ---------------------------------
drop table if exists isco_bak;
create table isco_bak as
select * from isco;

SELECT * FROM isco_bak;
UPDATE isco_bak SET isco_name = 'None' WHERE isco_id = 1;
DELETE FROM isco_bak WHERE isco_id = 3;

-- person has role and isco --------------------
drop table if exists person_has_role_and_isco_bak;
create table person_has_role_and_isco_bak as
select * from person_has_role_and_isco;

SELECT * FROM person_has_role_and_isco_bak;
UPDATE person_has_role_and_isco_bak SET role_id = 22222 WHERE person_id = 4;
DELETE FROM person_has_role_and_isco_bak WHERE person_id = 1;

-- major groups ------------------------------
drop table if exists major_groups_bak;
create table major_groups_bak as
select * from major_groups;

SELECT * FROM major_groups_bak;
UPDATE major_groups_bak SET major_group_name = 'Random' WHERE major_group_id = 14;
DELETE FROM major_groups_bak WHERE major_group_id = 12;

-- submajor groups ---------------------------
drop table if exists submajor_groups_bak;
create table submajor_groups_bak as
select * from submajor_groups;

SELECT * FROM submajor_groups_bak;
UPDATE submajor_groups_bak SET submajor_group_name = 'LOL' WHERE submajor_group_id = 121;
DELETE FROM submajor_groups_bak WHERE submajor_group_id = 111;