# SQL_chalenge

Desafio de código em processo seletivo




## Initial Instructions

Accessing the BigQuery Sandbox
Go to: https://console.cloud.google.com/bigquery

Log into your Google account\
Select country and agree to the ToS\
Create a project\
Select `Add data`, `pin a project`, `enter a project name`, and enter `bigquery-public-data`\
We are interested in the `thelook_ecommerce` data set

Take 5-10 minutes getting familiar with the data in this schema, and the Google BigQuery UI.
This is how you select data from this set:

SELECT
  *
 
FROM
  `bigquery-public-data.thelook_ecommerce.events`
 
LIMIT 100;

As you go through these questions, note down any assumptions you are making about the data, or any questions you might want to go back to the stakeholder or engineering team to get further clarification on.
Do not let these assumptions or questions stop you from attempting the exercise.


---
## Question 1
Write a query that returns users' names, email addresses, states, and their percentage of cancelled orders as a proportion of their overall orders.

---
## Question 2
Write a query that returns our top 100 most popular products by number sold (excluding cancelled and returned orders), along with how much money they made (products.retail_price), how many unique users purchased that item, and of those users who purchased that item what percentage were women.

---
## Question 3
The `events` table contains a record of a user's activity on our website.  Let's call a user's FIRST (chronologically by events.created_at) traffic source their `acquisition_channel`.
Write a query that returns our acquisition_channels, how many users we have acquired through that channel, how many orders have been made from users with that acquisition channel, our overall revenue from users acquired by that channel, and the percentage of overall revenue that channel has been responsible for.


For this exercise, we are only interested in users acquired in 2021.
