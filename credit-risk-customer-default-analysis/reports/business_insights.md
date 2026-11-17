# Statistical Findings & Actionable Credit Risk Recommendations

## Key Empirical Findings
1. **Recent Delinquency is the Primary Risk Signal:** Customers on time in September (`PAY_1 <= 0`) default at **12.8%–16.8%**, whereas customers 1 month late (`PAY_1 = 1`) jump to **33.9%**, and 2+ months late (`PAY_1 >= 2`) surge to **69.1%–75.8%**.
2. **Chronic Delinquency Compounds Risk:** Default rates rise monotonically with the number of delayed months in a 6-month window: **11.7%** (0 delays) $\rightarrow$ **29.8%** (1 delay) $\rightarrow$ **50.9%** (3 delays) $\rightarrow$ **70.3%** (6 delays).
3. **Credit Limit & Utilization Divergence:** Defaulters carry significantly lower average credit limits (**NT$ 130,110** vs **NT$ 178,100**; Mann-Whitney $U$ $p = 1.23 \times 10^{-189}$) and higher credit utilization (**49.0%** vs **40.5%**; $p = 1.49 \times 10^{-36}$). Low-limit accounts (`<=50K`) experience a **31.8%** default rate vs **13.3%** for Premium accounts (`>300K`).
4. **Payment Stagnation Among Defaulters:** While non-defaulters increased average monthly payments from NT$ 5,713 (Apr) to NT$ 6,300 (Sep) as bills grew, defaulters' payments remained flat around **NT$ 3,150–3,450/month** despite rising balances.

## Actionable Recommendations
1. **Early-Intervention Triggers at First Missed Payment (`PAY_1 = 1`):** Deploy automated SMS/app payment reminders and flexible minimum-payment restructuring immediately upon a single 1-month delay, before accounts roll into 2-month delinquency where default risk exceeds 69%.
2. **Behavioral Watchlist for Repeat Delayers (`Delayed_Payment_Count >= 2`):** Flag accounts with 2 or more delayed cycles in 6 months for proactive credit limit freezes or temporary line reductions to cap exposure.
3. **Utilization & Payment-Stagnation Alerts:** Monitor accounts combining high utilization (`>75%`) with declining `Payment_to_Bill_Ratio` (`<10%`) for early collections outreach.
