# Base image
FROM python:3.9

# Copy app files
WORKDIR /app
COPY app.py app.py
COPY config.yaml config.yaml
COPY requirements.txt requirements.txt

# Install dependencies
RUN pip install -r requirements.txt

# Run the application
CMD ["python", "app.py"]