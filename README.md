# The Dragon's Hoard: Ecommerce SQL Database

## Running the database
1. Run the file "ecommerce_createtables.sql"
2. Run the file "ecommerce_insertdata.sql"
3. Run the file "ecommerce_proceduresandtriggers.sql"
4. View images/diagrams/glossary as desired
5. Run Main to view the menu and choose options to manipulate the database. You may need to:
   - Install Connector/J: File > Project Structure > Modules > Dependencies > Add (+) > mysql-connector-j-8.4.0.jar
   - Set user (root) and password (same as Workbench) at the top of Main (conn)

## Summary
For this project, I worked with [Ken](https://github.com/KenCage1007) to design and implement a relational SQL database for a fictional crystal shop called The Dragon's Hoard in order to develop our database skills. We wanted to track products, current inventory, transactions, reviews for products, and users who signed up for an account on the fictional shop's website.

Features:
* List which products we currently have in inventory
* Create new products
* Modify the amount of a particular product that we have in inventory
* Delete a product from inventory
* Get a list of the most popular products for a given time range
* Get a list of the least popular products for a given time range
* Get a list of users who haven't purchased something in a few months to send promotional emails to, this should also include products that these users normally purchase

## Design
We began by analyzing and collecting requirements. As part of this process, we developed a [glossary](https://github.com/roryhackney/ecommerceDatabase/blob/main/Glossary.pdf) which defined entities, naming conventions, and descriptions of various properties. We then developed an entity relationship [diagram](https://github.com/roryhackney/ecommerceDatabase/blob/main/design.png) (ERD) using Crow's Foot notation to plan our logical model, defining each entity, its properties, and its relationships with other entities (eg, one to many), by each of us designing half of the entities. After normalization, we worked on the final [table diagram](https://github.com/roryhackney/ecommerceDatabase/blob/main/tableDiagram.png) to define precisely how to implement each table in SQL, creating additional join tables for many to many relationships. We also split this work. 

## Implementation
Once the design was complete, we split up the tasks to write SQL to implement each table, allowing us to make progress on different independent tables at the same time. We also wrote SQL to insert data into each table. Finally, we developed SQL to create procedures and triggers. Once done, we combined our separate files, fixed bugs, and ensured everything worked together and successfully created the database when run in the correct order.

## Application
We then created a Java application which calls into the locally running database, using print statements for a menu and gathering user input in the terminal to demonstrate the functionality of the database.
