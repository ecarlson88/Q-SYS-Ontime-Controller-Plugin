# Ontime Controller Plugin V2.0 Released

##Due to the limited functions in the HTTP API work is being done to rewrite the plugin using the more robust websocket API

## Overview
### Description:
This repo contains a Q-SYS Plugin for control of the ontime stage timer via its published HTTP API.


## Instructions
In order to use this plugin you will need to have ontime installed and running on a machine within the same subnet as your Core.

More information on installing ontime can be found here: https://www.getontime.no


### Setup:
1. Make sure ontime is running
2. Open ontime app and create desired timers
3. Get IP address of Ontime instance 
4. Open Q-SYS Designer and drop plugin into the design space.
4. Enter the IP address of your Ontime instance into the ontime IP field in the plugin
5. Fields in plugin should now populate from ontime and you should be good to go.

Debug Window available to be turned on in properties window

## Available Pins

### Input
- Next
- Pause
- Play
- Previous
- Restart
### Output
- Event Index (Value)
- Event Total (Value) 
- Event Notes (String)
- Event Subtitles (String)
- Event Title (String)
- Next Event Notes (String)
- Next Event Subtitles (String)
- Next Event Title (String)
- Presenter (String)
- Next Presenter (String)
- On Air (True/False)
- Time Remaining (String)

## Additional Information
### Tested On:
Q-SYS Designer 9.5-9.9.1
### License:
MIT
### Support:
If you find any issues please reach out, but also please test thoroughly  before using in any production environments
