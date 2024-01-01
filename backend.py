import mysql.connector

# enter in info to connect to database

# Host
hst = "127.0.0.1:3306"
# User
usr = "root"
# Password
psswrd = "temp"

# Connect to database
conn = mysql.connector.connect(
    host=hst,
    user=usr,
    password=psswrd
)

c = conn.cursor()

c.execute('use HawkEyeDatabase')