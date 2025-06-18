# Jenkins in Docker with Snyk Integration

This project provides a fully containerized Jenkins environment using Docker Compose. It includes a custom Jenkins image with the Docker CLI and Snyk CLI pre-installed, along with the Blue Ocean plugin suite for a modern user experience.

This setup is designed to be portable, reproducible, and easy to share with your team.

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running on your machine (macOS, Windows, or Linux).

## Getting Started

Follow these steps to get your local Jenkins environment up and running.

### 1. Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/JennySnyk/Jenkins-in-Docker.git
```

### 2. Launch the Environment

Navigate into the project directory and use Docker Compose to build the image and start the containers:

```bash
cd Jenkins-in-Docker
docker-compose up --build -d
```

This command will:
- Build the custom `myjenkins-blueocean:lts` Docker image from the `Dockerfile`.
- Download the necessary base images.
- Create and start the Jenkins and Docker-in-Docker containers in the background.

### 3. Initial Jenkins Setup

Once the containers are running, you can access Jenkins in your web browser:

- **URL**: [http://localhost:8080](http://localhost:8080)

On your first visit, Jenkins will be locked. You need to provide an initial administrator password to unlock it.

- **Get the password** by running the following command in your terminal:
  ```bash
  docker logs jenkins-blueocean
  ```
  Look for a block of text surrounded by asterisks that contains the alphanumeric password.

- **Complete the Setup Wizard**: Paste the password into the Jenkins UI and follow the on-screen instructions to create your own admin user.

### 4. Authenticate Snyk

To use the Snyk CLI for security scanning, you need to authenticate it with your personal Snyk API token.

- **Find your token**: Log in to your Snyk account and find your API token under **Account Settings > General > Auth Token**.

- **Run the auth command**: Execute the following command in your terminal, replacing `<YOUR_SNYK_TOKEN>` with your actual token:
  ```bash
  docker exec jenkins-blueocean snyk auth <YOUR_SNYK_TOKEN>
  ```

Your Jenkins environment is now fully configured and ready to use!

## Managing the Environment

- **To stop the environment**: `docker-compose down`
- **To start the environment again**: `docker-compose up -d`
- **To view logs**: `docker-compose logs -f`
