//
//  apiManager.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/18/21.
//

import  UIKit
import CoreLocation

// MARK: - API Info

// SEATGEEK API
// API Docs: http://platform.seatgeek.com

//  API Endpoint
//
//https://api.seatgeek.com/2
//
//  Resource Endpoints
//
// /events
// /events/{EVENT_ID}
// /performers
// /performers/{PERFORMER_ID}
// /venues
// /venues/{VENUE_ID}

// /events?q= (to query) !! replace spaces with '+'

// Client ID
// MjE5NTUzNzh8MTYyMTM3MzcyMy4xOTk4NzY4

// Secret (optional)
// 2cea0f98f22ea72510a9b6e003e9ec4e0fe547c0b54602f54542595feede5bb5

// MARK: - Decodable Structs

struct ResponseDocument: Decodable {
    var events: [DecodeEvents]
}

struct DecodeEvents: Decodable {
    var title: String
    var datetime_local: String
    var venue: venue
    var performers: [performers]
    var id: Int
    var url: String
}

struct performers: Decodable {
    var image: String
}

struct venue: Decodable {
    var city: String
    var state: String
    var location: location
}

struct location: Decodable {
    var lat: Double
    var lon: Double
}

// MARK: - API Manager

struct ApiManager {
    
    // MARK: - Constants
    
    private static let apiEndpoint: String = "https://api.seatgeek.com/2"
    private static let queryEndpoint: String = "/events?q="
    private static let queryIDsEndpoint: String = "/events?id="
    private static let clientIDEndpoint: String = "&client_id="
    private static let clientID: String = "MjE5NTUzNzh8MTYyMTM3MzcyMy4xOTk4NzY4"
    public static var eventDelegate: EventDelegate?
    
    // MARK: - Fetch Events
    
    public static func fetchEvents(for queryString: String) {
        let urlString: String = apiEndpoint +
                                queryEndpoint +
                                queryString +
                                clientIDEndpoint +
                                clientID
        
        if let url = Foundation.URL(string: urlString) { //create URL
            let session = URLSession(configuration: .default) //Create URL Session
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in //Give the session a task
                
                //if there's an error, print the error and exit the function
                if let theError = error {
                    print(theError)
                    return
                }
                
                //if there is data, parse the JSON
                if let safeData = data {
                    self.parseJSON(with: safeData)
                }
            })
            task.resume() //Start the task
        }
    }
    
    //MARK: - Parse JSON
    
    private static func parseJSON(with data: Data) {
        var events: [EventVM] = []
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ResponseDocument.self, from: data)
            for document in decodedData.events {
                let event = Event(title: document.title,
                                  city: document.venue.city,
                                  state: document.venue.state,
                                  dateTime: document.datetime_local,
                                  imageUrlString: document.performers[0].image,
                                  id: document.id,
                                  url: document.url,
                                  lat: document.venue.location.lat,
                                  lon: document.venue.location.lon)
                events.append(EventVM(event: event))
            }
            
            eventDelegate?.updateEvents(events: events)
        } catch {
            fatalError("Parse JSON Error: \(error)")
        }
        
    }
    
    // MARK: - Fetch Favorites
    
    public static func fetchFavorites() {
        var queryString = ""
        let favorites = UserDefaultsManager.getFavorites()
        if favorites.count == 0 { return }
        
        for favorite in favorites {
            queryString += String(favorite) + ","
        }
        
        queryString.remove(at: queryString.index(before: queryString.endIndex))
        
        
        let urlString: String = apiEndpoint +
                                queryIDsEndpoint +
                                queryString +
                                clientIDEndpoint +
                                clientID
        
        if let url = Foundation.URL(string: urlString) { //create URL
            let session = URLSession(configuration: .default) //Create URL Session
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in //Give the session a task
                
                //if there's an error, print the error and exit the function
                if let theError = error {
                    print(theError)
                    return
                }
                
                //if there is data, parse the JSON
                if let safeData = data {
                    self.parseJSON(with: safeData)
                }
            })
            task.resume() //Start the task
        }
    }
    
}
