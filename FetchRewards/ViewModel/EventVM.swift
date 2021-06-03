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
    
    private let id: Int
    public let date: String
    public let time: String
    public let title: String
    public let location: String
    public let url: String
    public let coordinates: CLLocationCoordinate2D
    public var image: UIImage?
    
    public var isFavorited: Bool {
        return UserDefaultsManager.contains(key: .Favorites,
                                            element: id)
    }
    
    // MARK: - initializer
    
    init(event: Event) {
        id = event.id
        title = event.title
        location = event.city + ", " + event.state
        url = event.url
        coordinates = CLLocationCoordinate2D(latitude: event.lat,
                                             longitude: event.lon)
        
        do {
            self.date = try Formatting.formatDate(from: event.dateTime)
            self.time = try Formatting.formatTime(from: event.dateTime)
        } catch {
            fatalError(error.localizedDescription)
        }

        self.image = nil
        loadImage(from: event.imageUrlString)
    }
    
    // MARK: - Toggle Favorited
    
    public func toggleFavorited() {
        if self.isFavorited {
            UserDefaultsManager.remove(favoriteID: id)
        } else {
            UserDefaultsManager.append(favoriteID: id)
        }
    }
    
    // MARK: - Load Image
    
    private func loadImage(from urlString: String) {
        guard let imageURL = URL(string: urlString) else { return }
                
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
    
    public func removeFavorite() {
        UserDefaultsManager.remove(favoriteID: id)
    }
}
