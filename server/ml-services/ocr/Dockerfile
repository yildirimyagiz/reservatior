FROM python:3.11-slim

WORKDIR /app

# Install system dependencies for OCR
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-eng \
    libtesseract-dev \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    pika==1.3.2 \
    pytesseract==0.3.10 \
    Pillow==11.0.0 \
    pdf2image==1.17.0 \
    python-dotenv==1.0.1 \
    requests==2.32.0

# Copy application
COPY . .

# Create directories
RUN mkdir -p /app/documents /app/processed

# Run worker
ENV PYTHONUNBUFFERED=1
CMD ["python", "worker.py"]
