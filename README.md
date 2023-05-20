# Campus Clean Up Game

This is a the companion app for the Campus Clean Up Game to store your credits and spend them on rewards.

🌐 <https://clean-up.app/> 🌐

## Game Concept

1. Register for the game by logging in with one of the supported providers.
2. Collect trash on campus
3. Hand in the trash at the collection point
4. Show the QR code to the collection point staff
5. Get credits for the trash you collected
6. Spend your credits on rewards

## Setup

### Firebase

- Request access to the Firebase project from [Philipp Opheys](mailto:philipp.opheys@neuland-ingolstadt.de).
- Install the [Firebase CLI](https://firebase.google.com/docs/cli).
- Login to your Firebase account.

    ```bash
    firebase login
    ```

- Install the [Flutter CLI](https://firebase.flutter.dev/docs/cli/) and activate it according to the documentation.
- Run the following command to create the `firebase_options.dart` file. This file is used to connect to the Firebase project.

    ```bash
    flutterfire configure
    ```

### Flutter

- Install the [Flutter SDK](https://flutter.dev/docs/get-started/install).
- Check your Flutter installation

    ```bash
    flutter doctor
    ```

- Switch to the `stable` channel

    ```bash
    flutter channel stable
    flutter upgrade
    ```

- Install the dependencies

    ```bash
    flutter pub get
    ```

- Run the app

    ```bash
    flutter run [-d Chrome]
    ```

## Deployment

- Build the app using CanvasKit in release mode

    ```bash
    flutter build web --web-renderer canvaskit --release
    ```

- Deploy the app to Firebase

    ```bash
    firebase deploy
    ```
