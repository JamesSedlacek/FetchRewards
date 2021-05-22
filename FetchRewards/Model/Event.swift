//
//  Event.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/18/21.
//

import UIKit
import CoreLocation

class Event {
    var title: String
    var date: String
    var time: String
    var location: String
    var imageUrlString: String
    var image: UIImage?
    var id: Int
    var url: String
    var coordinates: CLLocationCoordinate2D
    
    init(id: Int,
         title: String,
         dateTime: String,
         location: String,
         imageUrlString: String,
         url: String,
         coordinates: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.location = location
        self.url = url
        self.imageUrlString = imageUrlString
        self.coordinates = coordinates
        
        do {
            self.date = try Formatting.formatDate(from: dateTime)
            self.time = try Formatting.formatTime(from: dateTime)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        self.image = nil
        loadImage()
    }
    
    // MARK: - Load Image
    
    private func loadImage() {
        guard let imageURL = URL(string: self.imageUrlString) else { return }
                
        getData(from: imageURL, completion: { data, response, error in
            if error != nil {
                fatalError("Error: \(String(describing: error))")
            }
            
            if let safeData = data {
                self.image = UIImage(data: safeData as Data)
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
