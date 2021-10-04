//
//  SearchBarExt.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/22/21.
//

import UIKit
import SkeletonView
import SCLAlertView

extension SearchVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true) // Dismiss Keyboard
        searchBar.text = ""
        eventsToShow = []
        tableView.reloadData()
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true) // Dismiss Keyboard
        
        guard let searchText = searchBar.text else {
            eventsToShow = []
            tableView.reloadData()
            return
        }
        
        // replacing spaces with plus signs for querying
        let safeString = searchText.replacingOccurrences(of: " ", with: "+")
        
        tableView.reloadData()
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .clouds,
                                                                    secondaryColor: K.Colors.accent ?? .lightGray),
                                               animation: nil,
                                               transition: .crossDissolve(0.25))
        
        NetworkingManager.fetchEvents(for: safeString, completionHandler: { [weak self] result in
            guard let self = self else { return }

            switch result {

            case .success(let fetchedEvents):
                
                // No Results Found
                if fetchedEvents.count == 0 {
                    DispatchQueue.main.async {
                        let alertView = SCLAlertView()
                        alertView.showError("No Results Found",
                                            subTitle: "Try changing what you're searching for.")
                        self.updateTableView()
                    }
                    return
                }
                
                // Load images for the results found
                var imagesLoadedCount = 0
                self.eventsToShow = fetchedEvents
                for event in self.eventsToShow {
                    event.loadImage(completionHandler: { wasImageLoaded in
                        if wasImageLoaded {
                            imagesLoadedCount += 1
                            
                            // Update tableview when ALL images are loaded
                            if imagesLoadedCount == fetchedEvents.count {
                                self.updateTableView()
                            }
                        } else {
                            // TODO: Handle image loading error
                        }
                    })
                }

            case .failure(let networkingError):
                DispatchQueue.main.async {
                    let alertView = SCLAlertView()
                    switch networkingError {
                    case .badURL:
                        alertView.showError("Networking Error",
                                            subTitle: "There was a bad url.")
                    case .dataTask:
                        alertView.showError("Networking Error",
                                            subTitle: "Something went wrong with the data task.")
                    case .nilData:
                        alertView.showError("Networking Error",
                                            subTitle: "Data was empty!")
                    case .jsonDecoding:
                        alertView.showError("Networking Error",
                                            subTitle: "JSON Decoding error.")
                    }
                    
                    self.updateTableView()
                }
            }

        })
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.stopSkeletonAnimation()
            self.view.hideSkeleton()
            self.tableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
}

