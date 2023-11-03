#!/bin/bash

# Start MySQL server
mysqld --skip-log-error &

# Wait for MySQL server to start
sleep 10

# Run the initialization script
/create_db.sh
echo "Creating database: ${DB_NAME}"
# Keep the container running
tail -f /dev/null