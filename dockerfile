# Set default ARG variables for version and tags. Note that these Build Arguments can be overriden by jenkin parameters when launch pipeline
ARG PYTHON_BASE_VERSION=3.11-slim
ARG APP_VERSION=1.0.0


# STAGE PYTHON BASE
#-------------------------
# Step 1: Use an official Python runtime as a base image
# Named this stage as pythonBaseStage for reusable purpose
# The version of this python base image can override the default value (PYTHON_BASE_VERSION=3.11-slim) by using the '--build-arg' flag with docker build command
FROM python:${PYTHON_BASE_VERSION} AS pythonBaseStage


# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Install any needed dependencies specified in requirements.txt
# Note that the requirements.txt can be passed on Jenkin console with the 'build with parameters' option. For more information about this, refer to the userguide document
# If not passed, the default requirements.txt file will be used
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt


# Step 4: Copy the app.py into the container
# This step is placed after the dependencies installation step (step 3), so that every change to code wont make docker to install dependencies again, instead, it keeps the cache layer
COPY app/app.py /app

# Step 5: Expose the port which the app runs on.
EXPOSE 5000

# Step 6: Run the Flask app
CMD ["python", "app.py"]


#------------------------------------------------------
# Set metadata labels for better control and information
LABEL version="1.0"
LABEL description="Flask web application container"
LABEL maintainer="DevopsX@example.com"
LABEL repository="https://github.com/this-repo/flask-almanac"
