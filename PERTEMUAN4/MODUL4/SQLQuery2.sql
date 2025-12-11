-- Menampilkan semua data mahasiswa dan matakuliah
SELECT M.NamaMahasiswa, MK.NamaMK
FROM  Mahasiswa M
CROSS JOIN MataKuliah MK;

-- Menampilkan semua data dosen dan ruangan
SELECT D.NamaDosen, R.KodeRuangan
FROM Dosen D
CROSS JOIN Ruangan R;

-- LEFT JOIN
SELECT M.NamaMahasiswa, K.MataKuliahID
FROM Mahasiswa M
LEFT JOIN KRS K ON M.MahasiswaID = K.MahasiswaID;

-- Menggabungkan Nama MK dan Jadwal
SELECT M.NamaMK, J.Hari
FROM MataKuliah M
LEFT JOIN JadwalKuliah J ON M.MataKuliahID = J.MataKuliahID;

-- RIGHT JOIN
SELECT J.Hari, M.NamaMK
FROM JadwalKuliah J
RIGHT JOIN MataKuliah M ON J.MataKuliahID = M.MataKuliahID;

