import pyodbc

# 1. Update these to match your SSMS login
# If your server name in SSMS is LAPTOP-123\SQLEXPRESS, use: 'LAPTOP-123\\SQLEXPRESS'
server = 'LOQ\SQLEXPRESS' 
database = 'CustomerTransactionDB' # Your database name

connection_string = (
    f'DRIVER={{ODBC Driver 17 for SQL Server}};'
    f'SERVER={server};'
    f'DATABASE={database};'
    f'Trusted_Connection=yes;'
)

try:
    print(f"⏳ Attempting to connect to {server}...")
    conn = pyodbc.connect(connection_string)
    
    # Create a cursor to run a tiny test query
    cursor = conn.cursor()
    cursor.execute("SELECT @@VERSION")
    row = cursor.fetchone()
    
    print("✅ CONNECTION SUCCESSFUL!")
    print(f"Connected to: {row[0]}")
    
    conn.close()
    
except Exception as e:
    print("❌ CONNECTION FAILED")
    print(f"Error Message: {e}")
    print("\n💡 TIP: Check if your Server Name has a double backslash (\\\\) in Python!")