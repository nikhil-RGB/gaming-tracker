# gaming_tracker

This app is designed to log and track your daily gaming habits, providing weekly and daily statistics on
- Hours spent playing certain games.
- Power modes used during a session (Balanced/Performance/Turbo).
- Average fan speed of the Computer's CPU and GPU.
- Fan modes applied during the session(Auto/Custom/Max).

> [!NOTE]  
> This tracker app does not automatically log sessions, and stores all information on the phone's local file system.

Before logging any information, users need to register the games they play in the "Games" section.
Once the user has registered their games, they can proceed to select a day via the calendar page and proceeding to view existing sessions or logging new ones.
The cards which display "hours played" alongside the game's name and image on the "Today's Games" page are clickable. Clicking a card reveals the power mode, fan mode and the CPU/GPU fan speed averaged during the session. 

The statistics section of the app can be used to view a weekly/fortnightly graph of your gaming data. This section has two views:
- Standard view:
  - X-Axis represents days(Monday-Sunday). The week range displayed is determined by the date selected in the calendar page- all days between the 
    closest previous monday and the nearest next Sunday are displayed in the standard view.
  - Y-Axis represents hours in the day(0-24).
  - A dropdown is present which can be used to select which game's session data you wish to be dispalyed on the graph.
  - If more than 24 hours have been logged on a particular day, it will be rounded down to 24 on the graph.

    <br> <br>
    
<img src="https://github.com/user-attachments/assets/9860ca28-1ecb-49f9-baf3-508a19d02410" alt="Image Description" width="220" height="500">

<br> <br>

- Custom View:
  - Date ranges can be inputted manually, must be greater than 4 days and lesser than 21 days.
  - The game select drop down is present on this page as well, and shares it's state with the standard view game select drop-down.
  - It is to noted that The standard view is the default view, and is the view which is displayed when navigating to the
    stats page. Both the standard and custom view maintain their state when the stats tab is selected on
    the landing page. However, if the user navigates to the calendar page or games page, the standard
    view maintains it's state while the custom view gets reset.

 
<br> <br>
    
<img src="https://github.com/user-attachments/assets/53c06d0c-f447-4b5e-b0dd-d896e7f00163" alt="Image Description" width="220" height="500">

<br> <br>

### Screenshots:


<img width="289" alt="SCREEN1" src="https://github.com/user-attachments/assets/969c2fa8-7393-4fa7-b9d0-552ab5b3eaa0" />

<img width="275" alt="RESGITERED_GAMES-PAGE" src="https://github.com/user-attachments/assets/9370bb95-80ba-4038-8d15-99b4d7f73357" />



<img width="284" alt="SCREEN2" src="https://github.com/user-attachments/assets/204aac99-1183-4a98-9b37-48bdaf53a7ac" />
<img width="284" alt="screen3" src="https://github.com/user-attachments/assets/e8d74ecc-8290-4a54-8e3f-9eb784b52aae" />


<img width="278" alt="SCREEN4" src="https://github.com/user-attachments/assets/f0377300-4f06-4ff9-b3f0-81a7636d0792" />
<img width="292" alt="STATS_PAGE" src="https://github.com/user-attachments/assets/ca9716c4-6631-4732-9fc1-de01d3f539d8" />





    
