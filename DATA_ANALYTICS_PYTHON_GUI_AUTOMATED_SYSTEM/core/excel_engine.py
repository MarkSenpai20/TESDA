"""
Excel Engine
Handles interactive loading, cleaning, and saving of Excel files.
"""

import pandas as pd
import os

def load_data(filepath):
    """Loads an Excel file securely and returns a pandas DataFrame."""
    try:
        df = pd.read_excel(filepath)
        return df, "Data loaded successfully."
    except Exception as e:
        return None, f"Error loading file: {e}"

def action_drop_empty(df):
    """Safely removes completely empty rows and columns."""
    try:
        df_new = df.copy()
        df_new.dropna(how='all', inplace=True)
        df_new.dropna(axis=1, how='all', inplace=True)
        df_new.reset_index(drop=True, inplace=True)
        return df_new, "Empty rows and columns removed."
    except Exception as e:
        return df, f"Error: {e}"

def action_clean_headers(df):
    """Standardizes column names (uppercase, strip, replace space with underscore)."""
    try:
        df_new = df.copy()
        df_new.columns = [str(col).strip().upper().replace(" ", "_") for col in df_new.columns]
        return df_new, "Headers cleaned."
    except Exception as e:
        return df, f"Error: {e}"

def save_data(df, filepath):
    """Saves the DataFrame to the specified filepath."""
    try:
        df.to_excel(filepath, index=False)
        return True, f"Success! Saved to {filepath}"
    except Exception as e:
        return False, f"Error saving file: {e}"
