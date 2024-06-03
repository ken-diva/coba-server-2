# Gunakan base image Python yang sudah termasuk pip
FROM python:3.8

# Atur direktori kerja di dalam container
WORKDIR /app

# Salin file requirements.txt ke dalam container
COPY requirements.txt .

# Install dependensi aplikasi
RUN pip install --no-cache-dir -r requirements.txt

# Salin seluruh kode sumber aplikasi ke dalam container
COPY . .

# Tentukan port yang akan digunakan oleh aplikasi (ubah sesuai kebutuhan)
EXPOSE 1444

# Atur command untuk menjalankan aplikasi saat container dijalankan
CMD ["python", "app.py", "--port", "1444"]
