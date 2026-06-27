FROM python:3.11-slim

WORKDIR /app

# Install Python dependencies
RUN pip install --no-cache-dir \
    pika==1.3.2 \
    python-dotenv==1.0.1 \
    requests==2.32.0 \
    python-dateutil==2.9.0 \
    psycopg2-binary==2.9.9

# Copy application
COPY . .

# Run worker
ENV PYTHONUNBUFFERED=1
CMD ["python", "worker.py"]
