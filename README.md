# Tempestas - Weather Forecast Application

## Summary

![](https://media.giphy.com/media/H4QT471CA99L82DJL4/giphy.gif)

### Tempestas - Meaning
In ancient Roman religion, Tempestas (Latin tempestas: "season, weather; bad weather; storm, tempest") is a goddess of storms or sudden weather. As with certain other nature and weather deities, the plural form Tempestates is common. Cicero, in discussing whether natural phenomena such as rainbows and clouds should be regarded as divine, notes that the Tempestates had been consecrated as deities by the Roman people.

### The application
This application helps the users find the weather information for any desired location on the globe. It's main functionality is to provide a 5-day weather forecast for the user's selected location. User's can also add or remove locations from a list of cities which are stored locally on the device.

The app is comprised of two screens. The City Management screen and the Forecast screen. In the City Management screen, you can remove your saved cities or add new ones. You can also request a weather forecast by typing a city and pressing "Go" or selecting a saved city from the list. In the  Forecast screen, you can see the weather forecast for the next 5 days. You have the option of selecting any of the 5 days and also you can select the hours you want to view. 

Everything is composed in a beautiful and elegant UI that features flawless animations and illustrations.

## How to build and run this application
To run this application you will need MacOS 10.15 (Catalina) and Xcode 11. The application is designed to run on iOS 13+. The application uses [Cocoapods](https://cocoapods.org/) to manage the project dependencies, but everything is included with the project so there's no need to install anything. The one thing you will certainly need is an API key, since I elected not to add the API key in the project. Let's see how you can get one and add to the project yourself.

The application uses the [WorldWeatherOnline API](https://www.worldweatheronline.com/developer/api/docs/local-city-town-weather-api.aspx). To get an API key you will need to signup [here](https://www.worldweatheronline.com/developer/signup.aspx).

After that you will need to add the `API_KEY` to the project's running scheme. Please see the screenshot attached for more information.
![API_KEY image instructions](https://i.imgur.com/QVicTve.png)

Once you have added the API key you should be good to go. If you have any trouble running the application [email me](mailto:nick@nikolouzos.xyz).

## Tools Used
For this project, the [MVC (Model-View-Controller)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) architecture is used. To ensure the best coding practices and code formatting are enforced, [SwiftLint](https://github.com/realm/SwiftLint) was used. For the UI, the [IBAnimatable](https://github.com/IBAnimatable/IBAnimatable) framework was used to save time while creating beautiful UIs and animations with minimal effort. For the Networking part of the application, [Alamofire](https://github.com/Alamofire/Alamofire) was utilized and to parse the data JSON the [SwiftyJSON]() library was implemented.


### Cocoapods dependencies
| Library | Link |
| ------- | ---- |
| SwiftLint | [Link](https://github.com/realm/SwiftLint)|
| IBAnimatable | [Link](https://github.com/IBAnimatable/IBAnimatable)|
| Alamofire | [Link](https://github.com/Alamofire/Alamofire)|
| SwiftyJSON | [Link](https://github.com/SwiftyJSON/SwiftyJSON)|
