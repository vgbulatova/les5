/*1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.*/

update users 
set 
	created_at = current_timestamp()
where created_at is null;

update users 
set 
	updated_at = current_timestamp()
where updated_at is null;

/*2. ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ 
����� ���������� �������� � ������� 20.10.2017 8:10. ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.*/

alter table users 
	add column created_at_1 datetime, 
	add column updated_at_1 datetime;

update users
	set created_at_1 = str_to_date(created_at, '%d.%m.%Y %h:%i'),
    	updated_at_1 = str_to_date(updated_at, '%d.%m.%Y %h:%i');
   
alter table users 
	drop created_at, 
	drop updated_at, 
    rename column created_at_1 to created_at, 
	rename column updated_at_1 to updated_at;

/*3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. 
  ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. ������ ������� ������ ������ ���������� � �����, ����� ���� �������.*/

select value
from storehouses_products
order by value = 0, value;

/*4. �� ������� users ���������� ������� �������������, ���������� � ������� � ���. ������ ������ � ���� ������ ���������� �������� (may, august)*/

select *
from users
where birth_month in ('may', 'august');

/*5. �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN*/

SELECT * FROM catalogs WHERE id IN (5, 1, 2)
order by field(id, 5, 1, 2);

/*����������� ������� ������� ������������� � ������� users.*/

select avg(floor(datediff(current_date, birtdate)/365.25))
from users;

/*����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.*/
select dayname(str_to_date(concat(year(current_date),'-', month(birtdate),'-' , day(birtdate)), '%Y-%m-%d')) as day_of_week, count(*) num_of_users
from users
group by dayname(str_to_date(concat(year(current_date),'-', month(birtdate),'-' , day(birtdate)), '%Y-%m-%d'));


/*(�� �������) ����������� ������������ ����� � ������� �������.*/

select exp(sum(log(id))) from catalogs;



