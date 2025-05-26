# Java Servlet E-commerce Project - README

---

## Project Overview

This is a Java Servlet-based e-commerce web application connected to a MariaDB database.
It provides users with authentication, product browsing, shopping cart management, and order updating functionalities. The application demonstrates the use of Servlets, session management, JDBC for database interaction, and frontend integration with JSP/HTML/CSS and JavaScript.

---

## Table of Contents

* [Technologies](#technologies)
* [Database Schema](#database-schema)
* [Setup and Installation](#setup-and-installation)
* [Project Structure](#project-structure)
* [Features](#features)
* [Detailed Functionalities](#detailed-functionalities)
* [Security Considerations](#security-considerations)
* [Future Improvements](#future-improvements)
* [Copyright](#copyright)

---

## Technologies

* Java Servlet API
* MariaDB (10.4+)
* JDBC (MariaDB JDBC Driver)
* JSP, HTML5, CSS3, JavaScript
* Servlet Container (Apache Tomcat or similar)

---

## Database Schema

### Database: `yourDBName`

**Tables:**

* `utenti` (users)

  * `ID` INT PRIMARY KEY AUTO\_INCREMENT
  * `Cognome` VARCHAR(50)
  * `Nome` VARCHAR(50)
  * `Email` VARCHAR(50) UNIQUE
  * `Username` VARCHAR(50) UNIQUE
  * `Password` VARCHAR(50) *(stored in plaintext, see Security)*

* `prodotti` (products)

  * `ID` INT PRIMARY KEY AUTO\_INCREMENT
  * `Nome` VARCHAR(50)
  * `Descrizione` TEXT
  * `Immagine` VARCHAR(20) (image filename)
  * `Prezzo` DOUBLE(7,2)
  * `Disponibilita` TINYINT(1) (boolean, 1 = available)
  * `Quantita` INT (stock quantity)

* `ordini` (orders)

  * `ID` INT PRIMARY KEY AUTO\_INCREMENT
  * `ID_Utente` INT (FK to utenti.ID)
  * `ID_Prodotto` INT (FK to prodotti.ID)
  * `Data_Acquisto` DATETIME (default current\_timestamp)
  * `Quantita` INT
  * `SubTotale` DOUBLE(7,2)

### Relationships:

* `ordini.ID_Utente` references `utenti.ID` (cascade on delete/update)
* `ordini.ID_Prodotto` references `prodotti.ID` (cascade on delete/update)

---

## Setup and Installation

1. **Database Setup**

   * Install MariaDB server.
   * Create the database and tables (you can import the provided `dbServelet.sql`)
   * Adjust DB user credentials in `DBConnection.java` if different.

2. **Project Setup**
   * Import the project into your Java IDE (Eclipse, IntelliJ IDEA, NetBeans).
   * Add MariaDB JDBC driver (`mariadb-java-client.jar`) to the classpath or Tomcat's `/lib`.
   * Configure your servlet container (Tomcat recommended).
   * Deploy the WAR or run from the IDE.

3. **Run**
   * Access the application at `http://localhost:8080/[project_name]/login` or `/login`.
---

## Project Structure Overview

* **Servlets:**

  * `HelloServlet.java` → Handles GET request to show login form.
  * `CheckLogin.java` → Processes login POST request, authenticates users.
  * `AddToCart.java` → Adds products to user’s cart (in DB orders).
  * `AggiornaOrdine.java` → Updates quantity of an order in the cart.
  * (Potential) `RimuoviOrdine.java` → Removes order from cart (not shown but referenced).

* **Database Utility:**
  * `DBConnection.java` → Handles DB connection, executes queries (select, insert, update).

* **Frontend:**
  * JSP pages: `login.jsp`, `shop.jsp`, `carrello.jsp` (cart), `ErrorPage.jsp`.
  * CSS and JavaScript for UI/UX (dark mode toggle).

---

## Features

* **User Authentication:** Login with username and password.
* **Session Management:** Stores user session data (`Username`, `Id`, `Password`) for continuity.
* **Product Browsing:** Users can see available products and their details.
* **Shopping Cart:** Users can add products with quantity to their cart, which creates orders in the DB.
* **Order Updates:** Users can update quantities of items in the cart with automatic stock adjustment.
* **Stock Management:** Product quantity and availability updated accordingly when items are added or updated in cart.
* **UI Enhancements:** Dark Mode toggle on login page for better accessibility.

---

## Detailed Functionalities

### 1. Login (`HelloServlet` & `CheckLogin`)

* `HelloServlet` generates a login form on GET `/login`.
* The form submits to `/CheckLogin` via POST.
* `CheckLogin` verifies username and password against `utenti` table.
* On success: stores session attributes, forwards to `shop.jsp`.
* On failure: forwards to `ErrorPage.jsp`.

### 2. Add To Cart (`AddToCart`)

* Triggered via POST `/addToCart` with parameters `idObj` (product ID) and `quantita` (quantity).
* Retrieves product price and stock.
* Validates stock and updates `prodotti.Quantita` and possibly `Disponibilita`.
* Inserts a new record into `ordini` with user ID, product ID, quantity, and subtotal.

### 3. Update Order (`AggiornaOrdine`)

* Triggered via POST `/aggiornaOrdine` with `id_ordine` and `quantita`.
* Retrieves current order and product info.
* Calculates difference in quantity and updates product stock accordingly.
* Prevents update if stock is insufficient.
* Updates order quantity and subtotal.

### 4. Database Access (`DBConnection`)

* Manages DB connection on instantiation.
* Supports `selectQuery`, `insertQuery`, and `updateQuery` methods.
* Note: current implementation uses simple statements — needs prepared statements for security.

---

## Security Considerations

* **Passwords:** Currently stored as plain text — **highly insecure**. Use hashing algorithms (e.g., BCrypt) for password storage.
* **SQL Injection:** Queries are constructed via string concatenation, vulnerable to injection. Use `PreparedStatement` to safely handle inputs.
* **Session Security:** Avoid storing passwords in session. Store only minimal identifiers and roles.
* **Input Validation:** No server-side validation currently — should validate and sanitize all user inputs.
* **Error Handling:** Add user-friendly error pages and proper exception handling/logging.

---

## Future Improvements

* Implement user registration and email verification.
* Add password recovery and reset.
* Enhance product catalog with categories and search.
* Introduce admin panel for product and user management.
* Integrate payment gateway for checkout.
* Improve UI/UX with responsive design and frameworks.
* Implement caching for better performance.
* Migrate database connection to connection pool for efficiency.

---

## Copyright
**Author:** Alessandro Gavinelli
**Purpose:** Educational project for Java web programming and database integration.

---
