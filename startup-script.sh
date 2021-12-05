#!/bin/bash

#Startup script for terraform
#Usage: downloads apache server

sudo apt-get update
sudo apt-get install apache2 -y
wait 60
sudo systemctl start apache2
wait 60
sudo systemctl status apache2