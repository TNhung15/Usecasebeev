# Sử dụng một hình ảnh Python cơ bản
FROM python:3.9

# Thiết lập thư mục làm việc
WORKDIR /app

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Sao chép tất cả các file trong thư mục hiện tại vào thư mục /app trong container
COPY . /app

# Cài đặt thư viện pandas (nếu có)
RUN pip install pandas

# Chạy script.py khi container được khởi động
CMD ["python", "read_csv_script.py"]