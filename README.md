# railtalk
This is a mobile (iOS) app uses free unstructured voice requests to predict arrival times for nearby trains. 

For example, the expo line’s exact name "Expo Park / USC Station" can be deconstructed to more familiar descriptors: 
Exposition, expo, USC, Coliseum, SC, Jefferson St, California Science Museum, Natural History Museum, Rose Garden, and so and so forth. 

The goal of this project is to make querying a live data stream into a more natural extension of language processing.

This app extracts two (2) things from a question a) rail line color (route #) and b) stop description (stop #). These bits of information are then sent to the LA Metro Rail API to display arrival time predictions.

Sample question structure: when will the ____ arrive at _____?

i.e. - When will the gold line arrive at Del Mar Station?

It is built using iOS (Swift), the Wit.ai API for natural language processing, and the LA Metro Rail API.

https://wit.ai/

http://developer.metro.net/
