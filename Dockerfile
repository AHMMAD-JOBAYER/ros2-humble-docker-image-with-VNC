# Use an official Ubuntu jammy image
FROM ubuntu:22.04

# Avoid warnings by switching to noninteractive for the build process
ENV DEBIAN_FRONTEND=noninteractive
ENV USER=root
ENV LANG=en_US.UTF-8
ENV RESOLUTION=1920x1080

# Set the working directory
WORKDIR /app

# Add custom mirrors
COPY mirrorlist.txt .
RUN sed -i '1r mirrorlist.txt' /etc/apt/sources.list && rm mirrorlist.txt

# Install required packages including curl and jq
RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    dbus-x11 \
    xfonts-base \
    locales \
    curl \
    ca-certificates \
    jq \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure locale
RUN locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Add ROS 2 GPG key and repository
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
    http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo "$UBUNTU_CODENAME") main" \
    > /etc/apt/sources.list.d/ros2.list

# Install ROS 2 Humble
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y ros-humble-desktop ros-dev-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Source ROS 2 in the bashrc
RUN echo 'source /opt/ros/humble/setup.bash' >> /root/.bashrc

# Set up VNC server password
RUN mkdir -p /root/.vnc && \
    echo "password" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# Create an .Xauthority file
RUN touch /root/.Xauthority

# Expose the VNC port
EXPOSE 5901

# Copy and prepare the VNC startup script
COPY start-vnc.sh /app/start-vnc.sh
RUN chmod +x /app/start-vnc.sh

# List the contents of the /app directory
RUN ls -a /app
