use fastassignment;

select * from user;

RoleID 
1 - Customer
2 - RIDER
3 - MANAGER
4 - EMPLOYEE
 

-- Customer Data
INSERT INTO `fastassignment`.`user`
 (`id`,`name`, `role_id`, `created_at` , `created_by`, `login`, `password`, `is_active`, `gender`, `identification`, `city_id`, dob , `region_id`) 
VALUES (17, 'Babar', 1, now() , 1, '+928180000010', 'ARRRP123', b'1', '1', '42301-15276198', '1','1999-12-31' ,'1');

select * from address;

INSERT INTO `fastassignment`.`address` (`id`,`user_id`, `location_name`, `address`, `latitude`, `longitude`, `is_active`, `address_constant`, `unit_no`, `building_name`, `created_at`, `created_by`) 
VALUES (8,'17', 'Jhangir town', 'house # 17', '39.5452352', '69.6526252', b'1', '1', '10', 'Zubair Manzil', now(), '17');

-- INSERT INTO `fastassignment`.`address` 
-- (`location_name`, `address`, `latitude`, `longitude`, `is_active`,  `created_at`) 
-- VALUES ( 'Tariq road  ', 'Pechs', '33.5452542', '68.6526252', b'1', now());


SELECT * FROM branch;

INSERT INTO `fastassignment`.`branch` (`name`, `address_id`, `status`, `lat`, `lon`, `created_at` , `preparation_time`) 
VALUES ('Tariq Road Branch', '2', '1', '33.5452542', '68.6526252', now(), '30');

select * from product ;

INSERT INTO `fastassignment`.`product` (`name`, `created_at`, `sku`, `is_active`, `product_description`, `visibility`, `original_price`, `discounted_price`, `is_last_minute_buy`)
 VALUES ('Cold Drink', '2022-12-01 23:49:20', 'ITM-11123', b'1', 'Cold Storm', 'No', '170', '129', b'1');



SELECT * FROM `order_item`;

INSERT INTO `fastassignment`.`order_item` (`created_at`, `created_by`, `actual_quantity`, `price`, `order_id`, `product_id`, `is_active`)
 VALUES ('2022-12-05 22:08:45', '8', 1, '1100', 5, 4, b'1');

SELECT * FROM `order`;

-- channel_type:
-- 1- delivery, 2- takaway, 3- dine_in

INSERT INTO `fastassignment`.`order` (`created_at`, `created_by`, `reference_id`, `status`, `channel_type`, `customer_id`, `branch_id`, `address_id`, `sub_total`, `total`, `contact_person_name`, `contact_person_phone`, `order_source`, `payment_type`) 
VALUES (now(), '7', 'px34za', '1', '1', '1', '1', '2', '950', '1000', 'Akbar', '+923030243434', 'WEB', '1'),
('2022-12-01 22:08:45', '7', 'px35za', '1', '1', '2', '1', '2', '3200', '3300', 'Babar', '+923330243435', 'Android', '1'),
('2022-12-02 22:08:45', '10', 'px36za', '1', '1', '17', '1', '2', '3370', '3400', 'Humayun', '+923230243436', 'Android', '1'),
('2022-12-04 22:08:45', '9', 'px37za', '1', '1', '13', '1', '2', '1350', '1400', 'Jehangir', '+923330243437', 'Android', '1'),
('2022-12-05 22:08:45', '8', 'px38za', '1', '1', '1', '1', '2', '2850', '3000', 'Aurangzeb', '+923130243438', 'IOS', '1');


select * from rider_detail;

INSERT INTO `fastassignment`.`rider_detail` (`user_id`, `status`, `created_at`)
 VALUES ('4', '3', now()),('5', '3', '2022-12-01 22:08:45'),('6', '3', '2022-10-01 23:18:35');
 
 SELECT * FROM order_batch;
 
 
 INSERT INTO `fastassignment`.`order_batch` (`created_at`, `batch_name`, `batch_date`, `rider_id`, `status`)
 VALUES ('2022-12-01 22:08:45', 'Order_Tariq_Road_01', '2022-12-01 22:08:45', '3', '1');

 
 -- REPORTING QUERIES
 
// No of orders per day according to the order source (WEB,ANDROID,IOS)
Select created_at , count(1) as "No of Orders" , order_source from `order`
Group By created_at , order_source

// TOP PRODUCT SELL IN LAST TWO WEEKS.

Select p.id , p.name , SUM(o.actual_quantity) as "No of sold item"  from order_item o
inner join product p
on p.id = o.product_id
WHERE o.created_at Between '2022-11-20 00:00:00' AND '2022-12-05 23:59:00'
group by o.product_id
order by SUM(o.actual_quantity) desc
LIMIT 1


// TOP CUSTOMERS
SELECT U.id , U.name , U.login , COUNT(1) AS "No of Orders"
FROM `order` O 
INNER JOIN user U ON U.id = O.customer_id
GROUP BY o.customer_id
ORDER BY COUNT(1) DESC
LIMIT 1

// TOP RIDERS ACC TO THE RATINGS
SELECT U.id , U.name , U.login 
FROM `order` O 
INNER JOIN user U ON U.id = O.rider_id
GROUP BY o.rider_id
ORDER BY SUM(rating) DESC
LIMIT 1

// TOP  CITITES ACC TO THE NO OF ORDERS

// TOP  BRANCH ACC TO THE NO OF ORDER
