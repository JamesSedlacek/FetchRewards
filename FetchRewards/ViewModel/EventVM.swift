//
//  EventVM.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/22/21.
//

import UIKit
import CoreLocation
import Kingfisher

public class EventVM {
    
    // MARK: - Variables
    
    public let id: Int
    public let date: String
    public let time: String
    public let title: String
    public let location: String
    public let url: String
    public let coordinates: CLLocationCoordinate2D
    public let imageUrl: String
    public var image: UIImage?
    
    // MARK: - initializer
    
    init(_ event: ResponseEvent) {
        
        // These are for better code readability
        let lat = event.venue.location.lat
        let lon = event.venue.location.lon
        let city = event.venue.city
        let state = event.venue.state
        
        // Set the object's properties
        self.location = city + ", " + state
        self.id = event.id
        self.title = event.title
        self.url = event.url
        self.imageUrl = event.performers[0].image
        self.coordinates = CLLocationCoordinate2D(latitude: lat,
                                                  longitude: lon)
        
        // Format Date & Time
        do {
            self.date = try Formatting.formatDate(from: event.datetime_local)
            self.time = try Formatting.formatTime(from: event.datetime_local)
        } catch {
            fatalError(error.localizedDescription)
        }

    }
    
    init(id: Int,
         date: String,
         time: String,
         title: String,
         location: String,
         url: String,
         imageUrl: String,
         lon: Double,
         lat: Double) {
        self.id = id
        self.date = date
        self.time = time
        self.title = title
        self.location = location
        self.url = url
        self.imageUrl = imageUrl
        self.coordinates = CLLocationCoordinate2D(latitude: lat,
                                                  longitude: lon)
    }
    
    // MARK: - Load Image
    
    public func loadImage(completionHandler: @escaping (Bool) -> Void) { 
        
        // Check to see if image is already loaded
        if self.image != nil {
            completionHandler(true)
        }
        
        // Create the URL from the urlString
        guard let url = Foundation.URL(string: imageUrl) else {
            completionHandler(false)
            return
        }
        
        DispatchQueue.main.async {
            let imageView = UIImageView()
            
            imageView.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.cacheOriginalImage],
                                  completionHandler: { result in
                
                switch result {
                case .success(_):
                    self.image = imageView.image
                    completionHandler(true)
                case .failure(_):
                    // TODO: Handle error
                    completionHandler(false)
                }
            })
        }
    }
    
    // MARK: - Favorite
    
    public var isFavorited: Bool {
        return CoreDataManager.contains(self)
    }
    
    public func removeFavorite() {
        CoreDataManager.remove(self)
    }
    
    public func toggleFavorited() {
        if self.isFavorited {
            CoreDataManager.remove(self)
        } else {
            CoreDataManager.append(self)
        }
    }
}
