# ecommerceDatabase
Design files and SQL implementation for practice ecommerce database project

For this assignment, you will design the DB for an Online Marketplace for a company you choose the name of. You will work on this project as a pair.

The DB should be able to track products, current inventory, transactions, reviews for products, and users who have signed up for an account on our website.

## Design

Go through the Analysis (collect and analyze requirements) and Logical modeling (implement ERD of entities, relationships, and attributes), and normalization phases of your DB design (part of Logical modeling).

In the future, you will need to answer questions from this DB like:

List which products we currently have in inventory
Create new products
Modify the amount of a particular product that we have in inventory
Delete a product from inventory
Get a list of the most popular products for a given time range
Get a list of the least popular products for a given time range
Get a list of users who haven't purchased something in a few months to send promotional emails to
This should also include products that these users normally purchase


Required/Suggested items:

Have a minimum of 6 entities
Crows feet notation must be used
Cardinality must be defined, including relationship and attributes minimums and maximums.
Unique values should be indicated for Attributes.
Include documentation explaining which entities are Strong and which entities are Weak. Do not replace your crows feet notation with the diamond notation. Also, if you have any Supertype and Subtype entities, explain these in the documentation. I would like to see at least one supertype/subtype relationship.
Alternative option to documentation is to create a separate ER diagram with the diamond notation and supertype/subtype entities format.

## Implementation
You will modify your data model design to normalize your database into Boyce-Codd NF from the Design phase and then implement it. While you are not required to create a new diagram for the database design, it would be helpful if you did, especially with many-to-many relationships.

For each normalized relation write a SQL CREATE TABLE statement. Your tables should implement the PRIMARY KEY and FOREIGN KEY constraints of your normalized design. You should also insert some data into each table. The amount of data should be such that the need for the database is clear. In other words, provide enough examples to demonstrate why a database was required in the first place

Be sure your database can be used to complete the tasks set out in the design phase.

Be careful and consider what constraints may need to be put in place to ensure referential integrity.
