"""
src/train_model.py
Phase 6: Leak-Free Predictive Modeling Pipeline for Next-Month Default Risk.
"""
import os
import joblib
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier


def train_and_save_models(data_path: str = "data/processed/credit_card_default_features.csv"):
    df = pd.read_csv(data_path)

    # Exclude ID, target, human-readable text labels, and sensitive attribute SEX
    drop_cols = [
        "ID", "DEFAULT_NEXT_MONTH", "SEX", "SEX_LABEL",
        "EDUCATION_LABEL", "MARRIAGE_LABEL", "Age_Group", "Credit_Limit_Tier"
    ]
    feature_cols = [c for c in df.columns if c not in drop_cols]

    X = df[feature_cols]
    y = df["DEFAULT_NEXT_MONTH"]

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.20, random_state=42, stratify=y
    )

    cat_features = ["EDUCATION", "MARRIAGE"]
    num_features = [c for c in feature_cols if c not in cat_features]

    preprocessor = ColumnTransformer(
        transformers=[
            ("num", StandardScaler(), num_features),
            ("cat", OneHotEncoder(drop="first", handle_unknown="ignore"), cat_features),
        ]
    )

    models = {
        "Logistic Regression": LogisticRegression(max_iter=1000, class_weight="balanced", random_state=42),
        "Decision Tree": DecisionTreeClassifier(max_depth=6, min_samples_leaf=50, class_weight="balanced", random_state=42),
        "Random Forest": RandomForestClassifier(n_estimators=200, max_depth=10, min_samples_leaf=20, class_weight="balanced", random_state=42, n_jobs=-1),
        "Gradient Boosting": GradientBoostingClassifier(n_estimators=150, learning_rate=0.05, max_depth=4, random_state=42),
    }

    fitted = {}
    for name, clf in models.items():
        pipe = Pipeline([("prep", preprocessor), ("clf", clf)])
        pipe.fit(X_train, y_train)
        fitted[name] = pipe

    os.makedirs("models", exist_ok=True)
    joblib.dump(fitted["Gradient Boosting"], "models/gradient_boosting_credit_risk.joblib")
    print("Saved champion model -> models/gradient_boosting_credit_risk.joblib")
    return fitted, X_test, y_test


if __name__ == "__main__":
    train_and_save_models()
