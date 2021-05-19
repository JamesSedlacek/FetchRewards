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
        self.date = ""
        self.time = ""
        self.image = nil
        formatDateAndTime(from: dateTime)
        loadImage()
    }
    
    // MARK: - Formatting Date & Time

    private func formatDateAndTime(from dateTime: String) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //Z
        if let safeDate = dateFormatterGet.date(from: dateTime) {
            //Formatted date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, dd MMM yyyy"
            self.date = dateFormatter.string(from: safeDate)
            
            //Formatted time
            let timeFormatter = DateFormatter()
            timeFormatter.locale = Locale(identifier: "en_US_POSIX")
            timeFormatter.dateFormat = "hh:mm a"
            timeFormatter.amSymbol = "AM"
            timeFormatter.pmSymbol = "PM"
            self.time = timeFormatter.string(from: safeDate)
        }
    }
    
    // MARK: - Load Image
    
    private func loadImage() {
        guard let imageURL = URL(string: self.imageUrlString) else { return }
                
        getData(from: imageURL, completion: { data, response, error in
            if error != nil {
                print("Error: \(String(describing: error))")
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
