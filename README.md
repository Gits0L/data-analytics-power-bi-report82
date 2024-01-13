# Power Bi Report: Retail analytics

|      |       |
:-------------------------:|:-------------------------:
![Alt text](<Executive Summary .png>)  | ![Alt text](<Customer Info.png>)
![Alt text](<Product Detail.png>)   | ![ ](<stores page.png>) |

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

### 2. Function 
---
The function of this project is to utulise the skills learnt in the PowerBi module of the aicore datascience course to build a data visualisation mimicking real retail data. By leveraging the company's business objectives, including sales metrics on a quarterly and annual basis, the report aims to deliver actionable insights to guide the company's future strategic direction. The report provides a succinct business overview created for C-suite executives within a global retail corporation. 
 

### Report Creation:
 #### The project is split into milestones each containing various tasks to complete the visualisation.
---

***Importing Tables***
 
 | Table | Importing Method | Transformations | 
| ----------- | ----------- | ----------- |
| Orders | Azure SQL Database  | Renamed and split columns. Deleted private columns. Removed empty date values. |
| Products |  CSV download  | Split weights and measurments into 2 seperate columns. Converted values to decimals. Converted values to kg. Deleted unimportant columns |
| Stores | Azure BLob Storage | Renamed columns |
| Customers | Combined from zip file  | Created Full Name column. Deleted unused columns. Renamed columns  |

***Model Creation***

![alt text](PICTURE OF MODEL)
1. Created a date table to form the basis for time intelligence within the model using the folllowing DAX formula: 
Dates = DATESBETWEEN(
    Orders[Order Date],
    MIN(Orders[Order Date]),
    MAX(Orders[Order Date])
)

1. Built one-to-many relationships with a single filter between the following tables to form a star-based schema: 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Orders[product_code] &rarr; Products[product_code]

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Orders[Store Code] &rarr; Stores[store code]

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Orders[User ID] &rarr; Customers[User UUID]

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Orders[Order Date] &rarr; Date[date]

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Orders[Shipping Date] &rarr; Date[date]

3. Created DAX Formulas for the following measures: 



&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Orders: 
COUNT(Orders[User ID]) 

 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Revenue: 
SUMX(Orders, Orders[Product Quantity] * RELATED(Products[Sale Price]))

 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Profit: 
SUMX(Orders, (RELATED(Products[Sale Price]) - RELATED(Products[Cost])) * Orders[Product Quantity])

 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Customers: 
CALCULATE(
    COUNTROWS(DISTINCT(
        VALUES(Orders[User ID])
    )
)
)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Quantity: 
SUM(Orders[Product Quantity])

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Profit YTD:  
CALCULATE([Total Profit], FILTER(ALL('Dates'), VALUE('Dates'[Year]) = (YEAR(MAX('Dates'[Order Date])))))


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Revenue YTD:
CALCULATE(
    [Total Revenue],
    FILTER(
        ALL('Dates'),
        VALUE('Dates'[Year]) = YEAR(MAX('Dates'[Order Date]))
    )
)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Revenue per Customer:
[Total Revenue] * [Total Unique Customers]


4. Created date hierachy

![Alt text](<date hierarchy.png>)

5. Created a calculated column to create a full country name: 

6. Created a geography hierarchy
   
![Alt text](<geog hierarch.png>)

***Customer Detail Page***

![Alt text](<Customer Info.png>)

| Visual | Measures Used | Filters  | Aditional Formatting |
| ----------- | ----------- | -------- | ------ |
| Cards | [Total Customers] [Revenue per Customer]  | None | None |
| Donut Chart | [Total Customers]  | Users[Country] | None |
| Column Chart | [Total Customers] | Products[Category] | None |
| Line Chart with trendline forecasting the next 10 periods (confidence interval = 95%) | X Axis: Date Hierarchy  Y Axis: [Total Customers] | None | None |
| Table | Orders[Full Name] [Total Revenue] [ Total Orders]  | Top 20 by [Total Revenue] | Data bars based on [Total Revenue] |
| Card | Customers[Full Name]  | Top 1 by [Total Revenue] | None |
| Card | [Total Revenue]  | Top 1 by [Total Revenue] | None |
| Card | [ Total Orders]  | Top 1 by [Total Revenue] | None |
| Slicer | Dates[Year]  | Between | None |

***Executive Summary Page***

![Alt text](<Executive Summary .png>) 

| Visual | Measures Used | Filters  | Additional Formatting |
| ----------- | ----------- | -------- | ------ |
| Card | [Total Revenue] | None | 2 Decimals |
| Card | [Total Orders]  | Users[Country] | 1 Decimal |
| Card | [Total Profit] | Products[Category] | 2 Decimals |
| Line chart | X Axis: Date Hierarchy[Start of Year, Start of Quarter, Start of Month] Y Axis: [Total Revenue] | None | None |
| Donut | [Total Revenue]  | Store[Country] | None |
| Donut | [ Total Revenue]  | Store[Store Type] | None |
| Clustered Bar Chart | Total Orders  | None | None |
| KPI | Value: [Total Revenue] Trend: [Start of Quarter] Target: [Target Revenue]  | By [Quarter] | Trend Axis: On Direction: High is Godd Bad Colour: red Transparency 15% Decimal: 1|
| KPI| Value: [Total Orders] Trend: [Start of Quarter] Target: [Target Orders]  | By [Quarter] | Trend Axis: On Direction: High is Godd Bad Colour: red Transparency 15% Decimal: 1 |
| KPI | Value: [Total Profit] Trend: [Start of Quarter] Target: [Target Profit]  | By [Quarter] | Trend Axis: On Direction: High is Godd Bad Colour: red Transparency 15% Decimal: 1 |

