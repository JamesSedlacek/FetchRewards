//
//  apiManager.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/18/21.
//

import  UIKit

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
    var title: String
    var datetime_local: String
    var venue: venue
    var performers: [performers]
}

struct performers: Decodable {
    var image: String
}

struct venue: Decodable {
    var city: String
    var state: String
}

// MARK: - API Manager

struct ApiManager {
    
}
