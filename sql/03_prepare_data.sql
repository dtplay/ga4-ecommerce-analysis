-- 1. Custom session identifier
ALTER TABLE ga4_ecommerce 
ADD COLUMN IF NOT EXISTS custom_session_id TEXT;

-- Combines user_pseudo_id and event_params_ga_session_id for unique session tracking
UPDATE ga4_ecommerce 
SET custom_session_id = CONCAT(user_pseudo_id, '_',
                               CAST(event_params_ga_session_id AS TEXT))
WHERE custom_session_id IS NULL;

-- Index for session-level analysis
CREATE INDEX IF NOT EXISTS idx_custom_session_id
ON ga4_ecommerce(custom_session_id);

-- 2. Clean missing placeholder values for items
-- Replace '(not set)' with NULL for item id/name
UPDATE ga4_ecommerce
SET 
    items_item_id = NULL,
    items_item_name = NULL
WHERE items_item_id = '(not set)' 
   OR items_item_name = '(not set)';
   
-- 3. Optimize event_date data type
-- Convert event_date as DATE instead of TEXT (YYYYMMDD)
ALTER TABLE ga4_ecommerce 
ALTER COLUMN event_date TYPE DATE
USING event_date::TEXT::DATE;

-- Index for time-based queries
CREATE INDEX IF NOT EXISTS idx_event_date 
ON ga4_ecommerce(event_date);

-- 4. Additional performance indexes
-- Filter by event_name (e.g. purchase events)
CREATE INDEX IF NOT EXISTS idx_event_name
ON ga4_ecommerce(event_name);

-- Traffic source analysis (composite of source + medium)
CREATE INDEX IF NOT EXISTS idx_traffic_source
ON ga4_ecommerce(traffic_source_source, traffic_source_medium);

-- User-level analysis by pseudo id
CREATE INDEX IF NOT EXISTS idx_user_pseudo_id
ON ga4_ecommerce(user_pseudo_id);
