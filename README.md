## To do

- Fix 'Record Transaction' button on hover
- Remove 'Search' from DashboardLayout on user#edit
- Add 'Learn more' page
- Remove forgot password and registration link
- Use icons for categories

## Rails 8 + Fly.io projects disclaimer
-	Rails only uses DATABASE_URL if it’s set, and ignores database.yml.
- Fly’s default DATABASE_URL points to `/data/production.sqlite3`, but by default **database.yml** points to `/data/db/production.sqlite3` for the primary DB.

### Fix - Before deploying
- Fix DATABASE_URL in `fly.toml` to:
  ```
  DATABASE_URL="sqlite3:///data/db/production.sqlite3"
  ```
- Just to future-proof, (it won't be used if DATABASE_URL is set) configure database.yml to:
  ```
  production:
  primary:
    database: /data/db/production.sqlite3
  cache:
    database: /data/db/production_cache.sqlite3
  queue:
    database: /data/db/production_queue.sqlite3
  cable:
    database: /data/db/production_cable.sqlite3
  ```
