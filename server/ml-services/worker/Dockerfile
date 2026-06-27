FROM python:3.11-slim

WORKDIR /app

# Install Python dependencies
RUN pip install --no-cache-dir \
    pika==1.3.2 \
    python-dotenv==1.0.1 \
    requests==2.32.0 \
    psycopg2-binary==2.9.9 \
    Pillow==11.0.0

# Copy application
COPY . .

# Run worker
CMD ["python", "worker.py"]
