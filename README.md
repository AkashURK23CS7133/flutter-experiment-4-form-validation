# Experiment 4 – Form Validation using Stateful Widgets

## Aim

To design and implement a Car Mileage Calculator using Flutter Forms, TextFormField, input widgets, and Stateful Widgets. The application validates user inputs and dynamically displays the calculated mileage and fuel-efficiency category.

## Features

- `StatefulWidget` + `Form` + `GlobalKey<FormState>`
- Two `TextFormField`s with `TextEditingController`s: distance (km) and fuel (litres)
- Validation: both required, must be numbers, must be greater than zero (fuel cannot be 0)
- **Mileage = Distance ÷ Fuel**, shown with 2 decimals via `setState()`
- Category: below 10 km/l → *Low Efficiency*; 10–15 → *Average Efficiency*; above 15 → *Excellent Efficiency*
- **Clear** button resets the form and result

## Source files

`lib/main.dart`

## Dependencies

Only the Flutter SDK.

## Setup

Nothing extra – just run `flutter pub get`.

## Run

Open a terminal **in this folder** (VS Code: right-click the folder → *Open in Integrated Terminal*), then:

```powershell
flutter pub get        # download the packages listed in pubspec.yaml
flutter analyze        # check the code for problems (should say "No issues found!")
flutter test           # run the automated tests
flutter run -d chrome  # start the app in Chrome
```

While the app is running in the terminal: press `r` to hot-reload after editing code, `R` to restart, `q` to quit.

## Expected output

Entering 12 km and 4 litres shows **3.00 km/l – Low Efficiency**; 300 km and 15 litres shows **20.00 km/l – Excellent Efficiency**.

Screenshots of the running app: [`../OUTPUTS/Experiment_04/`](../OUTPUTS/Experiment_04/)

## Troubleshooting

- **`flutter` is not recognized** – Flutter is not on your PATH. See the master README, section *Installing Flutter*.
- **"Unable to determine engine version"** – PowerShell is picking up the empty file `C:\Windows\System32\git` instead of real Git. Put Git first on PATH (see master README).
- **No Chrome device** – run `flutter devices`; install Google Chrome if it is missing.
