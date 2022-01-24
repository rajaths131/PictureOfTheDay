# PictureOfTheDay
 iOS App where the user can see the daily picture from NASA. This project is implemented using MVP pattern, to demonstrate each components of MVP. 
 
 This sample is developed using Swift. Unit tests and UI tests are added to code.
 
 Main features covered are:
 1. A error banner will be shown, if app could not fetch details from server. 
 2. If app could not fetch latest details, cached picture will be shown. 
 3. If cached details are older then today, a banner message will be shown.

## API:
This app was built using [NASA API](https://api.nasa.gov).

## Improvement Areas
Some improvement we are looking for in next version are:

1. If app could not fetch details on fresh install, a retry button can be provided.
2. If image download is failed, a error can be shown to user.
3. Network reachability issue can be identified and seperate error can be shown to user.
4. Zoom option for image can be provided to user.
