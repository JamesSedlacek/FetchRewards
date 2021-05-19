//
//  K.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/19/21.
//

import UIKit

struct K {
    
    // MARK: - Identifiers
    
    struct Identifiers {
        static let cellIdentifier = "EventTVCell"
        static let showEventSegue = "ShowEventSegue"
        static let mapSegue = "MapSegue"
    }
    
    // MARK: - Images
    
    struct Images {
        static let heartFilled = UIImage(systemName: "heart.fill")
        static let emptyHeart = UIImage(systemName: "heart")
    }
    
    // MARK: - Numbers
    
    struct Numbers {
        static let rowHeight: CGFloat = 200
    }
    
    // MARK: - Notification Name
    
    enum NSNotificationName: String {
        case UpdateTableView = "UpdateTableView"
    }
    
}
