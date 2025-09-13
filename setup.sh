#!/bin/bash

# Define the target directory
TARGET_DIR="/root/.deegree"
DATA_DIR="/root/data"

# Set default repository if SWI_DEEGREE_CONFIG_REPO is not defined
REPO_URL=${SWI_DEEGREE_CONFIG_REPO:-"https://github.com/UNIS-Svalbard-Weather-Information/swi-deegree3-configuration.git"}

# Check if the directory is empty
if [ -z "$(ls -A "$TARGET_DIR")" ]; then
    echo "Directory $TARGET_DIR is empty. Cloning repository..."
    # Clone the repository as 'swi' folder
    git clone "$REPO_URL" "$TARGET_DIR/swi"

    # Check if SWI_DEEGREE_ADMIN_PWD environment variable exists
    if [ -n "$SWI_DEEGREE_ADMIN_PWD" ]; then
        echo "SWI_DEEGREE_ADMIN_PWD is set. Creating console.pw file..."
        echo "$SWI_DEEGREE_ADMIN_PWD" > "$TARGET_DIR/console.pw"
    else
        echo "SWI_DEEGREE_ADMIN_PWD is not set. Skipping console.pw creation."
    fi

    # Check if SWI_DEEGREE_ADMIN_PWD environment variable exists
    if [ -n "$SWI_DEEGREE_REST_API_KEY" ]; then
        echo "SWI_DEEGREE_REST_API_KEY is set. Creating console.pw file..."
        echo "$SWI_DEEGREE_REST_API_KEY" > "$TARGET_DIR/config.apikey"
    else
        echo "SWI_DEEGREE_REST_API_KEY is not set. Skipping console.pw creation."
    fi

    # Ensure target directories exist
    mkdir -p "$DATA_DIR/themes/"

    # Move files
    mv "$TARGET_DIR"/swi/themes/* "$DATA_DIR/themes/"

    # Create symbolic links
    for file in "$DATA_DIR"/themes/*; do
        ln -s "$file" "$TARGET_DIR/swi/themes/"
    done

    # Create webapps.properties file
    echo "Creating webapps.properties file..."
    echo "/deegree-webservices=swi" > "$TARGET_DIR/webapps.properties"
    echo "Setup completed."
else
    echo "Directory $TARGET_DIR is not empty. Skipping setup."
fi

# Change directory and run Tomcat
cd /usr/local/tomcat/webapps/ || exit
echo "Starting Tomcat..."
exec catalina.sh run
