# Banking Customer & Loan Analytics

An end-to-end data analytics project analyzing banking customer behavior, loan activity, branch performance, and transaction patterns using Python, SQL, and Tableau.

![Python](https://img.shields.io/badge/Python-3.10+-blue)
![Pandas](https://img.shields.io/badge/Pandas-2.0+-green)
![Tableau](https://img.shields.io/badge/Tableau-2023+-orange)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 📑 Table of Contents

- [📌 Project Overview](#-project-overview)
- [📂 Project Structure](#-project-structure)
- [🛠️ Tools & Technologies](#️-tools--technologies)
- [📊 Key Business Insights](#-key-business-insights)
- [🚀 Getting Started](#-getting-started)
  - [1. Clone the Repository](#1-clone-the-repository)
  - [2. Create Virtual Environment](#2-create-virtual-environment)
  - [3. Install Dependencies](#3-install-dependencies)
  - [4. Run Jupyter Notebooks](#4-run-jupyter-notebooks)
- [📈 Tableau Dashboards](#-tableau-dashboards)
- [📄 Business Report](#-business-report)
- [👤 Author](#-author)
- [📜 License](#-license)

---

## 📌 Project Overview

This project performs comprehensive business analysis on a banking dataset containing **10,004 customers**, **15,000 accounts**, **99,975 transactions**, **4,990 loans**, and **100 branches**. The analysis answers **27 key business questions** related to customer segmentation, branch performance, loan activity, customer risk, and transaction channel popularity.

---

## 📂 Project Structure

Banking final intern project/
│
├── data/
│ ├── cleaned_dataset/ # Processed CSV files ready for analysis
│ ├── raw_dataset/ # Original immutable data
│ └── cleaned_dataset.zip # Zipped version of cleaned data
│
├── final business report/ # Final documentation/reports
│
├── notebooks/ # Jupyter Notebooks for Python analysis
│ ├── Business_Question.ipynb
│ ├── EDA_analysis.ipynb
│ ├── pandas_data_cleaning.ipynb
│ └── python_numpy.ipynb
│
├── sql/ # SQL scripts for data extraction and querying
├── tableau/ # Tableau workbook files
├── .gitignore # Git ignore file
├── LICENSE # License information
├── README.md # Project documentation
└── requirements.txt # Python dependencies


---

## 🛠️ Tools & Technologies

| Category | Tools |
|---|---|
| **Programming** | Python 3.10+ |
| **Data Manipulation** | Pandas, NumPy |
| **Visualization** | Matplotlib, Seaborn |
| **Database** | MySQL / SQLite |
| **BI Tool** | Tableau |
| **Environment** | Jupyter Notebook |
| **Version Control** | Git, GitHub |

---

## 📊 Key Business Insights

| # | Insight |
|---|---|
| 1 | **Medium Income** customers contribute **55%+** of deposits, transactions, and loans |
| 2 | **Branch 057** generates the highest deposits |
| 3 | **Branch 003** has the highest loan activity |
| 4 | **Personal Loans** are the most popular by count |
| 5 | **Home Loans** dominate by total amount |
| 6 | **Mobile Banking** is the most popular transaction channel |
| 7 | **275 customers** are classified as **Higher Risk** |
| 8 | **Income** has no significant correlation with loan exposure |
| 9 | **22 branches** have high deposits but low loan activity |
| 10 | **Digital channels** account for **~48%** of transactions |

---

## 🚀 Getting Started

### **1. Clone the Repository**

```bash
git clone https://github.com/shraban50/Banking-Customer-Loan-Analytics.git
cd Banking-Customer-Loan-Analytics
```
### **2. Create Virtual Environment**
```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS / Linux
python3 -m venv venv
source venv/bin/activate
```
### **3. Install Dependencies**

```bash
pip install -r requirements.txt
```

### **4. Run Jupyter Notebooks**

```bash
jupyter notebook
```
Open the notebooks in order:

1. `01_python_numpy.ipynb

2. `02_pandas_data_cleaning.ipynb

3. `03_EDA_analysis.ipynb

4. `04_Business_Question.ipynb

---

## 📈 Tableau Dashboards

Interactive Banking Analytics Dashboard for management — covering executive KPIs, customer insights, loan analysis, and branch performance.

### Dashboard 1 — Executive Overview

**KPIs:** Total Customers · Total Deposits · Total Loans · Total Transactions · Avg Account Balance · Avg Loan Amount

**Charts:** Customer growth, deposit trend, loan trend, transaction trend, branch performance, loan status.

**Filters:** Date, City, Branch, Account Type, Loan Type, Gender.

![Dashboard 1](https://raw.githubusercontent.com/shraban50/Banking-Customer-Loan-Analytics/main/tableau/Dashboard-1.png)

### Dashboard 2 — Customer Analytics

Customer demographics · Income distribution · Customer distribution by city · Customer growth · Top customers · Account balances.

![Dashboard 2](https://raw.githubusercontent.com/shraban50/Banking-Customer-Loan-Analytics/main/tableau/Dashboard-2.png)

### Dashboard 3 — Loan Analytics

Total loan amount · Number of loans · Loan types · Approved vs rejected · Active vs completed · Average loan amount · Loan performance by branch · Loan performance by customer segment.

![Dashboard 3](https://raw.githubusercontent.com/shraban50/Banking-Customer-Loan-Analytics/main/tableau/Dashboard-3.png)

### Dashboard 4 — Branch Performance

Compare branches by customers, deposits, loans, transactions, average balance, and loan performance. Identify best-performing and underperforming branches.

![Dashboard 4](https://raw.githubusercontent.com/shraban50/Banking-Customer-Loan-Analytics/main/tableau/Dashboard-4.png)

---

## 📄 Business Report

A comprehensive business report is available in:

- **HTML:** `final business report`

- **PDF:** `final business report`

---

## 👤 Author

**Shraban Chaudhary**
- Organization: **Sipalaya InfoTech**

- GitHub: [@shraban50](https://github.com/shraban50)

- Email: **shrabanchy50@gmail.com** 

---

## 📜 License
This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

⭐ **If you find this project useful, please give it a star!**