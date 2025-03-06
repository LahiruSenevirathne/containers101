# Base image
FROM python:3.9

# Copy app files
WORKDIR /app
COPY . /app

# Install dependencies
RUN pip install -r requirements.txt

# Run the application
CMD ["python", "app.py"]