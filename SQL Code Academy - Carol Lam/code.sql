 --Question/Task 1 Answer: Question, User_ID, Response--
 SELECT *
 FROM survey
 LIMIT 10; 
 
 --Question/Task 2: What is the number of responses for each question?--
 SELECT question, 
 		COUNT(DISTINCT user_id)
 FROM survey
 GROUP BY question;
 
 --Question/Task 3: Which question(s) of the quiz have a lower completion rate? What do you think is the reason?-- 
 -- 1. 500/500 = 100%--
 -- 1. 475/500 = 95%--
 -- 1. 380/475 = 80%--
 -- 1. 361/380 = 95%--
 -- 1. 270/361 = 75%--
 
 --Question/Task 4 Answer: What are the column names?--
 --Answer: QUIZ- User_id, style, fit shape, color
 --Answer: Home_Try_On - user_id, number_of_pairs, address
 --Answer: Purchase - user_id, product_id, style, model_name, color
 SELECT *
 FROM quiz
 LIMIT 5; 
 
 SELECT *
 FROM home_try_on
 LIMIT 5; 
 
 SELECT *
 FROM purchase
 LIMIT 5; 
 
 -- Question/Task 5 Create a new table with the following columns: user_id, is_home_try_on, number_of_pairs, and is_purchase. 
 --Answer --
 SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase' 
 FROM quiz q 
 LEFT JOIN home_try_on h
 		ON q.user_id = h.user_id
 LEFT JOIN purchase p
  	ON p.user_id = q.user_id
 ORDER BY is_home_try_on DESC, number_of_pairs DESC, is_purchase DESC 
 LIMIT 10;
 
 --Question/Task 6 Answer --
 -- Conversion Rates -- 
 With funnels AS ( SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase' 
 FROM quiz q 
 LEFT JOIN home_try_on h
 		ON q.user_id = h.user_id
 LEFT JOIN purchase p
  	ON p.user_id = q.user_id)
SELECT COUNT (*) AS 'Total Users', SUM(is_home_try_on) AS 'Trials', 
SUM(is_purchase) AS 'Purchases', 
100. * SUM(is_home_try_on) / COUNT(user_id) AS 'Tried Frames (%)',
100. * SUM(is_purchase) / SUM(is_home_try_on) AS 'Purchase after Trial (%)'
FROM funnels;

-- Conversion Rates -- 
 With funnels AS ( SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase' 
 FROM quiz q 
 LEFT JOIN home_try_on h
 		ON q.user_id = h.user_id
 LEFT JOIN purchase p
  	ON p.user_id = q.user_id)
SELECT COUNT (*) AS 'Total Users', SUM(is_home_try_on) AS 'Trials', 
SUM(is_purchase) AS 'Purchases', number_of_pairs
FROM funnels
GROUP BY number_of_pairs;

--Question/Task 6 Answer --
SELECT question, response, 
 		COUNT(response) AS "Number of Users"
 FROM survey
 GROUP BY response
 ORDER BY question;

SELECT product_id, model_name, color, style, count(user_id) AS "Units Purchased", price as "Price/Unit", sum(price) AS "Gross Sales"
FROM purchase
GROUP BY product_id
ORDER BY product_id;

SELECT style, count(user_id)
FROM quiz
GROUP BY style
LIMIT 10; 

SELECT fit, count(user_id)
FROM quiz
GROUP BY fit
LIMIT 10; 

SELECT shape, count(user_id)
FROM quiz
GROUP BY shape
LIMIT 10; 

SELECT color, count(user_id)
FROM quiz
GROUP BY shape
LIMIT 10; 