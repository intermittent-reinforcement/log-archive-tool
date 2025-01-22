#!/bin/bash

# Check if the log directory is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR=$1
ARCHIVE_DIR="${LOG_DIR}_archive"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
LOG_FILE="archive_log.txt"

# Ensure the log directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Log directory $LOG_DIR does not exist!"
    exit 1
fi

# Create the archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Create the tar.gz archive
echo "Compressing logs from $LOG_DIR..."
tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" -C "$LOG_DIR" .

# Check if the archive was created successfully
if [ $? -eq 0 ]; then
    echo "Archive created: $ARCHIVE_DIR/$ARCHIVE_NAME"
else
    echo "Error: Failed to create the archive!"
    exit 1
fi

# Log the archive creation
echo "[$(date)] Archive created: $ARCHIVE_DIR/$ARCHIVE_NAME" >> "$ARCHIVE_DIR/$LOG_FILE"

echo "Archive process completed successfully."

