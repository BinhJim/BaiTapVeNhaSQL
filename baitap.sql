CREATE DATABASE BaiTap;

USE BaiTap;

CREATE TABLE sub_food (
    sub_id int PRIMARY KEY AUTO_INCREMENT,
    sub_name varchar(500),
    sub_price float,
    food_id int
);

CREATE TABLE orders (
    user_id int,
    food_id int,
    amount int,
    code varchar(500),
    arr_sub_id varchar(500)
);

CREATE TABLE food (
    food_id int PRIMARY KEY AUTO_INCREMENT,
    food_name varchar(500),
    image varchar(500),
    price float,
    description float, 
    type_id int
);

CREATE TABLE food_type (
    type_id int PRIMARY KEY AUTO_INCREMENT,
    type_name varchar(500)
);

CREATE TABLE like_res (
    user_id int,
    res_id int,
    date_like datetime
);

CREATE TABLE rate_res (
    user_id int,
    res_id int,
    amount int,
    date_rate datetime
);

CREATE TABLE user (
    user_id int PRIMARY KEY AUTO_INCREMENT,
    full_name varchar(500),
    email varchar(500),
    password varchar(500)
);

CREATE TABLE restaurant (
    res_id int PRIMARY KEY AUTO_INCREMENT,
    res_name varchar(500),
    image varchar(500),
    description varchar(500)
);

ALTER TABLE food
ADD CONSTRAINT fk_type_id_food FOREIGN KEY (type_id) REFERENCES food_type(type_id);


ALTER TABLE orders
ADD CONSTRAINT fk_food_id_order FOREIGN KEY (food_id) REFERENCES food(food_id),
ADD CONSTRAINT fk_user_id_order FOREIGN KEY (user_id) REFERENCES user(user_id);


ALTER TABLE rate_res
ADD CONSTRAINT fk_res_id_rate FOREIGN KEY (res_id) REFERENCES restaurant(res_id),
ADD CONSTRAINT fk_user_id_rate FOREIGN KEY (user_id) REFERENCES user(user_id);


ALTER TABLE like_res
ADD CONSTRAINT fk_res_id_like FOREIGN KEY (res_id) REFERENCES restaurant(res_id),
ADD CONSTRAINT fk_user_id_like FOREIGN KEY (user_id) REFERENCES user(user_id);

--cau 1
SELECT user_id, COUNT(res_id) AS like_count
FROM like_res
GROUP BY user_id
ORDER BY like_count DESC
LIMIT 5;

--cau 2
SELECT res_id, COUNT(user_id) AS like_count
FROM like_res
GROUP BY res_id
ORDER BY like_count DESC
LIMIT 2;

--cau 3

SELECT user_id, COUNT(*) AS order_count
FROM orders
GROUP BY user_id
ORDER BY order_count DESC
LIMIT 1;

--cau 4

SELECT u.user_id
FROM user u
LEFT JOIN orders o ON u.user_id = o.user_id
LEFT JOIN like_res l ON u.user_id = l.user_id
LEFT JOIN rate_res r ON u.user_id = r.user_id
WHERE o.user_id IS NULL AND l.user_id IS NULL AND r.user_id IS NULL;

--cau 5
SELECT food_id, AVG(sub_price) AS avg_sub_price
FROM sub_food
GROUP BY food_id;