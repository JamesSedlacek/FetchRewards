//
//  EventVM.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/22/21.
//

import UIKit
import CoreLocation

public class EventVM {
    
    // MARK: - Variables
    
    private let event: Event
    public var date: String
    public var time: String
    public var image: UIImage?
    
    public var title: String {
        return event.title
    }
    
    public var location: String {
        return event.city + ", " + event.state
    }
    
    public var url: String {
        return event.url
    }
    
    public var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: event.lat,
                                      longitude: event.lon)
    }
    
    public var isFavorited: Bool {
        return UserDefaultsManager.contains(key: .Favorites,
                                            element: event.id)
    }
    
    // MARK: - initializer
    
    init(event: Event) {
        self.event = event
        
        do {
            self.date = try Formatting.formatDate(from: event.dateTime)
            self.time = try Formatting.formatTime(from: event.dateTime)
        } catch {
            fatalError(error.localizedDescription)
        }

        self.image = nil
        loadImage()
    }
    
    // MARK: - Toggle Favorited
    
    public func toggleFavorited() {
        if self.isFavorited {
            UserDefaultsManager.remove(favoriteID: event.id)
        } else {
            UserDefaultsManager.append(favoriteID: event.id)
        }
    }
    
    // MARK: - Load Image
    
    private func loadImage() {
        guard let imageURL = URL(string: self.event.imageUrlString) else { return }
                
        getData(from: imageURL, completion: { data, response, error in
            if error != nil {
                fatalError("Error: \(String(describing: error))")
            }
            
            if let safeData = data {
                self.image = UIImage(data: safeData as Data)!
            }
            
            DispatchQueue.main.async {
                let name = K.NSNotificationName.UpdateTableView.rawValue
                NotificationCenter.default.post(name:NSNotification.Name(rawValue: name),
                                                object: nil)
            }
        })
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
