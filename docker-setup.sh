#!/bin/bash

# !!READ FIRST!!
# Before running this script, I recommend having some knowledge of the 
# different commands that are being used and the results that running them 
# would have. As such, I've included VERY BRIEF explanations of each command. 
# Please note that it is safe to assume that running this script will cause 
# about 200 MB of "stuff" to be installed/downloaded (at least at the time that 
# this was written). Refer to the Ubuntu manuals for an in depth explanation of
# each command: http://manpages.ubuntu.com/

# If editing this file, please use a vertical ruler of 79 characters.

# -y (--yes, --assume-yes) is used throughout this script to auto assume yes to
# any question that is asked.

# Using the default user for the USERNAME variable below probably isn't a great
# security practice as anyone with access to the machine will now have access 
# to Docker once this script is done.

#############################
##### Script Variables ######
#############################
USERNAME=ubuntu;
#############################

# Running this in the beginning is just a good practice so that all installed
# packages are up to date.
sudo apt-get update;

# If using Lightsail's Ubuntu image:
# apt-transport-https is probably already installed
# ca-certificates is probably already installed
# curl is probably already installed
# software-properties-common is probably already installed
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y;

# Look up the following codes for better explanations:
# -f (--fail) fail silently on server errors
# -s (--silent) will not show errors or progress bar
# -L (--location) will auto use any newly reported location
# -S (--show-error) shows error when silent is enabled
# The pipe character that is used causes the output of the curl to be passed on
#  to the next command. "sudo apt-key add -" causes everything that comes after
#  the "-" (which, in this case, is the output of the first command) to be
#  trusted.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo apt-key add -;

# Adds the latest ubuntu CE repo to a sources list. "lsb_release -cs" returns 
# the short codename for the current release of Linux that is being used.
CODENAME=`lsb_release -cs`;
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $CODENAME \
   stable"; 

# Running this will update all of the listed sources (including the one that
# was just added).
sudo apt-get update -y;

# Finally, the following installs docker CE
sudo apt-get install docker-ce -y;

# When Docker installs, it adds a permission group called docker. By default,
# you would now have to run as root to use Docker. This will get old. To remedy
# this, we'll add a specific user (the one set by the USERNAME variable from
# above) to the docker group.
sudo adduser $USERNAME docker;

# Normally, you would have to log in and out for the new permissions to take
# affect. By using the substitute user command (su), we can achieve a similar
# result as logging in and out.
sudo su - $USERNAME;

# The following installs Docker Compose
# Official Ubuntu repos may contain an older version. At the time of this 
# writing, the official repo contained version 1.18
sudo apt-get install docker-compose -y;
