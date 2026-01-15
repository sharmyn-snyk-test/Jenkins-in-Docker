# Using the specific LTS version required by your plugins (2.479.1)
# Switching to JDK 17 as it is the current standard for modern Jenkins features
FROM jenkins/jenkins:2.479.1-lts-jdk17

# Switch to root to install system packages
USER root

# Install required dependencies for Docker-in-Docker (if needed) and lsb-release
RUN apt-get update && apt-get install -y lsb-release ca-certificates curl gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && apt-get install -y docker-ce-cli

# Switch back to the jenkins user
USER jenkins

# Copy your plugin list into the image
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt

# Run the plugin installer
# This step was failing because the base image was too old for these plugins
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
