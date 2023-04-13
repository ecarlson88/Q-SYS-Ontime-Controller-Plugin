# Ontime Controller Plugin V1.0

## At the moment this plugin will only work with ontime V1.X releases. Changes to the API in the upcoming V2 will cause a good portion of this plugin to stop functioning. 

## Work is being done to update the plugin to support ontime V2 and the added features being added in their upcoming API. Testing still underway

## Overview
### Description:
This repo contains a Q-SYS Plugin for control of the ontime stage timer via its published HTTP API.

In this initial release, V1.0 of this plugin supports Play, Pause, Reload Event, Next Event, and Previous Event controls. In addition to those controls the plugin has polling of Event Title, Time Remaining, and Presenter fields.

## Screenshots

--![Plugin](https://github.com/ecarlson88/Q-SYS-ontime-Controller-Plugin/blob/main/Ontime_Plugin.png)






--![Ontime](https://github.com/ecarlson88/Q-SYS-ontime-Controller-Plugin/blob/main/ontime_app.png)



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
