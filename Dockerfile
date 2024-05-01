# Use an official Airflow image as a parent image
FROM apache/airflow:2.2.3

# Install any additional dependencies you may need
RUN pip install pandas sqlalchemy psycopg2-binary

# Create a directory for your DAGs
RUN mkdir /opt/airflow/dags

# Copy your Python script containing the DAG definition into the container
COPY load_data_files.py /opt/airflow/dags/load_data_dag.py

# Set the Airflow home directory environment variable
ENV AIRFLOW_HOME=/opt/airflow

# Change the ownership of the DAGs directory to the user "airflow"
RUN chown -R airflow: /opt/airflow

# Expose the ports
EXPOSE 8080 5555 8793

# Start the Airflow web server
CMD ["airflow", "webserver", "--port", "8080"]
