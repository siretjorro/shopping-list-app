# Shopping list app

A simple shopping list application. The goal of this application is to allow users to add shopping list items, mark them as completed and delete them. Users are also able to view completed items.

## Installation and running

Clone this repository

```shell
git clone https://github.com/siretjorro/shopping-list-app.git
```

Navigate to the shopping_list_app directory

```shell
cd shopping_list_app
```

Ensure that you have a simulator or an emulator running and run the app

```shell
flutter run
```
## Running tests

Run all tests

```shell
flutter test test
```

Run a specific test

```shell
flutter test test/[test name]
```

## Architecture

The application has a very simple architecture based on FutureBuilders. I did try implementing the BLoC architecture pattern but ran into some trouble where the StreamBuilder wouldn't update the UI. The BLoC version is in the branch branchname.

The web service used in this application was provided by my professor at TalTech [Andres Käver](https://github.com/akaver).

The application currently has limited tests.