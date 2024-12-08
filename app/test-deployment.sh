#!/bin/bash
echo "checking app ${APP_PUBLIC_IP}:5000" 
curl -s ${APP_PUBLIC_IP}:5000 | grep  "Welcome to the Wizard's Almanac"
