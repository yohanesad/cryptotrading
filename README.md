# Trading Journal — Setup Guide

## Stack
- Frontend: HTML/CSS/JS murni (zero dependency kecuali Supabase JS SDK)
- Backend/DB: Supabase (PostgreSQL)
- Hosting: Vercel / Netlify (drag & drop folder)

---

## Langkah 1 — Setup Supabase

1. Login ke https://supabase.com dan buka project kamu
2. Pergi ke **SQL Editor** → klik **New Query**
3. Copy seluruh isi file `schema.sql` → paste → klik **Run**
4. Verifikasi 3 tabel terbuat: `tj_settings`, `tj_trades`, `tj_screening`

---

## Langkah 2 — Ambil Credentials

1. Di Supabase, pergi ke **Project Settings → API**
2. Copy:
   - **Project URL** → contoh: `https://abcdefgh.supabase.co`
   - **anon / public key** → string panjang dimulai `eyJ...`

---

## Langkah 3 — Deploy ke Vercel

### Opsi A: Drag & Drop (paling mudah)
1. Buka https://vercel.com/new
2. Klik "Browse" dan upload folder `trading-journal/`
3. Klik Deploy — selesai, dapat URL gratis

### Opsi B: Via GitHub
1. Push folder ke repo GitHub
2. Connect repo di Vercel → auto-deploy

---

## Langkah 4 — Koneksi Supabase

1. Buka website yang sudah di-deploy
2. Klik tombol **⚙ Setup** di kanan atas
3. Masukkan Supabase URL dan Anon Key
4. Klik **Sambungkan** — dot hijau = berhasil

---

## Catatan Keamanan

- Anon key Supabase aman untuk dipakai di frontend (public key)
- Untuk single-user personal: tidak perlu aktifkan RLS
- Kalau mau share ke orang lain: aktifkan RLS di schema.sql (uncomment bagian bawah)

---

## Fitur

| Tab | Fungsi |
|-----|--------|
| Dashboard | Ringkasan modal, win rate, P&L, status harian |
| Screening | Market analysis sebelum pilih pair |
| Entry | Form trade baru + kalkulator risiko real-time |
| History | Semua trade, filter, tutup posisi |
| Pre-Trade | Checklist 12 poin wajib sebelum entry |

## Alur yang Disarankan

```
Setiap hari sebelum trading:
1. Tab Screening → isi semua indikator → lihat sinyal
2. Tab Pre-Trade → centang semua 12 checklist
3. Tab Entry → isi form, cek kalkulator risiko
4. Tab History → tutup posisi yang sudah hit TP/SL
```
