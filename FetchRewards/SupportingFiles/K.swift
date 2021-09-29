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
    
    // MARK: - Colors
    
    struct Colors {
        static let accent = UIColor(named: "AccentColor")
    }
    
    // MARK: - Fonts
    
    struct Fonts {
        static let navBarFont = UIFont.systemFont(ofSize: 22,
                                                  weight: .semibold)
    }
    
    // MARK: - Numbers
    
    struct Numbers {
        static let rowHeight: CGFloat = 200
        static let cornerRadius: CGFloat = 8
    }
    
    // MARK: - Notification Name
    
    enum NSNotificationName: String {
        case UpdateTableView = "UpdateTableView"
    }
    
    // MARK: - SearchBar Keys
    
    enum SearchBarKeys: String {
        case cancelButton = "cancelButton"
        case searchField = "searchField"
    }
    
    // MARK: - ValidationError
    
    enum ValidationError: LocalizedError {
        case invalidDateTime
        
        var errorDescription: String? {
            switch self {
            case .invalidDateTime:
                return "The DateTime is not in the correct format."
            }
        }
    }
    
}
