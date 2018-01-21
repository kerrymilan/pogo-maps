# Pogo-Maps

This utility is designed to receive JSON output from a 3rd-party Pokemon Go tracker and apply 
user-defined display filters.  

## Dependencies
 * cURL
 * PHP
 * SQLite3

## Installation
1. Create a cron job to call ./refresh.sh periodically (every 1-5 minutes).
1. Point the web server to the 'html' folder in this directory.  
1. Create users in the SQLite database in this directory.  
1. Provide pokemon sprites and gym icons in ./html/include/img/
    1. Provide a icons-sprite.png sprite sheet (sprites should be 40px * 40px)
    1. Run raid/generate.sh to build raid boss icons
