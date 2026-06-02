# GA4 E‑commerce Performance Analysis (Google Merchandise Store)

This project explores Google Merchandise Store GA4 e‑commerce data (Nov 2020 – Jan 2021) to understand how traffic, devices, products, and customers drive revenue. The analysis feeds an interactive Power BI dashboard and is designed to mirror a real analytics workflow from raw events to business‑ready insights.

**Tools:** PostgreSQL • Python • Power BI (Desktop 2.146)

> ✨ **Live Interactive Report:** [Interact with the Power BI dashboard here](https://dtplay.github.io/ga4-ecommerce-analysis/) 🔗 (Right-click to open in a new tab)

## Data & Business Questions

The dataset is a static export of GA4 event data with ~7.7M events, 270K users, and 360K sessions over a 92‑day window.

The analysis focuses on four main questions:

- Which traffic sources and devices generate the most revenue and conversions?
- Where do users drop out in the purchase funnel, and how large is the opportunity if those leaks improve?
- Which products and months drive peak performance during the holiday period?
- How concentrated is revenue across customers (Pareto / 80‑20), and what does that mean for retention strategy?

## Methodology & Project Structure

Event data is pulled from Google BigQuery, flattened and pre‑processed in Python, and then loaded into a PostgreSQL database for analysis. A series of notebooks run SQL, perform data‑quality checks, aggregate results, and export curated CSVs for Power BI.

Repository layout:

- `sql/` – create, stage, merge, and prepare tables in PostgreSQL (schema, staging, and wrangling scripts).
- `notebooks/` – step‑by‑step notebooks for fetching data, preprocessing, database setup, population, and final analysis.
- `exports/` – cleaned analysis outputs in CSV format used as Power BI sources.
- `powerbi/` – Power BI report and a PDF export of the dashboard for quick viewing.

If you mainly care about the results, open the **[Live Interactive Dashboard](https://dtplay.github.io/ga4-ecommerce-analysis/)** 🔗 (Right-click to open in a new tab) directly, or explore the pre-aggregated findings inside `notebooks/06_analysis.ipynb`.

## Key Findings

A full breakdown is available in `06_analysis.ipynb` and the Power BI dashboard.
Below are some high‑level takeaways:

- **Traffic & devices:** Google organic and direct are the main revenue drivers, while referral traffic and desktop sessions show particularly strong conversion and revenue per session.
- **Funnel:** Most drop‑off occurs before product views and add‑to‑cart, while checkout steps perform relatively well once users enter the funnel.
- **Seasonality & products:** Revenue peaks around Black Friday and December holidays, with hoodies and sweatshirts consistently ranking among the top sellers.
- **Customers:** Because revenue is heavily concentrated in the top 20–50% of customers and among repeat buyers, retention efforts should prioritize keeping these segments active and encouraging one‑time buyers to make additional purchases.

For detailed recommendations on how to act on these findings, see the notebook's **Key Recommendations** section.

## How to Run the Project & View the Dashboard

This repo is designed to be reproducible end‑to‑end, from raw GA4 events to BI.

1. **Access the data**

   - The original GA4 data lives in Google BigQuery and is not included here due to size.
   - Use your own Google Cloud project and credentials to query the GA4 export table, following the structure in the fetch/preprocess notebooks.

2. **Rebuild the database and exports**

   - Run the numbered notebooks in `notebooks/` in order (`01_fetch_data` → `06_analysis`) to download, flatten, load into PostgreSQL, and generate the analysis tables and CSV exports in `exports/`.

3. **Open the Power BI report**
   - Open the `.pbix` file in the `powerbi/` folder.
   - If needed, update the data source paths so each table points to the corresponding CSV in `exports/`, then refresh the model.

From there, use the dashboard pages (Traffic, Devices, Funnel, Revenue, Products, Customers) to drill into the same insights shown in the notebook, but in a more interactive way.


## Environment & Dependencies

See `requirements.txt` for all dependencies. Install with:

```
pip install -r requirements.txt
```

Then set up a `.env` file with your PostgreSQL credentials:

```
DB_USER=your_db_user
DB_PASSWORD=your_db_password
```

**Note:** The original GA4 data was fetched from Google BigQuery. Pre-processed CSVs are included in `exports/` and can be used directly to explore the analysis without BigQuery access.
