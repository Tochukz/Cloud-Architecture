#!/bin/bash
# Stop all servers and start the server
forever stopall
forever start /home/ubuntu/my-app1/app.js
