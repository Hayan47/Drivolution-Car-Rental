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

## Architecture

Drivolution is built with BLoC state management, which provides a scalable and testable architecture for building complex applications. The BLoC pattern separates the business logic of an application from its presentation, making it easier to manage and scale over time.

The application is divided into three main layers:

- Presentation layer: This layer is responsible for rendering the UI and handling user interactions. The presentation layer communicates with the BLoC layer to retrieve data and update the UI based on the current state.
- BLoC layer: This layer contains the business logic of the application and manages the state of the application. The BLoC layer communicates with the data layer to retrieve data and emits new states based on the current state and user actions.
- Data layer: This layer is responsible for retrieving data from external APIs or local storage. In the case of Drivolution, the data layer communicates with Firebase to retrieve data.

## Technologies Used

- Flutter: Flutter is a mobile app SDK for building high-performance, high-fidelity, apps for iOS, Android, and web, from a single codebase.
- BLoC state management: The BLoC pattern is a state management pattern for Flutter that separates the business logic of an application from its presentation.
- Firebase: Firebase powers the backend infrastructure of Drivolution, providing user authentication and data storage for a seamless and secure car rental experience.

## Screenshots

<p float="left">
<img src="https://gitlab.com/hayan.bouobaid47/hayan.bouobaid47/-/blob/main/pics/cars10.jpg" width="200" height="400" />
  $~~~~~~~~~~$
<img src="https://gitlab.com/hayan.bouobaid47/hayan.bouobaid47/-/blob/main/pics/cars11.jpg" width="200" height="400" />
  $~~~~~~~~~~$
<img src="https://gitlab.com/hayan.bouobaid47/hayan.bouobaid47/-/blob/main/pics/cars12.jpg" width="200" height="400" />
  $~~~~~~~~~~$
<img src="https://gitlab.com/hayan.bouobaid47/hayan.bouobaid47/-/blob/main/pics/cars13.jpg" width="200" height="400" />
  $~~~~~~~~~~$
  <img src="https://gitlab.com/hayan.bouobaid47/hayan.bouobaid47/-/blob/main/pics/cars14.jpg" width="200" height="400" />
  $~~~~~~~~~~$
  <img src="https://gitlab.com/hayan.bouobaid47/hayan.bouobaid47/-/blob/main/pics/cars15.jpg" width="200" height="400" />
  $~~~~~~~~~~$
  <img src="https://gitlab.com/hayan.bouobaid47/hayan.bouobaid47/-/blob/main/pics/cars16.jpg" width="200" height="400" />
  $~~~~~~~~~~$
  <img src="https://gitlab.com/hayan.bouobaid47/hayan.bouobaid47/-/blob/main/pics/cars17.jpg" width="200" height="400" />
  $~~~~~~~~~~$
  <img src="https://gitlab.com/hayan.bouobaid47/hayan.bouobaid47/-/blob/main/pics/cars18.jpg" width="200" height="400" />
  $~~~~~~~~~~$
</p>


You can download the APK file for Drivolution from this link: https://www.mediafire.com/file/qkoigqn893n1fzn/Movio.apk/file.
