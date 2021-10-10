# FlutterShare

[![GitHub issues](https://img.shields.io/github/issues/guptapriyanshu7/FlutterShare?style=for-the-badge)](https://github.com/guptapriyanshu7/FlutterShare/issues)
[![GitHub license](https://img.shields.io/github/license/guptapriyanshu7/FlutterShare?style=for-the-badge)](https://github.com/guptapriyanshu7/FlutterShare/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/guptapriyanshu7/FlutterShare?style=for-the-badge)](https://github.com/guptapriyanshu7/FlutterShare/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/guptapriyanshu7/FlutterShare?style=for-the-badge)](https://github.com/guptapriyanshu7/FlutterShare/network)

An Instagram clone app made with flutter/dart.  
Uses [flutter_bloc](https://github.com/felangel/bloc/tree/master/packages/flutter_bloc) from state management.

https://user-images.githubusercontent.com/60141300/126169052-745fc7a2-aa53-4ec5-a65a-3993050f9edc.mp4

## Features

- Sign In with email/password or google account.
- Create post with caption and live location.
- Like and comment on posts.
- Follow users using search.
- Notifications on other users activity.
- See followers/following count.

## Folder Structure

```
lib
├───application (State Management code using bloc)
│   ├───auth
│   │   └───sign_in_form
│   ├───post
│   │   └───save_post
│   └───user_actions
├───domain (All the models, errors and exceptionns that could occur.)
│   ├───auth
│   ├───core
│   ├───posts
│   └───user_actions
├───helper
├───infrastructure (Firebase related code.)
│   ├───auth
│   ├───core
│   ├───post
│   └───user_actions
└───presentation (UI)
    ├───activity_feed
    ├───auth
    │   └───widgets
    ├───comments
    ├───post
    │   └───widgets
    ├───profile
    │   └───widgets
    ├───routes
    ├───search
    └───splash
```

## Local Setup

- To contribute to this project, fork and then clone the forked repository otherwise directly clone this repository.
- Create a firebase account if not already.
- Create a new project in firebase.
- Go to settings and add android to your projeect.
- Remember the package name you give to your application.
- Add SHA-1 key by running  ```keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore``` in your terminal. When asked for a password enter ```android```. Copy the SHA-1 key and paste it in firebase where it was asked.
- Download the ```google-services.json``` and place it in ```android/app``` folder.
- Now, in ```android/app/build.gradle``` file change line 37 to your own applicationId which you gave in step 5 above.
- In firebase, enable the ```Firestore Database```, and ```Authentication``` services. In the Authentication service make sure to add Email-Password and Google Auth providers for sign-in and sign-up features to work.
- Run ```flutter pub get```.
- Run ```flutter pub run build_runner build --delete-conflicting-outputs``` to generate build files.
- Run ```flutter run``` to run the app in your android emulator/device.
- Start Hacking :)

N.B. - The activity feed and notification feature will not work till now by the above setup. For that you need to upgrade your firebase account to ```blaze``` or higher to deploy ```functions``` to firebase. There is a functions folder in the project for that. Follow these steps -

- Run ```npm install -g firebase-tools```.
- Login into firebase using ```firebase login```.
- Run ```firebase init functions```.
- Select your firebase project. Then JavaScript, for ESLint you can press N. Don't overwrite any file or the code will be lost, press N in all of them, 3 to be precise. When asked to install dependencies with npm, press Y.
- Finally, run ```firebase deploy --only functions```.

## License
FlutterShare is licensed under the MIT License, © 2021 Priyanshu Gupta. See [LICENSE](https://github.com/guptapriyanshu7/FlutterShare/blob/main/LICENSE) for more details.
