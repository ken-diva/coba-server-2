# # # Gunakan base image Python yang sudah termasuk pip
# # FROM python:3.8

# # # Atur direktori kerja di dalam container
# # WORKDIR /app

# # # Salin file requirements.txt ke dalam container
# # COPY requirements.txt .

# # # Install dependensi aplikasi
# # RUN pip install --no-cache-dir -r requirements.txt

# # # Salin seluruh kode sumber aplikasi ke dalam container
# # COPY . .

# # # Tentukan port yang akan digunakan oleh aplikasi (ubah sesuai kebutuhan)
# # EXPOSE 1234

# # # Atur command untuk menjalankan aplikasi saat container dijalankan
# # CMD ["python", "app.py", "--port", "1234"]

# # Use a base Python image
# FROM python:3.9 AS builder

# # Set working directory
# WORKDIR /app

# # Copy requirements.txt to the working directory
# COPY requirements.txt .

# # Install dependencies
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy all other application files to the working directory
# COPY . .

# # Run the population script to populate the database
# RUN python populate_db.py

# # Use another base Python image for the final app container
# FROM python:3.9-slim

# # Set working directory
# WORKDIR /app

# # Copy only the necessary files from the builder stage
# COPY --from=builder /app .

# # Install Flask
# RUN pip install --no-cache-dir Flask

# # Tentukan port yang akan digunakan oleh aplikasi (ubah sesuai kebutuhan)
# EXPOSE 1444

# # Atur command untuk menjalankan aplikasi saat container dijalankan
# CMD ["python", "app.py", "--port", "1444"]

# Gunakan image dasar Python
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements.txt dan install dependencies
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy seluruh aplikasi Flask ke dalam container
COPY . /app/

# Expose port yang digunakan oleh Flask
EXPOSE 5000

# Jalankan aplikasi Flask
CMD ["python", "app.py", "--port", "1444"]
