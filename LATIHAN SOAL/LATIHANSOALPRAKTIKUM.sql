CREATE DATABASE TokoBuku;
GO

USE TokoBuku;
GO

-- Tabel kategori buku
CREATE TABLE kategori (
    id_kategori INT IDENTITY(1,1) PRIMARY KEY,
    nama_kategori VARCHAR(50) NOT NULL UNIQUE
);
GO

-- Tabel buku
CREATE TABLE buku (
    id_buku INT IDENTITY(1,1) PRIMARY KEY,
    judul VARCHAR(100) NOT NULL,
    penulis VARCHAR(50),
    harga DECIMAL(12,2) NOT NULL CHECK (harga >= 0),
    id_kategori INT,
    CONSTRAINT fk_buku_kategori FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
);
GO

-- Tabel pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT IDENTITY(1,1) PRIMARY KEY,
    nama_pelanggan VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    telepon VARCHAR(20)
);
GO

-- Tabel penjualan (header transaksi)
CREATE TABLE penjualan (
    id_penjualan INT IDENTITY(1,1) PRIMARY KEY,
    id_pelanggan INT,
    tanggal DATE NOT NULL,
    CONSTRAINT fk_penjualan_pelanggan FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);
GO

-- Tabel detail penjualan (detail buku yg dibeli)
CREATE TABLE detail_penjualan (
    id_detail INT IDENTITY(1,1) PRIMARY KEY,
    id_penjualan INT,
    id_buku INT,
    jumlah INT NOT NULL CHECK (jumlah > 0),
    CONSTRAINT fk_detail_penjualan_penjualan FOREIGN KEY (id_penjualan) REFERENCES penjualan(id_penjualan),
    CONSTRAINT fk_detail_penjualan_buku FOREIGN KEY (id_buku) REFERENCES buku(id_buku)
);
GO

-- Insert data kategori
INSERT INTO kategori (nama_kategori) VALUES
('Novel'),
('Pelajaran'),
('Komik'),
('Referensi'),
('Biografi'),
('Sains'),
('Teknologi');
GO

-- Insert data buku
INSERT INTO buku (judul, penulis, harga, id_kategori) VALUES
('Laskar Pelangi', 'Andrea Hirata', 75000, 1),
('Matematika Dasar', 'Budi Santoso', 50000, 2),
('Naruto Vol. 1', 'Masashi Kishimoto', 40000, 3),
('Kamus Bahasa Indonesia', 'Tim Kamus', 60000, 4),
('Fisika Modern', 'Agus Wijaya', 80000, 2),
('Steve Jobs', 'Walter Isaacson', 90000, 5),
('Biologi Dasar', 'Sari Mulyani', 55000, 6),
('Pemrograman Python', 'Andi Saputra', 70000, 7);
GO

-- Insert data pelanggan
INSERT INTO pelanggan (nama_pelanggan, email, telepon) VALUES
('Andi', 'andi@mail.com', '08123456789'),
('Sari', 'sari@mail.com', '08198765432'),
('Budi', 'budi@mail.com', '08111222333'),
('Rina', 'rina@mail.com', '08999888777'),
('Tono', 'tono@mail.com', '08223344556');
GO

-- Insert data penjualan
INSERT INTO penjualan (id_pelanggan, tanggal) VALUES
(1, '2025-12-01'),
(2, '2025-12-02'),
(1, '2025-12-03'),
(4, '2025-12-04'),
(3, '2025-12-05');
GO

-- Insert data detail penjualan
INSERT INTO detail_penjualan (id_penjualan, id_buku, jumlah) VALUES
(1, 1, 1),  -- Andi beli 1 Laskar Pelangi
(1, 3, 2),  -- Andi beli 2 Naruto Vol.1
(2, 2, 1),  -- Sari beli 1 Matematika Dasar
(3, 5, 1),  -- Andi beli 1 Fisika Modern
(3, 4, 1),  -- Andi beli 1 Kamus Bahasa Indonesia
(4, 6, 1),  -- Rina beli 1 Steve Jobs
(4, 8, 2),  -- Rina beli 2 Pemrograman Python
(5, 7, 1);  -- Budi beli 1 Biologi Dasar
GO

-- Mulai Pengerjaan Soal 1
SELECT B.*, KB.nama_kategori
FROM buku B
JOIN kategori KB
ON B.id_kategori = KB.id_kategori;

-- Mulai Pengerjaan Soal 2
SELECT nama_pelanggan, email
FROM pelanggan
ORDER BY nama_pelanggan ASC; -- mengurutkan dari A-Z

-- Mulai Pengerjaan Soal 3
SELECT judul,harga
FROM buku
WHERE harga > 50000
ORDER BY harga DESC; -- mengurutkan dari termahal - termurah

-- Mulai Pengerjaan Soal 4
SELECT nama_kategori, COUNT(id_buku) AS jumlah_buku
FROM kategori K
JOIN buku B
ON K.id_kategori = B.id_kategori
GROUP BY K.nama_kategori;

-- Mulai Pengerjaan Soal 5
SELECT id_penjualan, nama_pelanggan, tanggal
FROM penjualan J
JOIN pelanggan P
ON J.id_pelanggan = P.id_pelanggan
WHERE tanggal = '2025-12-01';

-- Mulai Pengerjaan Soal 6
SELECT B.id_buku, B.judul ,SUM(jumlah) AS Total_Penjualan
FROM detail_penjualan DP
JOIN buku B
ON DP.id_buku = B.id_buku
GROUP BY B.id_buku, B.judul;

-- Mulai Pengerjaan Soal 7
CREATE TABLE Supplier (
id_supplier INT PRIMARY KEY IDENTITY(1,1),
nama_supplier VARCHAR(50) NOT NULL,
telepon VARCHAR(20)
);

-- Mulai Pengerjaan Soal 8
INSERT INTO Supplier (nama_supplier,telepon)
VALUES
('Nike', '08123456789'),
('Adidas', '08213465987'),
('Puma', '08312645978');

-- Mulai Pengerjaan Soal 9
PRINT 'Harga Naruto Vol.1 SEBELUM Update:';
SELECT harga
FROM buku
WHERE id_buku = 3;

BEGIN TRANSACTION;

UPDATE buku
SET harga = harga + 5000
WHERE id_buku = 3;

PRINT 'Harga Naruto Vol.1 SETELAH Update (Belum di-COMMIT):';
SELECT harga
FROM buku
WHERE id_buku = 3;

COMMIT TRANSACTION;

PRINT 'Harga Naruto Vol.1 setelah di COMMIT:';
SELECT harga
FROM buku
WHERE id_buku = 3;

-- Mulai Pengerjaan Soal 10
BEGIN TRANSACTION;

DELETE FROM detail_penjualan    -- Mendelete keterkaikan data pelanggan di penjualan
DELETE FROM penjualan   -- Mendelete keterkaitan data pelanggan
DELETE FROM pelanggan   -- Mendelete data pelanggan
WHERE nama_pelanggan = 'budi';

SELECT *
FROM pelanggan;

COMMIT TRANSACTION;