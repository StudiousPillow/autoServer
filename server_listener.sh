#!/bin/bash
source params.sh ## to import the PORT and SCREEN_NAME

# Function to check if a screen session is running
is_screen_running() {
    screen -ls | grep -q "\b$1\b"
}

# Listen for incoming SSH connections
while true; do
    ## otherwise execute the given command
    echo "Listening on port $LISTEN_PORT..."
    nc -l -p $LISTEN_PORT | while read line; do
        # Execute the received command
        screen -S $SCREEN_NAME -X stuff "$line$(printf \\r)"
    done
done