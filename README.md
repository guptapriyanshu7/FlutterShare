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
├───application
│   ├───auth
│   │   └───sign_in_form
│   ├───post
│   │   └───save_post
│   └───user_actions
├───domain
│   ├───auth
│   ├───core
│   ├───posts
│   └───user_actions
├───helper
├───infrastructure
│   ├───auth
│   ├───core
│   ├───post
│   └───user_actions
└───presentation
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

## License
FlutterShare is licensed under the MIT License, © 2021 Priyanshu Gupta. See [LICENSE](https://github.com/guptapriyanshu7/FlutterShare/blob/main/LICENSE) for more details.
