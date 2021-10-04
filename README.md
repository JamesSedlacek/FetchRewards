
<h1 align="center">Take Home Project</h1><br>

<div>
<p>
  <h2>Overview</h2><br>
  
  This project was created as a take-home project for the company 'Fetch Rewards'. <br>
  After the project was submitted I passed a 1-hour Zoom Technical Interview. <br>
  After that I did a 4.5-hour Zoom Interview with 5 people on the team. <br>
  <br><br>
  </p>
  
</div>
  
<div>
  <h2>Table of Contents</h2>
  <ul>
    <li><a href="https://github.com/JamesSedlacek/FetchRewards#demo-video">Demo Video</a></li>
    <li><a href="https://github.com/JamesSedlacek/FetchRewards#screenshots">Screenshots</a></li>
    <li><a href="https://github.com/JamesSedlacek/FetchRewards#architecture">Architecture</a></li>
    <li><a href="https://github.com/JamesSedlacek/FetchRewards#storyboard">Storyboard</a></li>
    <li><a href="https://github.com/JamesSedlacek/FetchRewards#about-the-project">About The Project</a></li>
      <ul>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#how-it-works">How it Works</a></li>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#technologies-used">Technologies Used</a></li>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#skills-demonstrated">Skills Demonstrated</a></li>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#features-to-add">Features to Add</a></li>
      </ul>
  </ul>
</div><br><br>

<h2>Demo Video</h2>
<div align="center" width=1000>
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Videos/DemoVideo.gif" width="300" height="566"><br>
</div>

<h2>Screenshots</h2>
<div width=1000 align="center">
  <p float="left">
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Images/Skeleton.png" width="300" height="566">
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Images/Search.png" width="300" height="566">
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Images/Favorites.png" width="300" height="566">
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Images/Detail.png" width="300" height="566">
  </p>
</div><br><br>

<h2>Architecture</h2>
<div width=1000 align="left">
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Images/Architecture.png">
</div><br><br>

<h2>Storyboard</h2>
<div width=1000 align="center">
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Images/Storyboard.png">
</div><br><br>

<p>
  <h2>About the Project</h2>
  
  <h3>How it works</h3>
  The application fetches relevant events from SeatGeek API while the user is typing in the search bar.<br>
  Tapping on an Event UITableViewCell will display the corresponding event in a detail screen.<br> 
  Tapping on the back button will take user back to the events tableview.<br>
  Tapping on the Map button will take the user to a screen that shows the event venue location.<br>
  Tapping on the Globe button will open up the event's url in a web browser.<br>
  The user is able to favorite AND unfavorite events from the detail screen by hitting the favorite button.<br>
  Favorited events are displayed on the events tableview below the Search Bar.<br>
  Favorited events are persisted through the use of UserDefaults.<br>
  </p>
  
<div>
  <h3>Technologies Used</h3>
    <ul>
      <li>SeatGeek API</li>
      <li>Swift, UIKit</li>
      <li>Storyboards & XIB</li>
      <li>MapKit, CoreLocation</li>
      <li>SCLAlertView</li>
      <li>SkeletonView</li>
      <li>KingFisher</li>
      <li>CoreData</li>
  </ul>
</div>
  
<div>
  <h3>Skills Demonstrated</h3>
  <ul>
    <li>MVVM Pattern</li>
    <li>Delegate Pattern</li>
    <li>Observer Pattern</li>
    <li>Data Persistence (CoreData)</li>
    <li>Error Handling</li>
    <li>Unit Testing</li>
    <li>JSON Decoding</li>
    <li>Multithreading</li>
    <li>API Integration</li>
  </ul>
</div>

<div>
  <h3>Features to Add</h3>
  <ul>
    <li>Double Tap Gesture to Favorite Events</li>
    <li>Sorting & Filtering in Search</li>
  </ul>
</div>



