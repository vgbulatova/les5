/*1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.*/

update users 
set 
	created_at = current_timestamp()
where created_at is null;

update users 
set 
	updated_at = current_timestamp()
where updated_at is null;

/*2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое 
время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.*/

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

/*3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
  Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.*/

select value
from storehouses_products
order by value = 0, value;

/*4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)*/

select *
from users
where birth_month in ('may', 'august');

/*5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN*/

SELECT * FROM catalogs WHERE id IN (5, 1, 2)
order by field(id, 5, 1, 2);

/*Подсчитайте средний возраст пользователей в таблице users.*/

select avg(floor(datediff(current_date, birtdate)/365.25))
from users;

/*Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/
select dayname(str_to_date(concat(year(current_date),'-', month(birtdate),'-' , day(birtdate)), '%Y-%m-%d')) as day_of_week, count(*) num_of_users
from users
group by dayname(str_to_date(concat(year(current_date),'-', month(birtdate),'-' , day(birtdate)), '%Y-%m-%d'));


/*(по желанию) Подсчитайте произведение чисел в столбце таблицы.*/

select exp(sum(log(id))) from catalogs;



