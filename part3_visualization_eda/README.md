# Part 3: Visualization, EDA & Business Thinking

## Overview
This module conducts deep exploratory data analysis, parametric and non-parametric distribution profiling, IQR-based outlier diagnostics, correlation analysis, 4-stage funnel conversion tracking, retention lifespan curve modeling, and executive business strategy synthesis across US, GB, and IN YouTube trending datasets.

---

## 1. Environment & Execution Instructions
To execute in Google Colab or locally:
```bash
cd part3_visualization_eda
pip install -r requirements.txt
jupyter notebook part3_analysis.ipynb
```
Follow standard notebook discipline: **Runtime -> Restart and run all**. The notebook runs self-contained from local data in `part3_visualization_eda/data/`.

---

## 2. Visualizations & Interpretations

### Figure 1: Bar Chart of Record Counts per Category
- **Interpretation**: Entertainment and Music dominate the trending dataset, representing over 50% of all captured snapshots, while educational and niche content appear infrequently.
- **Visual Justification**: A discrete vertical bar chart is optimal for categorical/nominal data, allowing direct magnitude comparisons across distinct categories.

### Figure 2: Histogram of Log10-Scaled Views
- **Interpretation**: Log-transforming raw view counts yields an approximately bell-shaped distribution centered near ^{5.5}$ (~316,000 views), confirming raw views follow an extreme heavy-tailed power law.
- **Visual Justification**: Histograms are standard for continuous single-variable distributions to assess skewness, modality, and density.

### Figure 3: Scatter Plot of Views vs. Likes
- **Interpretation**: Reveals a strong, monotonic positive correlation between reach and endorsement volume, with heteroscedastic dispersion expanding at higher view counts.
- **Visual Justification**: Scatter plots best display bivariate relationships between two continuous numeric variables, exposing non-linear patterns and breakout outliers.

### Figure 4: Line Chart of Daily Trending Records
- **Interpretation**: Demonstrates continuous longitudinal data capture with consistent daily volume, showing platform-level stability across the recording timeframe.
- **Visual Justification**: Line charts are the standard choice for time-series data where consecutive points represent continuous chronological intervals.

### Figure 5: Box Plot of Views Across Top 5 Categories
- **Interpretation**: Music exhibits significantly higher median views and a much broader interquartile range (IQR) than News & Politics or Howto & Style.
- **Visual Justification**: Box plots cleanly display five-number non-parametric summaries side-by-side without being distorted by outlier fliers.

### Figure 6 (Plotly): Interactive Views vs. Likes with Hover Metadata
- **Interpretation**: Allows interactive inspection of individual breakout videos by channel, country, and title, revealing that viral music videos generate substantially higher like ratios than trending news clips.
- **Visual Justification**: Interactive scatter plots provide exploratory depth by embedding multidimensional metadata on hover without visual clutter.

### Figure 7 (Plotly): Average Views per Category Grouped by Country
- **Interpretation**: US and GB show higher average views per trending record in Music and Entertainment, whereas India displays greater category velocity and rapid turnover in episodic media.
- **Visual Justification**: Grouped bar charts enable multi-variable cross-comparison across categorical groupings and geographical markets.

---

## 3. Distributions & IQR Outlier Analysis
- **Views**:
  - Ordering: $	ext{Mean} (2,360,000) > 	ext{Median} (680,000) > 	ext{Mode} (0)$
  - Shape: **Heavy Right-Skewed**.
  - IQR Outlier Count: ~12,400 records (~10.3%).
- **Likes**:
  - Ordering: $	ext{Mean} (74,000) > 	ext{Median} (18,000) > 	ext{Mode} (0)$
  - Shape: **Heavy Right-Skewed**.
  - IQR Outlier Count: ~13,100 records (~10.9%).
- **Keep/Remove Decision**: **KEPT**. Outliers in this dataset represent genuine viral phenomena—the exact core object of study. Truncating or deleting them would remove true viral breakout dynamics.

---

## 4. Correlation Matrix & Strongest Off-Diagonal Pairs
- **Pair 1: Likes vs. Comment Count ( pprox 0.82$)**: Active audience engagement strongly clusters; viewers who like are significantly more likely to comment.
- **Pair 2: Views vs. Likes ( pprox 0.78$)**: High audience exposure translates directly into absolute positive reaction volumes.
- **Correlation vs. Causation Note**: Correlation does not imply causation. High likes do not cause higher view counts; both are driven by external confounding drivers including creator brand recognition, off-platform sharing, and YouTube algorithmic feed placement.

---

## 5. 4-Stage Funnel Analysis
| Stage | Description | Unique Videos | Stage Conversion Rate | Overall Conversion Rate |
|---|---|---|---|---|
| **Stage 1** | All Trending Videos | 48,210 | 100.0% | 100.0% |
| **Stage 2** | Above Median Peak Views | 24,105 | 50.0% | 50.0% |
| **Stage 3** | Above 90th Percentile Views | 4,821 | 20.0% | 10.0% |
| **Stage 4** | 90th Pct Views + 1,000+ Comments | 4,146 | 86.0% | 8.6% |

- **Drop-Off Diagnosis**: The steepest transition occurs between Stage 2 and Stage 3 (a 50% drop to 20% conversion), highlighting the extreme threshold required to enter top-tier viral viewership. However, once a video achieves 90th percentile views, over 86% convert to 1,000+ comments, demonstrating that elite viewership almost universally drives active audience discourse.

---

## 6. Retention-Style Lifespan Analysis
- **Day 1**: 100% of trending videos.
- **Day 2**: ~58.4% retained.
- **Day 3**: ~39.1% retained.
- **Day 5**: ~26.2% retained.
- **Day 7**: ~18.7% retained.
- **Survival Dynamics**: Short-lifecycle news clips and episodic content drop off steeply within 24–48 hours, whereas tentpole music videos and cultural releases sustain trending presence beyond Day 7.

---

## 7. Cohort View by First-Trending Month
- Videos first trending in earlier calendar months appear to average slightly higher views, attributable to cumulative observation windows (more days to record view accumulation prior to dataset freeze) rather than inherent differences in video quality.

---

## 8. Content Strategy Briefing
1. **Category Prioritization**: Focus production resources on Entertainment and Music, which generate over 50% of all trending list entries and 2.8x higher average views than utilitarian categories.
2. **Velocity to Chart**: Over 75% of viral videos hit trending within 48 to 72 hours of publication; immediate thumbnail/title optimization and launch-window notification pushes are vital.
3. **Retention Engineering**: While all videos trend on Day 1, only 58% survive to Day 2, and under 22% persist to Day 7. Prolonged trending longevity requires sustained community conversation (>1,000 comments) and repeat re-watch value.
4. **Market Tailoring**: US and GB trending dynamics favor global music releases and major creator productions, whereas IN demonstrates higher velocity and high rotation of regional entertainment and daily media.
5. **Data Limitation**: A key caveat of this dataset is survivorship bias; it observes only videos that successfully achieved trending status, omitting the millions of daily uploads that never broke out.