The following measures were created:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Previous Quarter Profit:
VAR CurrentQuarterStart = MAX('Dates'[Start of Quarter])
RETURN
CALCULATE([Total Profit], 
    'Dates'[Start Of Quarter] = CurrentQuarterStart
)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Previous Quarter Revenue:
VAR CurrentQuarterStart = MAX('Dates'[Start of Quarter])
RETURN
CALCULATE([Total Revenue], 
    'Dates'[Start Of Quarter] = CurrentQuarterStart
)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Previous Quarter Orders:
VAR CurrentQuarterStart = MAX('Dates'[Start Of Quarter]) RETURN CALCULATE('Measures Table'[Total Orders], 'Dates'[Start Of Quarter] = CurrentQuarterStart)

***Product Detail Page***

| Visual | Measures Used | Filters  | Additional Formatting |
| ----------- | ----------- | -------- | ------ |
| Gauge | Value: [Total Orders] Target: [Quarterly Growth] | None  | Colour for target not met: red |
| Gauge | Value: [Total Revenue] Target: [Quarterly Growth] | None | Colour for target not met: red |
| Gauge | Value:[Total Profit] Target: [Quarterly Growth] | None | Colour for target not met: red |
| Area chart | X Axis: Date Hierarchy[Start of Quarter] Y Axis: [Total Revenue] Legend: Products[Category] | None | None |
| Table | [Product Description] [Total Revenue] [Total Customers] [Total Orders] [Profit per Order] [ Total Orders]  | By Store[Country] and Store[Store Type] | None |
| Scatter | Value: Products[Description] X-Axis: Products[Profit per Item] Y-Axis Products[Total Quantity] Legend: Products[Category] | None | None |

***Stores Map Page***

![Alt text](<Map VIsual .png>)

| Visual | Measures Used | Filters  | Additional Formatting |
| ----------- | ----------- | -------- | ------ |
| Map | Location: [Geography hierarchy] Bubble size: [Profit YTD] | Country Slicer | Show Labels: On Auto-Zoom: On Zoom buttons: Off Lasso button: Off |

***Stores Page***

![ ](<stores page.png>) 

| Visual | Measures Used |
| ----------- | ----------- |
| Table | [Description] [Profit YTD] [Total Orders] [Total Revenue] |  
| Column Chart | [Total Orders] Products[Category]  |
| Guage | [Profit YTD] against target | 

***Interactions***

 **X** = No interaction
 **O** = Interaction

***Executive Summary Page Interactions***

Product Category and Top 10 Products Table ***X*** Card Visuals and KPI

***Customer Detail Page*** 

Top 20 Customers Table **X** None of the visuals

Total Customers By Product Donut Chart ***X*** Customers line graph

Total Customers By Country Donut Chart ***O Cross Filter O*** Total Customers By Product Donut Chart

***Product Detail Page*** 

Orders vs. profitability Scatter Graph ***X*** None of the visuals 

Top 10 Products Table ***X*** None of the visuals 

***Milestone 7:
Metrics with SQL***
1. Connected to SQL Server via SQLTools extension in VSCode using the following credentials:

&nbsp;&nbsp; `````` 
HOST, PORT, DATABASE, USERNAME, PASSWORD
;``````

2. SQL Query to extract all table names

&nbsp;&nbsp; ``````
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
AND table_type = 'BASE TABLE'
;``````

3. SQL Query to print columns in all tables: 

&nbsp;&nbsp; `````` 
SELECT * from column_name
;``````

4. Exported all tables to CSV files

5. Saved files showing the SQL query (.sql files) and query output/answer (.csv files) 
for the following questions: 
  
 ``````

1. How many staff are there in all of the UK stores?

2. Which month in 2022 has had the highest revenue?

3. Which German store type had the highest revenue for 2022?

4. Create a view where the rows are the store types and the columns are the total sales, percentage of total sales and the count of orders

5. Which product category generated the most profit for the "Wiltshire, UK" region in 2021?

``````



  #### 4. Installation
  ---
  - Clone GitHub repository:
    git clone https://github.com/Gits0L/data-analytics-power-bi-report82.git

  #### 6. File structure
  ---
  - README.md: Repository information 
  - Images: 
  Executive Summary Page Image , Map Visual Page Image, Customer Info Page Image, Product Detail Page Image, Date Hierarchy Image, Georaphy Hierarchy Image  
  - sql files for question 1-5
  - csv files for output of sql files answering questions 1-5
