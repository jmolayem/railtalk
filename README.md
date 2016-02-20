# Speak Your Stop!

This is a mobile (iOS) app that uses free unstructured voice requests to predict arrival times for nearby trains (LA Metro only). 
https://itunes.apple.com/ca/app/railtalk/id1080240650?mt=8

## Mission

The goal of this project is to make querying a live data stream into a more natural extension of language processing.

## Third Party Resources

https://wit.ai/ for natural language processing.

http://developer.metro.net/ for live gps data.

```bash
git clone https://github.com/jmmolaye/railtalk.git
```

## Usage

This app extracts two (2) things from a question a) rail line color (route #) and b) stop description (stop #). These bits of information are then sent to the LA Metro Rail API to display arrival time predictions.

Sample question structure: when will the ____ arrive at _____?
i.e. - When will the expo arrive at the coliseum?

For example, to know the predicted arrival of a train at "Expo Park / USC Station," the station name can be deconstructed to more familiar descriptors such as:
Exposition, expo, USC, Coliseum, SC, Jefferson St, California Science Museum, Natural History Museum, Rose Garden, and so and so forth. 

<img src="https://raw.githubusercontent.com/teamheisenberg/railtalk/master/Simulator.Screen.Shot.Feb.20.2016.9.10.38.AM.png" width="375px" height="667px" />
<img src="https://raw.githubusercontent.com/teamheisenberg/railtalk/master/Simulator.Screen.Shot.Feb.20.2016.9.10.43.AM.png" width="375px" height="667px" />
<img src="https://raw.githubusercontent.com/teamheisenberg/railtalk/master/Simulator.Screen.Shot.Feb.20.2016.9.10.46.AM.png" width="375px" height="667px" />
<img src="https://raw.githubusercontent.com/teamheisenberg/railtalk/master/Simulator.Screen.Shot.Feb.20.2016.9.10.53.AM.png" width="375px" height="667px" />
<img src="https://raw.githubusercontent.com/teamheisenberg/railtalk/master/Simulator.Screen.Shot.Feb.20.2016.9.11.02.AM.png" width="375px" height="667px" />

## Features
App includes two convenient features:
* GPS data provided by the LA Metro and NextBus.
* No drop down menu - if you don't know the name of your stop - just speak it. 

## Disclaimer
* Personal app - not affiliated with LA Metro.
