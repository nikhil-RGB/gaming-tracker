# gaming_tracker

This app is designed to log and track your daily gaming habits, providing weekly and daily statistics on
- Hours spent playing certain games.
- Power modes used during a session (Balanced/Performance/Turbo).
- Average fan speed of the Computer's CPU and GPU.
- Fan modes applied during the session(Auto/Custom/Max).

> [!NOTE]  
> This tracker app does not automatically log sessions, and stores all information on the phone's local file system- primarily relying on Dart objects stored as JSON strings in organized text files for persistence.
>  **No data is sent  to any sort of server or backend.** 

<br>

## How to Use and Screenshots

<br>

Before logging gaming sessions, any games the user plays and would like to save sessions of should be 'registered' manually.

### 1: Register a Game

<br>

<img src="https://github.com/user-attachments/assets/bc45f95b-04d6-480e-b33f-59aa25779647" width=230>

<br> <br>

- Navigate to the 'Games' Page by tapping the controller icon on the bottom navbar.
-  Tap the "Add" Floating action button to register a game.
  
<br>

<img src="https://github.com/user-attachments/assets/71ee1524-6672-466d-94e6-461cdb1c73a7" width=230>

  <br>
  <br>

- Fill in the name of the game, it's description and  then select an image for the game. Note that 'All Games' is an invalid name and duplicate game names are not allowed.
- Once the details have been entered, click on "Save" to save the game.
- Games can be deleted via the delete icon on the top-right of it's tile in the 'Games' page. This does not affect existing data associated with it, but new data can no longer be logged for the game.
- Repeat this process for whichever games you wish to track.
  
  <br>
  

<img src="https://github.com/user-attachments/assets/29444a0f-a0a5-4645-95f8-5f160d906073" width=230>

  <br><br>

  ### 2: Logging/Viewing a Session

  <br>

  It is possible to delete individual sessions or an entire day of sessions via the delete icon, represented by a red trash can. You can look for it on the 'Today's Games' page app bar(delete all sessions on specified day) and on the indiviual play session tiles(delete only specified session).

  #### Logging sessions:

  <br>

  - Navigate to the 'Calendar' page by clicking on the calendar icon in the bottom navbar.
  - This page provides an efficient way to select a particular date to log gaming sessions/view playtime data.
  - Once a day has been selected, click on the floating action play button to view the games played on that day/log additional gaming sessions.

    <br>

<div align="center">
  
<img width="230" alt="calendar" align="left" src="https://github.com/user-attachments/assets/796850d6-1cdb-4bc6-a934-02b0201bfd0d">

<img width="230" alt="empty-cat-image" align="center" src="https://github.com/user-attachments/assets/a4135256-2461-44e7-9318-017461bf4787">

<img width="230" alt="logged-games" align="right" src="https://github.com/user-attachments/assets/bafe704e-eddb-4126-849b-7fedbc9e1a51">

</div>

<br><br>

- Once the user chooses a game to log, they will be presented with the 'Performance' page, this allows users to enter the number of hours the game was played and also input:
     - Power Modes selected : The user is presented with 3 options: Balanced, Performance and Turbo. This information is generally more applicable to gaming laptop users since performance control softwares usually allow the standard user to switch between these three or similar power modes to increase/throttle performance and consequently temperatures. More sophisticated logging of CPU PL1/PL2 power limits, GPU voltage curves, underclocking, overclocking, etc are unfortunately not available in this app.
     -  Fan Modes : The user is presented with 3 options: Auto, Max and Custom. These refer to the default fan curve provided by the manafacturer, the maximum speed the CPU and GPU fans can spin at and a customized static fan speed for the CPU/GPU respectively. Custom fan curves cannot be logged.
     -  Average fan speed: The user can input the average fan speed on the CPU/GPU during the session, or in the case of the Custom fan mode- the actual static speeds.
     -  After saving the session, the user will be navigated back to the 'Calendar' page.

<br>

<img src="https://github.com/user-attachments/assets/c8d12c81-1df3-4361-adf4-60d9d3e5d3a2" width=230>


<br><br>

#### Viewing Sessions:

The procedure to view a session is similar to logging one:
- Navigate to the calendar page and select the date for which you would like to see play data.
- Tap the 'Play' floating action button, to navigate forward to the 'Today's Games' page. This page shows a list of games played on the selected day also showing nummber of hours per session. A single game can be played across 
  multiple sessions, and logged more than once. A single session cannot exceed 24 hours, but there are no checks in place to ensure that the total hours spent across all the sessions in the day is not greater than 24. It is 
  advisable that users input hours played per session correctly for accurate logging.
