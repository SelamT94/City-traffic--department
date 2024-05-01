from sqlalchemy import ForeignKey, create_engine, MetaData, Table, Column, Integer, Float, String

def setup_database(db_url):
    # Create SQLAlchemy engine
    engine = create_engine(db_url)
    
    # Create a metadata object
    metadata = MetaData()

    # Define table names
    track_table_name = 'track_table'
    trajectory_table_name = 'trajectory_table'

    # Define Track table schema
    track_table = Table(
        track_table_name,
        metadata,
        Column('id', Integer, primary_key=True),
        Column('track_id', String),
        Column('type', String),
        Column('traveled_d', Float),
        Column('avg_speed', Float)
    )

    # Define Trajectory table schema
    trajectory_table = Table(
        trajectory_table_name,
        metadata,
        Column('id', Integer, primary_key=True),
        Column('track_id', String, ForeignKey('track_table.track_id')),
        Column('lat', Float),
        Column('lon', Float),
        Column('speed', Float),
        Column('lon_acc', Float),
        Column('lat_acc', Float),
        Column('time', Float)
    )

    # Create tables in the database
    metadata.create_all(engine)

    # Close the database connection
    engine.dispose()
