# Use the official Python image as the base image
FROM python:3.7

# Install virtualenv and create a virtual environment
RUN pip install virtualenv
ENV VIRTUAL_ENV=/venv
RUN virtualenv $VIRTUAL_ENV -p python3
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Update the package list and install ffmpeg
RUN apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*

# Expose port 8501
ENV PORT 8501

# Run the application
CMD ["streamlit", "run", "app.py"]
