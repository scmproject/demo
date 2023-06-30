# Use a base image with Python installed
FROM python:3.9

# Set working directory inside the container
WORKDIR /app

# Copy the application code to the container
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir boto3

# Set environment variables (replace with your own values)
ENV AWS_ACCESS_KEY_ID=<your-access-key-id>
ENV AWS_SECRET_ACCESS_KEY=<your-secret-access-key>
ENV AWS_DEFAULT_REGION=<your-aws-region>

# Expose a port if needed
# EXPOSE 8080

# Run the application
CMD [ "python", "app.py" ]
