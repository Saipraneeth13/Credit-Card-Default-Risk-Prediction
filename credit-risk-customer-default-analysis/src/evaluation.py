"""
src/evaluation.py
Model Evaluation, Threshold Analysis, and Fairness Audit Utility.
"""
import pandas as pd
from sklearn.metrics import (
    accuracy_score, precision_score, recall_score, f1_score,
    roc_auc_score, average_precision_score, confusion_matrix
)
from src.train_model import train_and_save_models


def evaluate_models():
    fitted, X_test, y_test = train_and_save_models()
    rows = []
    for name, pipe in fitted.items():
        y_prob = pipe.predict_proba(X_test)[:, 1]
        y_pred = (y_prob >= 0.50).astype(int)
        rows.append({
            "Model": name,
            "Accuracy": round(accuracy_score(y_test, y_pred), 4),
            "Precision": round(precision_score(y_test, y_pred), 4),
            "Recall": round(recall_score(y_test, y_pred), 4),
            "F1_Score": round(f1_score(y_test, y_pred), 4),
            "ROC_AUC": round(roc_auc_score(y_test, y_prob), 4),
            "PR_AUC": round(average_precision_score(y_test, y_prob), 4),
        })
    metrics_df = pd.DataFrame(rows)
    print(metrics_df.to_string(index=False))

    # Threshold optimization (0.35) on Gradient Boosting
    gb_probs = fitted["Gradient Boosting"].predict_proba(X_test)[:, 1]
    gb_preds_35 = (gb_probs >= 0.35).astype(int)
    print("\nGradient Boosting Confusion Matrix @ Threshold 0.35:")
    print(confusion_matrix(y_test, gb_preds_35))


if __name__ == "__main__":
    evaluate_models()
