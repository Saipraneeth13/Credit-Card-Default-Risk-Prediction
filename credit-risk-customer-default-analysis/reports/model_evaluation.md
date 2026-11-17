# Predictive Model Evaluation & Fairness Report

## Test Set Performance (`n = 6,000`, Stratified 20% Split)
| Model | Accuracy | Precision | Recall | F1-Score | ROC-AUC | PR-AUC |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| Logistic Regression | 0.7412 | 0.4380 | 0.6014 | 0.5068 | 0.7456 | 0.4985 |
| Decision Tree | 0.7445 | 0.4446 | 0.6232 | 0.5190 | 0.7680 | 0.5299 |
| Random Forest | 0.7672 | 0.4793 | 0.6104 | 0.5370 | 0.7787 | 0.5566 |
| Gradient Boosting (t=0.50) | 0.8167 | 0.6548 | 0.3617 | 0.4660 | 0.7815 | 0.5572 |
| **Gradient Boosting (t=0.35)** | **0.8068** | **0.5745** | **0.4883** | **0.5279** | **0.7815** | **0.5572** |

## Business Threshold & Fairness Governance
- **Threshold Selection (`0.35`):** Lowering the decision threshold from `0.50` to `0.35` boosts default recall from **36.2%** to **48.8%** (capturing 648 of 1,327 test defaults) while maintaining **57.5%** precision.
- **Fairness Safeguard:** Sensitive demographic attribute `SEX` was explicitly excluded from model training features to prevent direct gender-based lending bias.
