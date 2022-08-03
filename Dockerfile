###########
# BUILDER #
###########

# Link to course 
# https://testdriven.io/blog/django-and-celery/

# Base Image
FROM python:3.9 as builder

# Install Requirements
COPY requirements.txt /
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /wheels -r requirements.txt


#########
# FINAL #
#########

# Base Image
FROM python:3.9-slim

# Create directory for the app user
RUN mkdir -p /app

# Create the app user
RUN groupadd app && useradd -g app app

WORKDIR /app

# Install Requirements
COPY --from=builder /wheels /wheels
COPY --from=builder requirements.txt .
RUN pip install --no-cache /wheels/*

# Copy in the Flask code
COPY . .

# Chown all the files to the app user
RUN chown -R app:app /app

# Change to the app user
USER app

# run server
CMD python manage.py runserver 0.0.0.0:8000