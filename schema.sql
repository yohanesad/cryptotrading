-- ============================================
-- TRADING JOURNAL — SUPABASE SQL SCHEMA
-- Jalankan di: Supabase Dashboard → SQL Editor
-- ============================================

-- 1. Settings (modal & preferensi user)
CREATE TABLE IF NOT EXISTS tj_settings (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id     TEXT NOT NULL DEFAULT 'default',
  modal       NUMERIC DEFAULT 0,
  created_at  TIMESTAMPTZ DEFAULT now(),
  updated_at  TIMESTAMPTZ DEFAULT now()
);

-- 2. Trades
CREATE TABLE IF NOT EXISTS tj_trades (
  id                BIGSERIAL PRIMARY KEY,
  user_id           TEXT NOT NULL DEFAULT 'default',
  date              TIMESTAMPTZ DEFAULT now(),
  pair              TEXT NOT NULL,
  direction         TEXT NOT NULL CHECK (direction IN ('LONG','SHORT')),
  entry_price       NUMERIC NOT NULL,
  stop_loss         NUMERIC NOT NULL,
  take_profit       NUMERIC,
  leverage          NUMERIC DEFAULT 1,
  position_size     NUMERIC,
  timeframe         TEXT,
  setup             TEXT,
  market_condition  TEXT,
  sentiment         TEXT,
  notes             TEXT,
  status            TEXT DEFAULT 'OPEN' CHECK (status IN ('OPEN','CLOSED')),
  result            TEXT CHECK (result IN ('WIN','LOSS','BE') OR result IS NULL),
  exit_price        NUMERIC,
  pnl               NUMERIC,
  reflection        TEXT,
  created_at        TIMESTAMPTZ DEFAULT now(),
  updated_at        TIMESTAMPTZ DEFAULT now()
);

-- 3. Screening harian
CREATE TABLE IF NOT EXISTS tj_screening (
  id                   BIGSERIAL PRIMARY KEY,
  user_id              TEXT NOT NULL DEFAULT 'default',
  date                 TIMESTAMPTZ DEFAULT now(),
  btc_setup            TEXT,
  btc_dominance_trend  TEXT,
  us_premarket         TEXT,
  funding_rate         TEXT,
  open_interest        TEXT,
  long_short_ratio     TEXT,
  market_signal        TEXT,
  notes                TEXT,
  pairs_watchlist      JSONB DEFAULT '[]',
  created_at           TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- INDEX untuk performa query
-- ============================================
CREATE INDEX IF NOT EXISTS idx_trades_user    ON tj_trades(user_id);
CREATE INDEX IF NOT EXISTS idx_trades_date    ON tj_trades(date DESC);
CREATE INDEX IF NOT EXISTS idx_trades_status  ON tj_trades(status);
CREATE INDEX IF NOT EXISTS idx_screening_date ON tj_screening(date DESC);

-- ============================================
-- RLS — aktifkan kalau ingin multi-user
-- (opsional untuk single user / personal use)
-- ============================================
-- ALTER TABLE tj_trades    ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE tj_settings  ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE tj_screening ENABLE ROW LEVEL SECURITY;
