//
//  SearchExtensions.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/22/21.
//

import UIKit

// MARK: - SearchBar Delegate

extension SearchVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        eventsToShow = []
        dismissKeyboard()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            eventsToShow = []
            tableView.reloadData()
            return
        }
        //replacing spaces with plus signs for querying
        let safeString = searchText.replacingOccurrences(of: " ", with: "+")
        ApiManager.fetchEvents(for: safeString)
    }
}

// MARK: - TableView Delegate

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.cellIdentifier) as? EventTVCell else { return UITableViewCell() }
        
        guard let image = eventsToShow[indexPath.row].image else { return UITableViewCell() }
        
        cell.awakeFromNib()
        cell.dateLabel.text = eventsToShow[indexPath.row].date
        cell.timeLabel.text = eventsToShow[indexPath.row].time
        cell.titleLabel.text = eventsToShow[indexPath.row].title
        cell.displayedImageView.image = image
        
        let isFavorited = UserDefaultsManager.contains(key: .Favorites,
                                                       element: eventsToShow[indexPath.row].id)
        
        cell.heartImageView.alpha = isFavorited ? 1.0 : 0.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = eventsToShow[indexPath.row]
        performSegue(withIdentifier: K.Identifiers.showEventSegue, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.Numbers.rowHeight
    }
}

// MARK: - Event Delegate

extension SearchVC: EventDelegate {
    func updateEvents(events: [EventVM]) {
        eventsToShow = events
    }
}
