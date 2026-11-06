# Part 2: NumPy & Pandas Data Wrangling

## Overview
High-performance vectorized metric calculation using pure NumPy (without loops), missing-value profiling, multi-key deduplication, relational category joins, and lifespan analysis in Pandas.

## 1. Environment & Execution
To execute:
```bash
cd part2_numpy_pandas
pip install -r requirements.txt
jupyter notebook part2_analysis.ipynb
```
Follow standard notebook discipline: **Runtime -> Restart and run all**.

## 2. Engagement Score Weights Justification
- **Likes (0.50)**: Active affirmation of positive viewer sentiment.
- **Comments (0.30)**: Direct discussion depth requiring cognitive effort.
- **Views (0.20)**: Baseline exposure; weighted lower due to passive impressions.
- **Log Scaling**: Raw view counts span multiple orders of magnitude; log1p scaling compresses extreme skewness for interpretable linear analysis.

## 3. Data Cleaning & Deduplication
- **Duplicate Rule**: Same video_id on the same trending_date in the same country. Removed via drop_duplicates.
- **Category Join**: Performed via left merge against categories.csv so zero trending records are dropped.
- **Missing Values**: Handled safely with fillna('Unknown') for unmatched text fields.
