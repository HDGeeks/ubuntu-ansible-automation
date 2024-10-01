# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install SSH, sudo, and any other necessary packages
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    apt-get clean

# Set up SSH to run in the container
RUN mkdir /var/run/sshd

# Create a new user for Ansible with sudo privileges
RUN useradd -m -s /bin/bash ansible_user && echo "ansible_user:password" | chpasswd && adduser ansible_user sudo

# Expose the SSH port
EXPOSE 22

# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]
