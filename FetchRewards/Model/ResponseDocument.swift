//
//  ResponseDocument.swift
//  ResponseDocument
//
//  Created by James Sedlacek on 10/1/21.
//
//  SEATGEEK API
//  API Docs: http://platform.seatgeek.com

import Foundation

struct ResponseDocument: Decodable {
    let events: [ResponseEvent]
}

struct ResponseEvent: Decodable {
    let title: String
    let datetime_local: String
    let venue: Venue
    let performers: [Performers]
    let id: Int
    let url: String
}

struct Performers: Decodable {
    let image: String
}

struct Venue: Decodable {
    let city: String
    let state: String
    let location: Location
}

struct Location: Decodable {
    let lat: Double
    let lon: Double
}
