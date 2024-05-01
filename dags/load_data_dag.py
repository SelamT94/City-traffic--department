from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime
import pandas as pd
import sqlalchemy

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2024, 5, 1),
    'retries': 1,
}

def load_data_files():
    # Read the CSV file into a pandas DataFrame
    df_track = pd.read_csv("../data/traffic_city.csv")

    # Define the connection parameters
    connection_params = {
        "host": "localhost",
        "user": "postgres",
        "password": "postgres",
        "port": "5432",
        "database": "traffic_analysis"
    }

    # Define your database URL
    db_url = f"postgresql://{connection_params['user']}:{connection_params['password']}@{connection_params['host']}:{connection_params['port']}/{connection_params['database']}"

    # Create a SQLAlchemy engine
    engine = sqlalchemy.create_engine(db_url)

    # Load the DataFrame into PostgreSQL tables
    df_track.to_sql('track_table', engine, if_exists='replace', index=False)

# Define the DAG
with DAG('load_data_files_dag',
         default_args=default_args,
         schedule_interval=None,  # Set to None to disable automatic scheduling
         catchup=False  # Set to False to skip historic runs on first DAG execution
         ) as dag:

    # Define the PythonOperator to execute the load_data_files function
    load_data_task = PythonOperator(
        task_id='load_data_files_task',
        python_callable=load_data_files,
    )

