# FlutterShare

[![GitHub issues](https://img.shields.io/github/issues/guptapriyanshu7/FlutterShare?style=for-the-badge)](https://github.com/guptapriyanshu7/FlutterShare/issues)
[![GitHub license](https://img.shields.io/github/license/guptapriyanshu7/FlutterShare?style=for-the-badge)](https://github.com/guptapriyanshu7/FlutterShare/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/guptapriyanshu7/FlutterShare?style=for-the-badge)](https://github.com/guptapriyanshu7/FlutterShare/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/guptapriyanshu7/FlutterShare?style=for-the-badge)](https://github.com/guptapriyanshu7/FlutterShare/network)

An Instagram clone app made with flutter and Firebase.

## Screenshots
<p>
<img src="https://user-images.githubusercontent.com/60141300/138210157-e44a9b20-4737-4a34-89d3-218b73212aca.jpg" width="250" height="470">
<img src="https://user-images.githubusercontent.com/60141300/138210146-9d1c2d38-46b1-48d5-9e1c-98ecb3ffc038.jpg" width="250" height="470">
<img src="https://user-images.githubusercontent.com/60141300/138210148-87f3cbaa-3e4c-45e9-9cdc-e436288cfa5a.jpg" width="250" height="470">
<img src="https://user-images.githubusercontent.com/60141300/138212211-7e3db48b-2ca3-4bc6-8d42-6b5b0b05dfe6.jpg" width="250" height="470">
<img src="https://user-images.githubusercontent.com/60141300/138210156-bd86d712-a936-4ba8-a6f7-73ac7d000366.jpg" width="250" height="470">
<img src="https://user-images.githubusercontent.com/60141300/138210158-3986229b-db05-467b-9743-76d80c99817b.jpg" width="250" height="470">
<img src="https://user-images.githubusercontent.com/60141300/138210161-5f36bf5b-817f-48fa-8759-32924c2b636f.jpg" width="250" height="470">
<img src="https://user-images.githubusercontent.com/60141300/138210159-c0fe94ea-7063-4717-b5c8-fda18197e287.jpg" width="250" height="470">
<img src="https://user-images.githubusercontent.com/60141300/138210154-e2395095-0138-4e99-a53b-fb62427c5ce6.jpg" width="250" height="470">
<img src="https://user-images.githubusercontent.com/60141300/138210143-95a47570-63f2-46af-851f-57218dcffdf6.jpg" width="250" height="470">
<img src="https://user-images.githubusercontent.com/60141300/138212210-7e5e956e-2b1d-43e8-a88b-f7927894e712.jpg" width="250" height="470">
</p>


## Features

- Sign In with email/password or google account.
- Create post with caption and live location.
- Like posts.
- Comment on posts and view all comments on a post.
- Follow users using search.
- Timeline based on who you follow (using firebase functions).
- Notifications on other users activity.
- Activity Feed showing recent likes/comments on your posts and who followed you.
- See followers/following/total posts count.

## Folder Structure

```
lib
├───application (State Management code using bloc)
│   ├───auth (Checks whether user is authenticated.)
│   │   └───sign_in_form (Sign In/Register using email/password or google.)
│   ├───post (View post(s))
│   │   └───save_post (Create posts logic.)
│   └───user_actions (Follow, like, comments, profile logic.)
├───domain (All the models, errors and exceptionns that could occur.)
│   ├───auth
│   ├───core
│   ├───posts
│   └───user_actions
├───helper (Get current location.)
├───infrastructure (Firebase related code.)
│   ├───auth
│   ├───core
│   ├───post
│   └───user_actions
└───presentation (UI)
    ├───activity_feed (Main page after signing in.)
    ├───auth (Sign in form UI)
    │   └───widgets
    ├───comments (Comments page.)
    ├───post
    │   └───widgets
    ├───profile
    │   └───widgets
    ├───routes (Route handling)
    ├───search
    └───splash (Checks user was logged in or not, display app icon.)
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
