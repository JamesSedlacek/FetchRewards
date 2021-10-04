//
//  NetworkingManager.swift
//  NetworkingManager
//
//  Created by James Sedlacek on 10/1/21.
//
//  SEATGEEK API
//  API Docs: http://platform.seatgeek.com

import Foundation

/// These are the different errors within the  Networking Manager
enum NetworkError: Error {
    case badURL
    case dataTask
    case nilData
    case jsonDecoding
}

/// Used for Fetching Events for a query or Fetching Favorited Events
struct NetworkingManager {
    
    // MARK: - Constants
    
    private static let apiEndpoint: String = "https://api.seatgeek.com/2"
    private static let queryEndpoint: String = "/events?q="
    private static let clientIDEndpoint: String = "&client_id="
    private static let clientID: String = "MjE5NTUzNzh8MTYyMTM3MzcyMy4xOTk4NzY4"
    
    // MARK: - Fetch Events
    
    /// Fetch Events from the SeatGeek API based on what the user searched for
    /// - Parameters:
    ///   - query: What the user is searching for
    ///   - completionHandler: Success is an array of EventVMs, Failure is a Network Error
    public static func fetchEvents(for query: String,
                                   completionHandler: @escaping (Result<[EventVM], NetworkError>) -> Void) {
        // Create the URL String
        let urlString: String = apiEndpoint +
                                queryEndpoint +
                                query +
                                clientIDEndpoint +
                                clientID
        
        // Create the URL from the urlString
        guard let url = Foundation.URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        // Create URL Session
        let session = URLSession(configuration: .default)
        
        // Give the session a task
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            // Handle Errors
            if error != nil {
                completionHandler(.failure(.dataTask))
                return
            }
            
            // Unwrap Data
            guard let data = data else {
                completionHandler(.failure(.nilData))
                return
            }
            
            do { // Decode JSON from data
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(ResponseDocument.self, from: data)
                
                // Convert all ResponseDocuments into EventVMs
                var events: [EventVM] = []
                for rd in decodedData.events {
                    events.append(EventVM(rd))
                }
                
                completionHandler(.success(events))
            } catch {
                completionHandler(.failure(.jsonDecoding))
            }
        })
        
        // Resume task if suspended
        task.resume()
    }
    
}

