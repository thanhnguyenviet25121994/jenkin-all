#!/bin/bash
echo "checking app localhost:5000"
curl -s localhost:5000 | grep  "Welcome to the Wizard's Almanac"
