# Part 1: Python Foundations

## Overview
Ingestion, cleaning, and rule-based classification using core Python.

## Data Scope & Trimming
- Uses US, GB, IN datasets.
- Dropped verbose text columns (description, tags, thumbnail) to stay under 100MB.

## Data Structures
- Lists of dicts for flexible row access
- Tuples for immutable snapshots
- Sets for country overlap/difference
- Dicts for frequencies

## Classification Thresholds
- Viral Hit: views >= 1M and like_ratio >= 0.90
- Divisive: like_ratio < 0.70 and reactions >= 1000
- Steady Performer: views >= 100k
- Low Engagement: all others
- Unrated: ratings disabled or 0 reactions
