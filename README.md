# Quang Tri Explorer

**Quang Tri Explorer** is a mobile application developed using Flutter. This app provides useful information and features for users to explore Quang Tri province.

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Folder Structure](#folder-structure)
- [Dependencies](#dependencies)
- [Features](#features)
- [Screenshots](#screenshots)
- [Contributing](#contributing)

## Introduction

The **Quang Tri Explorer** app offers information about tourist attractions, cultural landmarks, and historical sites in Quang Tri province. Users can view details about various locations, calculate distances, and use maps for navigation.

## Installation

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/manh-nguyen-dev/quang_tri_explorer.git
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app on an emulator or a real device:

   ```bash
   flutter run
   ```

## Folder Structure

```
assets/
├── images/                  # Folder containing images used in the app
lib/
├── data/                    # Static or mock data used in the app  
├── helpers/                 # Utility functions for common tasks like formatting
├── models/                  # Data models representing objects like locations or users
├── screens/                 # Screens of the application
├── services/                # Handles complex logic such as API calls and calculations
├── utils/                   # General utilities and constants used across the app
├── widgets/                 # Reusable widget like buttons or cards
└── main.dart                # Main entry point for the app
```

## Dependencies

This project utilizes popular Flutter packages to provide core functionality.

- **[floating_draggable_widget](https://pub.dev/packages/floating_draggable_widget)**: Adds draggable widgets to the app.
- **[http](https://pub.dev/packages/http)**: For handling HTTP requests.
- **[google_mobile_ads](https://pub.dev/packages/google_mobile_ads)**: Integrates Google ads into the app.
- **[geo_distance_calculator](https://pub.dev/packages/geo_distance_calculator)**: Calculates distances between geographical points.

## Features

- Displays a list of popular tourist destinations in Quang Tri province.
- Calculates the distance between the user's current location and the listed destinations.
- Supports in-app advertisements for revenue generation.
- User-friendly interface with smooth navigation.

## Screenshots

| ![Screenshot 1](https://i.ibb.co/M8Lr5GV/Simulator-Screenshot-i-Phone-15-Pro-Max-2024-10-03-at-14-02-39.png) | ![Screenshot 2](https://i.ibb.co/gD7VP5z/Simulator-Screenshot-i-Phone-15-Pro-Max-2024-10-03-at-14-02-45.png) | ![Screenshot 3](https://i.ibb.co/cbpN03h/Simulator-Screenshot-i-Phone-15-Pro-Max-2024-10-03-at-14-02-58.png) | ![Screenshot 4](https://i.ibb.co/D5v8XnY/Simulator-Screenshot-i-Phone-15-Pro-Max-2024-10-03-at-14-03-04.png) |
|---|---|---|---|

## Contributing

If you would like to contribute to the project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/feature-name`).
3. Commit your changes (`git commit -m 'Add feature XYZ'`).
4. Push your branch (`git push origin feature/feature-name`).
5. Open a Pull Request.