- To view the performance/fan modes applied during a specific gaming session, simply click on it's tile. This navigates the user to a read-only version of the 'Performance' page, displaying the power and fan settings of the 
  session.

  <br>

<div align="center">
<img align="left" src="https://github.com/user-attachments/assets/bf9a46b4-2378-4c0d-9ab8-164c15f79957" width=230>

<img align="center" src="https://github.com/user-attachments/assets/49800ff2-3fc5-4ec2-af14-98d01133aac7" width=230>

<img align="right" src="https://github.com/user-attachments/assets/e2ac8975-0728-416c-9d7a-601301b234bd" width=230>
</div>

<br><br>

  ### 3: Viewing Statistics

  <br>

  The statistics section of the app can be used to view a weekly/fortnightly graph of your gaming data. This section has two views:
- Standard view:
  - X-Axis represents days(Monday-Sunday). The week range displayed is determined by the date selected in the calendar page- all days between the 
    closest previous monday and the nearest next Sunday are displayed in the standard view.
    Eg: 9th December 2024 - 15th December 2024 will be the week displayed if 13th December 2024 is selected on the Calendar Page.
  - Y-Axis represents hours in the day(0-24).
  - A dropdown is present which can be used to select which game's session data you wish to be dispalyed on the graph. You may also select the option 'All Games' to view the data for all registered games.
  - If more than 24 hours have been logged across gaming sessions on a particular day, it will be rounded down to 24 on the graph. Again, users are encouraged to input session hours correctly for accurate statistics.

    <br> 
    
<img src="https://github.com/user-attachments/assets/9860ca28-1ecb-49f9-baf3-508a19d02410" alt="Image Description" width="230">

<br> <br>

- Custom View:
  - Date ranges can be inputted manually but must be greater than 4 days and lesser than 21 days.
  - Once again, X-Axis represents days(start day-end day) and the Y-Axis represents hours(0-24). Hour values exceeding 24 will be rounded down to 24 on the graph.
  - The game-select drop down is present on this page as well, and shares it's state with the standard view game select drop-down. Selecting a particular game on this page changes the selected game in the Standard View as well 
    and vice-versa.
  - It is to be noted that The standard view is the default view, and is the view which is displayed when navigating to the
    stats page. Both the standard and custom view maintain their state when the stats tab is selected on
    the landing page and the user can freely navigate between them. However, if the user navigates to the calendar page or games page, the standard
    view maintains it's state while the custom view gets reset. On navigating back to the custom view, the user will once again have to enter a date range and press the "Build Graph" button.
  - The graph in the custom view must be refreshed manually via the "Build/Refresh Graph" button whenever any change is made to the start/end date. However, changing the selected game(s) automatically updates the graph.
 
<br> 
    
<img src="https://github.com/user-attachments/assets/53c06d0c-f447-4b5e-b0dd-d896e7f00163" alt="Image Description" width="230">

<br><br>

## Installation

<br>

The app can be installed from the [releases](https://github.com/nikhil-RGB/gaming-tracker/releases) section on both emulators and physical devices.
Currently, [this](https://github.com/nikhil-RGB/gaming-tracker/releases/tag/v1.0.2) is the latest release with all the features described above.
If you would like to build and run the app directly from it's source github repository, [install Flutter](https://docs.flutter.dev/get-started/install) and then follow these steps:

1. Clone the repository from GitHub:

``` git clone https://github.com/nikhil-RGB/gaming-tracker.git```

2. Navigate to the project directory:

```cd gaming_tracker```

3. Install the required dependencies using Flutter:

```flutter pub get```

4. Run the app on a connected device or emulator:

```flutter run```

5. You can build the app apk via the command:

```flutter build apk --release```

<br><br>

 ## Contribution
 
 Contributions to the Gaming Tracker app are welcome! If you would like to contribute, please follow these steps:
 1. Fork the repository on GitHub.
 2. Create a new branch for your feature or bug fix.
 3. Make your changes and commit them with descriptive messages.
 4. Push your changes to your forked repository.
 5. Submit a pull request to the main repository, explaining your changes and their benefits.

<br>

 ## Contact

If you have any questions, suggestions, or feedback regarding the app, please feel free to contact me at [javakingxi@gmail.com](javakingxi@gmail.com).
Feel free to customize and enhance this documentation to accurately reflect the features, implementation details, and any additional information specific to the project.
I've had fun developing this app and hope it's useful to others, happy gaming!


<br>




  








    
