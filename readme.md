# Pogo-Maps

This utility is designed to receive JSON output from a 3rd-party Pokemon Go tracker and apply 
user-defined display filters.  

## Dependencies
 * cURL
 * PHP
 * SQLite3

## Installation
1) Create a cron job to call ./refresh.sh periodically (every 1-5 minutes).
2) Point the web server to the 'html' folder in this directory.  
3) Create users in the SQLite database in this directory.  
