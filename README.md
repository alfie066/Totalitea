# Totalitea – Tea & Coffee E-Commerce Website

## Overview
Totalitea is a web-based e-commerce application that allows users to browse and purchase tea and coffee products.  
The system supports user accounts, a shopping basket, and a full checkout process with order tracking.

---

## Features

- User registration and login
- Browse and search products
- Add items to basket with weight and quantity options
- Remove items from basket
- Automatic shipping cost calculation based on weight
- Free delivery for orders over £100
- Checkout system with payment processing
- Order creation and management

---

## Technologies Used

- Java (Servlets & JSP)
- MySQL (Relational Database)
- Bootstrap (Frontend styling)
- HTML/CSS
- Apache Tomcat

---

## System Architecture

The application follows a layered architecture:

- **Presentation Layer** – JSP pages (e.g. basket.jsp, checkout.jsp)
- **Application Layer** – Handler classes (BasketHandler, OrderHandler, etc.)
- **Data Layer** – MySQL database

This separation improves maintainability and code organisation.

---

## Database Design

The database is designed using Third Normal Form (3NF):

- Each table contains data related to a single entity
- No repeating groups (1NF)
- All attributes depend on the primary key (2NF)
- No transitive dependencies (3NF)

### Tables include:
- User – stores user account details
- Product – stores product information
- Orders – stores order information
- OrderItem – stores items within each order
- Payment – stores payment details for each order

---

## Key Design Decisions

- **OrderItem table** uses a unique constraint (OrderId, ProductId, Grams) to prevent duplicate items
- Payment details are stored separately from users to improve normalisation
- Price is stored per product and retrieved dynamically
- Shipping is calculated using both weight and subtotal rules

---

## Shipping Rules

- Up to 5kg → £1
- 6–10kg → £10
- Over 10kg → £15
- Orders over £100 → FREE delivery

---

## How to Run

1. Import the project into your IDE (e.g. Eclipse)
2. Set up the MySQL database using the provided SQL script
3. Configure database connection in `DbConnector`
4. Run the project using a servlet container (e.g. Apache Tomcat)
5. Access via browser (e.g. http://localhost:8080/Totalitea)

---


---

## Authors

Alfie Cull, Mutasim, Imraan