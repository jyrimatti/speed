create table ping_high    (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table ping_jitter  (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table ping_latency (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table ping_low     (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);

create table download_bandwidth      (instant INTEGER PRIMARY KEY, measurement INTEGER NOT NULL);
create table download_bytes          (instant INTEGER PRIMARY KEY, measurement INTEGER NOT NULL);
create table download_elapsed        (instant INTEGER PRIMARY KEY, measurement INTEGER NOT NULL);
create table download_latency_high   (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table download_latency_iqm    (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table download_latency_jitter (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table download_latency_low    (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);

create table upload_bandwidth      (instant INTEGER PRIMARY KEY, measurement INTEGER NOT NULL);
create table upload_bytes          (instant INTEGER PRIMARY KEY, measurement INTEGER NOT NULL);
create table upload_elapsed        (instant INTEGER PRIMARY KEY, measurement INTEGER NOT NULL);
create table upload_latency_high   (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table upload_latency_iqm    (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table upload_latency_jitter (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table upload_latency_low    (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
