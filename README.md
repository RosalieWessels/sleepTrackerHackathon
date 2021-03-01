# sleepTrackerHackathon
Built for the Lancer Hacks Hackathon 2021:
https://devpost.com/software/midnight-monitoring-sleep-tracker

## Inspiration
We studied the effects of a lack of sleep in Writing Class and found that 59% of teenagers in the United States are severely sleep deprived (https://childmind.org/article/help-teenagers-get-sleep/). Our app provides a solution for people to keep track of their sleep schedule.

## What it does
Our app provides users with an easy way of logging their sleep. Then, insights on their sleep patterns are displayed in, for example, the form of graphs, but also in other ways. All the data is stored in the cloud using a database so that no data will ever be lost and so that the user has the smoothest experience possible. Furthermore, the app can play soothing sounds to get users in the right mindset to fall asleep easier.

## How we built it
We built all the screens of Midnight Monitoring using **SwiftUI and Xcode**. All the features such as as the sound player are built using **Swift**. Our app also uses the **Firebase Database** created by Google (and Cocoapods). 

## Challenges we ran into
We had a challenge where the graphs would not update based on the data returned from Firebase database. By the time the data was returned, the graph was already on screen and did not update. However, after some troubleshooting we got the graph to display with the information from Firebase Database.

## Accomplishments that we're proud of
- Showing and updating interactive graphs
- An integration with Firebase - both fetching and uploading data
- Playing and pausing sounds in the app
- Having a form with a date picker and a rating system (with stars)
- Smooth transition between pages
- Well executed user interface

## What we learned
- How to add interactive graphs in SwiftUI
- How to play and pause sounds in apps
- How to integrate with Firebase database
- How to switch between pages programmatically
- How to add an image as the background of an app and as a button
- How to create a form w/ a date picker and rating system

## What's next for Midnight Monitoring - Sleep Tracker
- Adding more sounds (and maybe even playing a random sound)
- Using AI to provide tailored feedback based on a person's sleep data
- Adding friends, sharing your sleep data, and seeing a friend's sleep data
- More insights based on sleep data
- Collection of more sleep data
- Integration with Apple Watch Sleep Data
