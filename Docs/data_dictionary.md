# InsureCo Data Dictionary

## customers
| Column | Type | Description |
|---|---|---|
| customer_id | string | Unique customer identifier (CUSTxxxxxx) |
| name | string | Full name |
| dob | date | Date of birth |
| gender | string | M / F |
| city | string | City of residence |
| state | string | State code |
| signup_date | date | Date customer joined InsureCo |

## policies
| Column | Type | Description |
|---|---|---|
| policy_id | string | Unique policy identifier (POLxxxxxx) |
| customer_id | string | FK to customers |
| agent_id | string | FK to agents |
| policy_type | string | Auto / Health / Life / Home |
| start_date | date | Policy start date |
| end_date | date | Policy end date |
| premium_amount | int | Annual premium in currency units |
| status | string | Active / Expired / Cancelled |

## claims
| Column | Type | Description |
|---|---|---|
| claim_id | string | Unique claim identifier (CLMxxxxxx) |
| policy_id | string | FK to policies |
| claim_date | date | Date claim was filed |
| claim_amount | int | Amount claimed |
| claim_type | string | Type of claim (varies by policy_type) |
| claim_status | string | Filed / UnderReview / Approved / Rejected |
| fraud_flag | boolean | Whether flagged as potentially fraudulent |

## premium_payments
| Column | Type | Description |
|---|---|---|
| payment_id | string | Unique payment identifier (PAYxxxxxxx) |
| policy_id | string | FK to policies |
| payment_date | date | Date payment was made |
| amount | int | Payment amount |
| payment_mode | string | CreditCard / NetBanking / AutoDebit / UPI / Cheque |
| is_late | boolean | Whether payment was made after due date |

## underwriting_risk
| Column | Type | Description |
|---|---|---|
| policy_id | string | FK to policies |
| risk_score | int | 0-100 risk score |
| risk_category | string | Low / Medium / High |
| evaluated_date | date | Date risk was assessed |

## agents
| Column | Type | Description |
|---|---|---|
| agent_id | string | Unique agent identifier (AGTxxxx) |
| name | string | Agent full name |
| branch | string | Branch office name |
| region | string | North / South / East / West |
| hire_date | date | Date agent was hired |