FROM deegree/deegree3-docker:latest

# Install git and clean up
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Copy your setup script into the container
COPY setup.sh /usr/local/bin/setup.sh

# Make the script executable
RUN chmod +x /usr/local/bin/setup.sh

# Set environment variables
# ENV SWI_DEEGREE_CONFIG_REPO="your-custom-repo-url"
# ENV SWI_DEEGREE_ADMIN_PWD="your-password"

# Run the setup script when the container starts
EXPOSE 8080
CMD ["/usr/local/bin/setup.sh"]