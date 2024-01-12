# Power Bi Report: Retail analytics
![alt text](https://www.whizlabs.com/blog/wp-content/uploads/2023/09/power-bi-report-builder.jpeg)
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
This project entails the development of a comprehensive report consisting of the following pages:

| Page | Contents |
| ----------- | ----------- |
| Exective Summary | Company performance overview detailing outcomes against key targets  |
| Customer Info |  Customer information page detailing customer count by revenue and location metrics  | 
| Product Detail | Product information outline showing success of product sales by product and region |
| Stores Map | Map visual showing regional profit performance by quarter  |
| Stores Drillthough | Allows drillthough to particular store within region |

As seen below: 
|      |       |
:-------------------------:|:-------------------------:
![](https://www.whizlabs.com/blog/wp-content/uploads/2023/09/power-bi-report-builder.jpeg)  |  ![](https://www.whizlabs.com/blog/wp-content/uploads/2023/09/power-bi-report-builder.jpeg)
![](https://www.whizlabs.com/blog/wp-content/uploads/2023/09/power-bi-report-builder.jpeg)  |  ![](https://www.whizlabs.com/blog/wp-content/uploads/2023/09/power-bi-report-builder.jpeg)



### 2. Function 
---
The function of this project is to utulise the skills learnt in the PowerBi module of the aicore datascience course to build a data visualisation mimicking real retail data. By leveraging the company's business objectives, including sales metrics on a quarterly and annual basis, the report aims to deliver actionable insights to guide the company's future strategic direction. The report provides a succinct business overview created for C-suite executives within a global retail corporation. 
 

### 3. Milestones:
 #### The project is split into milestones each containing various tasks to complete the visualisation.
---

***Milestone 1:
Importing Tables***
 
 | Table | Importing Method | Transformations | 
| ----------- | ----------- | ----------- |
| Orders | Azure SQL Database  | Renamed and split columns. Deleted private columns. Removed empty date values. |
| Products |  CSV download  | Split weights and measurments into 2 seperate columns. Converted values to decimals. Converted values to kg. Deleted unimportant columns |
| Stores | Azure BLob Storage | Renamed columns |
| Customers | Combined from zip file  | Created Full Name column. Deleted unused columns. Renamed columns  |

***Milestone 2:
Model Creation***

![alt text](PICTURE OF MODEL)
1. Created a date table to form the basis for time intelligence within the model using the folllowing DAX formula: 

1. Built one-to-many relationships with a single filter between the following tables to form a star-based schema: 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Orders[product_code] &rarr; Products[product_code]

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Orders[Store Code] &rarr; Stores[store code]

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Orders[User ID] &rarr; Customers[User UUID]

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Orders[Order Date] &rarr; Date[date]

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Orders[Shipping Date] &rarr; Date[date]

3. Created DAX Formulas for the following measures: 


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Orders: 
DAX

 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Revenue: 
 DAX

 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Profit: 
 DAX

 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Customers:
 DAX


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Quantity: 
DAX


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Profit YTF: 
DAX


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Revenue YTD:
DAX

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Revenue per Customer:
DAX

4. Created date hierachy
![alt text](PICTURE)

5. Created a calculated column to create a full country name with the following DAX formula: 
DAX

6. Created a geography column with the following DAX formula:
DAX

7. Created a geography hierarchy


***Miletone 3:
Customer Detail Page***

![alt text](FINISHED PAGE)


| Visual | Measures Used | Filters  | Aditional Formatting |
| ----------- | ----------- | -------- | ------ |
| Cards | [Total Customers] [Revenue per Customer]  | None | None |
| Donut Chart | [Total Customers]  | Users[Country] | None |
| Column Chart | [Total Customers] | Products[Category] | None |
| Line Chart with trendline forecasting the next 10 periods (confidence interval = 95%) | X Axis: Date Hierarchy  Y Axis: [Total Customers] | None | None |
| Table | Orders[Full Name] [Total Revenue] [ Total Orders]  | Top 20 by [Total Revenue] | Displayed data bars based on [Total Revenue] |
| Card | Customers[Full Name]  | Top 1 by [Total Revenue] | None |
| Card | [Total Revenue]  | Top 1 by [Total Revenue] | None |
| Card | [ Total Orders]  | Top 1 by [Total Revenue] | None |
| Slicer | Dates[Year]  | Between | None |

***Milestone 4:
Exectuvie Summary Page***

***Milestone 5: 
Product Detail Page***

***Milestone 5:
Stores Map Page***

***Milestone 6:
Metrics with SQL***


Uploading the following tables:
1. Orders
2. Products
3. Stores
4. Customers


  #### 4. Installation
  ---
  - Clone GitHub repository:
    git clone https://github.com/Gits0L/data-analytics-power-bi-report82.git

  #### 5. Usage
---
  - Use code to import import and connect to database using credentials, clean and analyse financial data 

  #### 6. File structure
  ---
  - README.md: Repository information 
  - db_utils.py: Final version 
  - loans_keywords: Glossary of loan columns to understand dataset
