# Use the AOSP compatible Ubuntu as the base image
FROM userariii/aosp-ubuntu

# Set non-interactive environment variable
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and upgrade packages without prompts
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# Create a directory named "AOSP"
RUN mkdir /AOSP

# Set the working directory to the "AOSP" folder
WORKDIR /AOSP

# Set Git username/email config
RUN git config --global user.name "userariii" \
 && git config --global user.email abhattacharjee717@gmail.com \
 && git config --global color.ui true

# Fetch PixelExperince source
RUN repo init -u https://github.com/PixelExperience/manifest -b thirteen --depth=1 \
&& echo "Performing some setup..." && sleep 5 && echo "Continuing with the sync step..." \
&& repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
