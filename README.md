# ontime Controller Plugin V1.0

## Overview
### Description:
This repo contains a Q-SYS Plugin for control of the ontime stage timer via its published HTTP API.

In this initial release, V1.0 of this plugin supports Play, Pause, Reload Event, Next Event, and Previous Event controls. In addition to those controls the plugin haas polling of Event Title, Time Remaining, and Presenter fields.

## Screenshots

--![Plugin](https://raw.githubusercontent.com/ecarlson88/Q-SYS-ontime-Controller-Plugin/blob/main/Ontime_Plugin.png)






--![Ontime](https://raw.githubusercontent.com/ecarlson88/Q-SYS-ontime-Controller-Plugin/blob/main/ontime_app.png)



## Instructions
In order to use this plugin you will need to have ontime installed and running on a machine within the same subnet as your Core.

More information on installing ontime can be found here: https://www.getontime.no


### Setup:
1. Make sure ontime is running
2. open ontime app and create desired timers
3. get IP address of ontime instance 
4. Open Q-SYS Designer and drop plugin into the design space.
4. Enter the IP address of your ontime instance into the ontime IP field in the plugin
5. Fields in plugin should populate from ontime and you should be good to go.

Debug Window available to be turned on in properties window

## Available Pins

### Input
- Next
- Pause
- Play
- Previous
- Restart
### Output
- Event Title (String)
- Presenter (String)
- Time Remaining (String)

## Additional Information
### Tested On:
Q-SYS Designer 9.5/9.6
### License:
MIT
### Support:
THIS IS AN EALRY RELEASE! There are most likely bugs and not all ontime HTTP API features are supported at this time. If you find any issues please reach out, but also please test thoroughly  before using in any production environments
