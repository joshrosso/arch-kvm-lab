#!/bin/bash
HOSTNAME=$(hostname -I | awk '{print $1}' | sed 's/\./-/g')
echo "attempting to reset hostname to $HOSTNAME"
hostnamectl set-hostname $HOSTNAME
