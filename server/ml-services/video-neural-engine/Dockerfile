FROM python:3.10-slim

# Install FFMPEG
RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8005

CMD ["python", "app.py"]
