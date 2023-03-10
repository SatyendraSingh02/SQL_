# Case Study #2 - Pizza Runner
## Introduction
Did you know that over 115 million kilograms of pizza is consumed daily worldwide??? (Well according to Wikipedia anyway…)

Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”

Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.

He has prepared for us an entity relationship diagram of his database design but requires further assistance to clean his data and apply some basic calculations so he can better direct his runners and optimise Pizza Runner’s operations.

All datasets exist within the pizza_runner database schema - be sure to include this reference within your SQL scripts as you start exploring the data and answering the case study questions.

## Entity RelationShip Diagram
![Screenshot 2023-03-14 184745](https://user-images.githubusercontent.com/91627799/225013300-e689c519-c964-41d2-9322-33a9c4a463c2.jpg)

### Tables
<img width="577" alt="image" src="https://user-images.githubusercontent.com/91627799/225014348-c9f58286-78f0-410e-aa26-c06a681d5054.png">
<img width="614" alt="image" src="https://user-images.githubusercontent.com/91627799/225014620-05e79df9-dfef-4638-a4f8-283cb1143240.png">
<img width="610" alt="image" src="https://user-images.githubusercontent.com/91627799/225014792-4fcb70f9-a3d4-4425-a90c-b311f0a37763.png">
<img width="620" alt="image" src="https://user-images.githubusercontent.com/91627799/225014886-b1cae481-595c-48e9-a2c6-cc53b4591cb0.png">
<img width="600" alt="image" src="https://user-images.githubusercontent.com/91627799/225015056-980d07cf-6908-4b6e-af7d-9ebfa811dc92.png">

### Case Study Questions
This case study has LOTS of questions - they are broken up by area of focus including:

    *-Pizza Metrics
    *-Runner and Customer Experience
    *-Ingredient Optimisation
    *-Pricing and Ratings
    *-Bonus DML Challenges (DML = Data Manipulation Language)
    
### A. Pizza Metrics
1-How many pizzas were ordered?

2-How many unique customer orders were made?

3-How many successful orders were delivered by each runner?

4-How many of each type of pizza was delivered?

5-How many Vegetarian and Meatlovers were ordered by each customer?

6-What was the maximum number of pizzas delivered in a single order?
7-For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

8-How many pizzas were delivered that had both exclusions and extras?

9-What was the total volume of pizzas ordered for each hour of the day?

10-What was the volume of orders for each day of the week?

### B. Runner and Customer Experience

1-How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

2-What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

3-Is there any relationship between the number of pizzas and how long the order takes to prepare?

4-What was the average distance travelled for each customer?

5-What was the difference between the longest and shortest delivery times for all orders?

6-What was the average speed for each runner for each delivery and do you notice any trend for these values?

7-What is the successful delivery percentage for each runner?

### C. Ingredient Optimisation

1-What are the standard ingredients for each pizza?

2-What was the most commonly added extra?

3-What was the most common exclusion?

4-Generate an order item for each record in the customers_orders table in the format of one of the following:

    --Meat Lovers
    --Meat Lovers - Exclude Beef
    --Meat Lovers - Extra Bacon
    --Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
    
5-Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
  For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"
  
6-What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
