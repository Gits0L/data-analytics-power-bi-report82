# Power Bi Report: Retail analytics
## Contents of README
``````
1. Project Information
2. Function
3. Milestones
4. Installation
5. Usage
6. File Structure
``````


### 1. Project information 
---
This project entails the development of a comprehensive report that provides a succinct business overview created for C-suite executives within a global retail corporation. The project is split into 10 milestones each containing various tasks to complete the visualisation. 

#### 2. Function 
---
The function of this project is to utulise the skills learnt in the PowerBi module of the aicore datascience course to build a data visualisation mimicking real retail data. By leveraging the company's business objectives, including sales metrics on a quarterly and annual basis, the report aims to deliver actionable insights to guide the company's future strategic direction.

#### 3. Milestones
---

***Milestone 1-Importing Tables***

1. Importing the tables and transorming the data of the following data tables:
 - Orders
 - Products
 - Stores 
 - Customers

***Milestone 2-Model Creation***

1. Creating a date table to form the basis for time intelligence within the model. 

1. Building one-to-many relationships with a single filter between the following tables to form a star-based schema: 

Orders[product_code] --> Products[product_code]

Orders[Store Code] --> Stores[store code]

Orders[User ID] --> Customers[User UUID]

Orders[Order Date] --> Date[date]

Orders[Shipping Date] --> Date[date]

3. Creating DAX Formulas for the following measures: 

- Total Orders

 - Total Revenue

 - Total Profit 

 - Total Customers

- Total Quantity

- Profit YTF

- Revenue YTD

4. Creating date hierachy 

***Miletone 3 Customer Detail Page***

***Milestone 4 Exectuvie Summary Page***

***Milestone 5 Product Detail Page***

***Milestone 5 Stores Map Page***

***Milestone 6 Metrics with SQL***


Uploading the following tables:
1. Orders
2. Products
3. Stores
4. Customers


  #### 4. Installation
  ---
  - Clone GitHub repository:
    git clone 

  - Navigate into the project directory:
    cd 

  #### 5. Usage
---
  - Use code to import import and connect to database using credentials, clean and analyse financial data 

  #### 6. File structure
  ---
  - README.md: Repository information 
  - db_utils.py: Final version 
  - loans_keywords: Glossary of loan columns to understand dataset
