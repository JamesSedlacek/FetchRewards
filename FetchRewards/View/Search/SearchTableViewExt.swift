//
//  SearchTableViewExt.swift
//  SearchTableViewExt
//
//  Created by James Sedlacek on 10/2/21.
//

import UIKit
import SkeletonView

extension SearchVC: UITableViewDelegate, SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return K.Identifiers.cellIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.cellIdentifier) as? EventTVCell else { return UITableViewCell() }
        cell.heartImageView.alpha = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = eventsToShow[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.cellIdentifier) as? EventTVCell else { return UITableViewCell() }

        // Labels
        cell.dateLabel.text = event.date
        cell.timeLabel.text = event.time
        cell.titleLabel.text = event.title
        
        // Images
        cell.heartImageView.alpha = event.isFavorited ? 1.0 : 0.0
        cell.displayedImageView.image = event.image
        
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
