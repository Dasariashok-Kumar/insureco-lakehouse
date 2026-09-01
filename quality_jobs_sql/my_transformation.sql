-- ============================================================
-- BRONZE: Ingest streaming claims via Auto Loader (cloud_files)
-- ============================================================

CREATE OR REFRESH STREAMING TABLE bronze_claims_dlt
COMMENT "Raw claim ingested incrementally from the landing volumne"
AS SELECT *
FROM cloud_files(
    '/Volumes/insurance_dev/raw_files/claims_stream/',
    'json'
);

-- ============================================================
-- SILVER: Clean + apply data quality constraints (EXPECTATIONS)
-- ============================================================
CREATE OR REFRESH STREAMING TABLE silver_claims_dlt (
    CONSTRAINT valid_claim_amount EXPECT (claim_amount > 0 ) ON VIOLATION DROP ROW,
    CONSTRAINT valid_claim_id EXPECT (claim_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT valid_claim_type EXPECT (claim_type IS NOT NULL)  -- warn only, don't drop
)
COMMENT "Cleaned claims with quality constraints enforced automatically"
AS SELECT DISTINCT *
FROM STREAM(bronze_claims_dlt);

-- ============================================================
-- GOLD: Business aggregate — materialized view, auto-refreshed
-- ============================================================
CREATE OR REFRESH MATERIALIZED VIEW gold_claims_summary_dlt
COMMENT "Claimd counts and total by status, auto-maintained by pipeline"
AS SELECT
    claim_status,
    COUNT(*) AS claim_count,
    SUM(claim_amount) AS total_amount
    FROM STREAM(silver_claims_dlt)
    GROUP BY claim_statuS;
