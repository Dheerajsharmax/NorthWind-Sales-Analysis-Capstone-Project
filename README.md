# NorthWind-Sales-Analysis-Capstone-Project
– Description The Northwind database is a structured relational dataset representing a fictional global trading company. It includes customers, orders, products, suppliers, employees, and shipping data. Widely used for SQL practice and BI projects, it supports sales analysis, KPI development, and dashboard creation in real-world.
End-to-End Sales & Revenue Analytics Project
(Northwind Dataset)
1. Executive Summary
This project demonstrates a complete end-to-end Business Intelligence workflow using the Northwind dataset. The objective was to transform raw transactional data into structured insights that support strategic decision-making. The project integrates SQL for data exploration, Power BI for visualization and modeling, Excel for validation, and MECE framework for structured analytical thinking.
The analysis focused on revenue performance, product sales behavior, customer distribution, employee contribution, geographical insights, anomaly detection, and business-driven KPI evaluation.
2. Data Collection
The Northwind dataset was collected and imported into the analytical environment. The dataset contains structured transactional and master data tables including:
- Customers (Customer demographics and contact details)
- Orders (Transaction-level order records)
- Order Details (Line-item sales data including price, quantity, discount)
- Products (Product information and pricing)
- Categories (Product classification)
- Employees (Sales representatives and reporting structure)
- Suppliers (Vendor information)
- Shippers (Logistics providers)
Primary keys and foreign keys were reviewed to understand relational dependencies before proceeding with modeling.
3. Data Cleaning & Preprocessing
Data cleaning was performed to ensure accuracy, consistency, and reliability. The following steps were executed:
- Handled missing or null values where applicable.
- Corrected inconsistent data types (dates, numeric fields).
- Verified primary and foreign key integrity.
- Standardized categorical fields (Region, Country, Contact Title).
- Validated discount logic and price calculations.
- Removed duplicate or redundant records if detected.
Revenue metric was derived using the formula: Revenue = UnitPrice × Quantity × (1 - Discount).
4. Data Modeling
A star schema model was implemented in Power BI to optimize analytical performance. The Order Details table was treated as the Fact table, while Customers, Products, Employees, Categories, and Suppliers were modeled as Dimension tables.
Relationships were defined using appropriate cardinality and cross-filter direction. Calculated columns and DAX measures were created for Revenue, Sales Growth, Moving Average, and Contribution %.
5. SQL Exploratory Data Analysis (EDA)
Advanced SQL queries were written to perform exploratory data analysis before visualization. Key analytical areas included:
- Product-wise total revenue calculation.
- Monthly revenue trend analysis using DATE functions.
- Top and bottom performing products.
- Customer segmentation by country and region.
- Revenue contribution by category.
- Employee performance comparison.
- Month-over-Month growth analysis using window functions (LAG).
- Anomaly detection using Z-Score and deviation from mean revenue.
6. Power BI Dashboard Development
Interactive dashboards were developed to visualize business performance. The dashboard included the following analytical views:
- Revenue trend over time (Line chart).
- Product performance analysis (Bar chart).
- Customer distribution by country (Map visualization).
- Category-wise revenue contribution (Stacked bar chart).
- Pricing distribution of products.
- Employee sales participation analysis.
- KPI cards for Total Revenue, Total Orders, and Average Order Value.
- Drill-through and slicer functionality for dynamic filtering.
7. Business Question Analysis
The dashboard and SQL analysis were aligned with business-focused questions such as:
- How does customer distribution vary across countries?
- What is the overall revenue growth trend?
- Which products contribute most to total revenue?
- Are there anomalies in product sales performance?
- How does discount impact profitability?
- What is the reporting hierarchy among employees?
- Which regions show consistent growth or decline?
8. MECE Analytical Framework
A MECE (Mutually Exclusive, Collectively Exhaustive) framework was applied to structure the analysis logically. The business problem was divided into independent components:
- Revenue Analysis
- Product Performance
- Customer Segmentation
- Geographic Distribution
- Employee Contribution
- Pricing & Discount Behavior
- Trend & Anomaly Detection
This approach ensured that no analytical dimension was overlooked and insights were structured systematically.
9. Excel-Based Insight Validation
Excel was used for secondary validation and additional insight generation. Pivot tables and summary statistics were used to cross-check Power BI outputs.
- Pivot table revenue summaries.
- Category-wise aggregation validation.
- Growth percentage verification.
- Manual anomaly cross-check.
- KPI comparison sheets.
10. Key Insights & Outcomes
The project delivered the following actionable insights:
- Identified high-revenue products contributing disproportionately to total sales.
- Detected abnormal revenue spikes and drops through statistical deviation.
- Observed seasonal sales behavior in specific categories.
- Highlighted underperforming regions requiring strategic focus.
- Measured employee contribution impact on sales performance.
- Evaluated discount strategy effectiveness.
11. Conclusion
This project demonstrates strong capabilities in SQL querying, data modeling, dashboard development, business analysis, and structured problem-solving. It reflects the ability to convert raw data into strategic insights aligned with business objectives.

