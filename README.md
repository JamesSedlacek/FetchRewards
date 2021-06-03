
<h1 align="center">Take Home Project</h1><br>

<div>
  <h2>Table of Contents</h2>
  <ul>
    <li><a href="https://github.com/JamesSedlacek/FetchRewards#demo-videos">Demo Videos</a></li>
      <ul>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#favorite--unfavorite">Favorite & Unfavorite</a></li>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#searching">Searching</a></li>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#globe-button">Globe Button</a></li>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#map-button">Map Button</a></li>
      </ul>
    <li><a href="https://github.com/JamesSedlacek/FetchRewards#screenshots">Screenshots</a></li>
    <li><a href="https://github.com/JamesSedlacek/FetchRewards#about-the-project">About The Project</a></li>
      <ul>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#how-it-works">How it Works</a></li>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#technologies-used">Technologies Used</a></li>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#skills-demonstrated">Skills Demonstrated</a></li>
        <li><a href="https://github.com/JamesSedlacek/FetchRewards#features-to-add">Features to Add</a></li>
      </ul>
  </ul>
</div><br><br>

<h2>Demo Videos</h2>
<div align="center" width=1000>
  <h3>Favorite & Unfavorite</h3>
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Videos/Favorite.gif" width="300" height="566"><br>
  <h3>Searching</h3>
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Videos/Search.gif" width="300" height="566"><br>
  <h3>Globe Button</h3>
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Videos/Web.gif" width="300" height="566"><br>
  <h3>Map Button</h3>
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Videos/map.gif" width="300" height="566"><br>
</div>

<h2>Screenshots</h2>
<div width=1000 align="center">
  <p float="left">
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Images/SearchTab.png" width="300" height="566">
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Images/FavoritesTab.png" width="300" height="566">
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Images/MapView.png" width="300" height="566">
    <img src="https://github.com/JamesSedlacek/FetchRewards/blob/main/Images/DetailView.png" width="300" height="566">
  </p>
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
      <li>Swift</li>
      <li>Xcode</li>
      <li>UIKit</li>
      <li>Storyboards & XIB</li>
      <li>MapKit</li>
      <li>CoreLocation</li>
  </ul>
</div>
  
<div>
  <h3>Skills Demonstrated</h3>
  <ul>
    <li>MVVM Pattern</li>
    <li>Delegate Pattern</li>
    <li>Observer Pattern</li>
    <li>UserDefaults</li>
    <li>Error Handling</li>
    <li>Unit Testing</li>
    <li>URLSession</li>
    <li>JSON Decoding</li>
    <li>Multithreading</li>
  </ul>
</div>

<div>
  <h3>Features to Add</h3>
  <ul>
    <li>Double Tap Gesture to Favorite Events</li>
    <li>Sorting & Filtering in Search</li>
  </ul>
</div>



