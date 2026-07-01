# port-shipping-SQL
Port and Shipping Management Database System | Academic Project

This repository contains a robust relational database designed and implemented to handle port logistics, shipping operations, vessel tracking, crew management, and dock allocations.

The database schema was engineered from scratch following strict normalization rules (up to Boyce-Codd Normal Form - BCNF) to eliminate data redundancy and guarantee data integrity.

## Repository Structure

The project is highly modularized to ensure clean organization and ease of deployment:

* `esquema/schema.sql` — Contains table dropping and creation scripts, along with core structural constraints.
* `triggers/` — Database triggers that automate validation rules and background business processes.
* `dados/` — Seed scripts populating the database with realistic test cases for validation.
* `views/` — View definitions created to isolate query complexity and streamline frequent lookups.

##  Main Core Domains
* **Crew & Staff (Pessoas):** Manages personal information and handles crew role assignments for vessels.
* **Vessels (Barcos):** Tracks technical specifications, weight capacities, and ship registries.
* **Docks & Berths (Cais):** Coordinates physical capacity, availability, and size constraints within the port.
* **Shipping Operations:** Controls cargo tracking, routes, arrival/departure schedules, and overall logistics.
