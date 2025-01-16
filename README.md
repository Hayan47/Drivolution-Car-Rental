# Drivolution

Drivolution is an Android application built with BLoC state management that allows users to browse available cars for rental, search for specific cars, view car details, and add them to their favorites list. The app utilizes Google Maps for location-based services and is powered by Firebase for user authentication and data storage.

## Features
- Car Rental: Users can browse a list of available cars for rental.
- Car Search: Users can search for specific cars based on their preferences.
- Car Details: Users can view detailed information about a specific car, including its make, model, year, and rental rates.
- Rent Car: Users can rent cars from other users for a specified duration.
- Add Car: Users can add their own cars to the platform for others to rent.
- Favorites List: Users can add cars to their favorites list for quick access.
- Location Services: Integration with Google Maps allows users to view car locations, get directions, and estimate distances.
- Push Notification: Implementing Firebase Cloud Messaging users will be notified about their cars state

## Architecture

Drivolution is built with BLoC state management, which provides a scalable and testable architecture for building complex applications. The BLoC pattern separates the business logic of an application from its presentation, making it easier to manage and scale over time.

The application is divided into three main layers:

- Presentation layer: This layer is responsible for rendering the UI and handling user interactions. The presentation layer communicates with the BLoC layer to retrieve data and update the UI based on the current state.
- BLoC layer: This layer contains the business logic of the application and manages the state of the application. The BLoC layer communicates with the data layer to retrieve data and emits new states based on the current state and user actions.
- Data layer: This layer is responsible for retrieving data from external APIs or local storage. In the case of Drivolution, the data layer communicates with Firebase to retrieve data.

You can download the APK file for Drivolution from this link: https://www.mediafire.com/file/kvq3s3aa4qrmnlz/Drivolution2.1.4.apk/file

## ScreenShots

### Welcome Screen

<p align="center">
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_welcome.jpg" width="18%" />
</p>

### Main Screens

<p align="center">
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_home.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_favorite.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_addcar1.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_notification.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_profile1.jpg" width="18%" />
</p>

### Car Details Screen

<p align="center">
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_details1.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_details2.jpg" width="18%" />
</p>

### Login Screen

<p align="center">
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_login.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_signup.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_forgetpassword.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_profile2.jpg" width="18%" />
</p>

### Add Car Screens

<p align="center">
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_addcar2.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_addcar3.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_addcar4.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_addcar5.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_addcar6.jpg" width="18%" />
</p>

### Location Screens

<p align="center">
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_carloc.jpg" width="18%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_pickloc.jpg" width="18%" />
</p>

### Rent Car Screen

<p align="center">
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_rent.jpg" width="18%" />
</p>

### Responsive Screens

<p align="center">
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_responsive1.jpg" width="48%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_responsive2.jpg" width="48%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/car_responsive3.jpg" width="48%" />
</p>
