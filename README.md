# Reservation System

Take Home assessment for Henry Meds

## Build and Run
### Android
The app is written in Flutter and was tested on an Android Pixel 7 Pro emulator.
Build the app with the following command:

```flutter build apk```

## Assumptions
To keep it simple, the app really only has the concept of one Provider and
one Client.

Upon launch, first click on the Providers button. This launches the Provider
Dashboard where the Provider can select the days from the Calendar on which
they wish to see patients. Again, to keep it simple, they're able to choose
a whole day rather than a portion of a day. The Provider's selected dates are
saved in SharedPreferences.

Back on the Home Screen, click on the Clients button. Here, the Client is able
to choose an appointment slot from the calendar. Once, selected, and the date
is valid, the Appointment is saved to SharedPreferences. Saved appointments
will be read on app launch and preloaded into the calendar.

## Known Issues
Although saved in SharedPreferences, I was unable to get the Provider's chosen
dates to preload in the calendar on the Provider Dashboard in a reasonable time.

My intention was for the Client to only be able to select appointment slots on
those days that the Provider was available. Could not get this working in a
reasonable time given the Flutter package I chose to use.

The appointment does not currently expire if not confirmed after 30 minutes.

The web build does not work. I believe due to one of the packages I included.

## Given more time...
I would of course fix the issues mentioned above.

I would add much more error handling.

I would make the UI "prettier".
