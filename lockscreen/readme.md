
## Lockscreen for KDE Plasma 5

### Win 10 Lockscreen <br>
<picture>
  <img alt="OWM" src="lockscreen-win10.png" width="512">
</picture>
<br>
### Hub Info Lockscreen <br>
<picture>
  <img alt="OWM" src="lockscreen.png" width="512">
</picture>
<br>
* Lockscreen
    * Select Clock Style
    * System Settings - >Workspace Behavior - >Screen Locking ->Appearance ->Clock Style Config
    * Win 10 or Hub Style
    * Win 10 / Lower left side of display
        * Clock10.qml within components folder
        * Current time / date
        * Calendar Events
        * Current weather conditions
    * Hub Style / Centered top of display
        * ClockHub.qml
        * Current time / date
        * Calendar events
        * Current weather conditions
        * G-mail new messages
        * Weather forecast
        * NYSE Market indexes
        * Favorite sports team scores <br>

## Config for lockscreen data
* NYSE market data from yahoo.finance.com
* Sports data from espn.com
* Weather data from dark sky
* G-Mail unread message count python script to text file unread msg count

#### GetData.qml library functions to retrieve data from internet
* Edit this file for weather, market data, sports teams, gmail

### G-Mail python is required to access your mailbox data
* Install python3 for your system / already installed most linux distros <br>
`python3 --version` <br>
`pip install --upgrade google-api-python-client` <br>
* Must setup google OAuth to allow access to gmail mailbox
* [Gmail Oauth](https://developers.google.com/gmail/api/quickstart/python) <br>
* [Google APIs Client Library for Python](https://googleapis.github.io/google-api-python-client/docs/) <br>
* [Sample script to get unred messages](https://github.com/akora/gmail-message-counter-python) <br>

### Calendar Events
* Events.qml within components folder
* Edit to add / change events for your needs
<br>
<br>
<br>
### Weather Info
* [Obtain key for Open Weather API](https://openweathermap.org/api)<br>
* Use systemd timer to update weather
* Write json data to to local file, used in lockscreen and panel widget
<br>
<br>
### Settings for lockscreen clock style
<picture>
  <img alt="OWM" src="lockscreenSettings.png" width="512">
</picture> <br>
<br>
