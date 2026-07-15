"""
Database Engine
Handles connections and queries to various databases (SQLite, SQL Server, etc.).
Uses SQLAlchemy for robust database interaction.
"""

import pandas as pd
from sqlalchemy import create_engine, text

def run_sqlite_query(db_filepath, query_str):
    """
    Connects to a SQLite database file and executes the given SQL query.
    Returns the results as a pandas string and the row count.
    """
    try:
        # Create SQLite connection string
        # format: sqlite:///C:/path/to/database.db
        connection_url = f"sqlite:///{db_filepath}"
        engine = create_engine(connection_url)
        
        # Execute the query using pandas for easy tabular formatting
        with engine.connect() as conn:
            # We use text() to safely execute raw SQL
            df = pd.read_sql_query(text(query_str), conn)
            
        row_count = len(df)
        
        # Return a string representation of the dataframe (max 10 rows for GUI preview)
        result_string = df.head(10).to_string()
        if row_count > 10:
            result_string += f"\n\n... and {row_count - 10} more rows."
            
        return True, f"Query executed successfully.\nRow Count: {row_count}\n\nPreview:\n{result_string}"
        
    except Exception as e:
        return False, f"Error executing query: {str(e)}"
