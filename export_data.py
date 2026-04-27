import pandas as pd
import pyodbc
import warnings

# This hides a small technical warning that doesn't affect your CSV
warnings.filterwarnings('ignore')

# 1. Your connection details (Same as your test_connection.py)
server = 'LOQ\SQLEXPRESS' 
database = 'CustomerTransactionDB' # <--- IMPORTANT: Double check this name in SSMS!

connection_string = (
    f'DRIVER={{ODBC Driver 17 for SQL Server}};'
    f'SERVER={server};'
    f'DATABASE={database};'
    f'Trusted_Connection=yes;'
)

try:
    print("⏳ Connecting to SQL Express...")
    conn = pyodbc.connect(connection_string)
    
    # 2. List all tables you want to export
    tables_to_export = [
        'orders',
        'customers',
        'order_items',
        'products',
        'payments'
        # Add more table names here as needed
    ]
    
    print(f"📊 Extracting data from {database}...")
    
    # 3. Loop through each table and export
    for table_name in tables_to_export:
        try:
            query = f"SELECT * FROM {table_name}"
            df = pd.read_sql(query, conn)
            
            # 4. Save to your project folder
            csv_filename = f"{table_name}_export.csv"
            df.to_csv(csv_filename, index=False)
            
            print(f"✅ Created '{csv_filename}' - {len(df)} rows exported")
        
        except Exception as table_error:
            print(f"⚠️  Could not export '{table_name}': {table_error}")
    
    print("\n🎉 All exports completed!")
    conn.close()

except Exception as e:
    print(f"❌ ERROR: {e}")
    print("\n💡 Double check if your database name is correct in SSMS.")