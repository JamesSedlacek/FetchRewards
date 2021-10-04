//
//  FavoritesTableViewExt.swift
//  FavoritesTableViewExt
//
//  Created by James Sedlacek on 10/2/21.
//

import UIKit
import SkeletonView

extension FavoritesVC: UITableViewDelegate, SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToShow.count
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
        if eventsToShow.count == 0 { return UITableViewCell() }
        let event = eventsToShow[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.cellIdentifier) as? EventTVCell else { return UITableViewCell() }

        //Labels
        cell.dateLabel.text = event.date
        cell.timeLabel.text = event.time
        cell.titleLabel.text = event.title
        
        //Images
        cell.displayedImageView.image = event.image
        cell.heartImageView.alpha = 1.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.Numbers.rowHeight
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            eventsToShow[indexPath.row].removeFavorite()
            eventsToShow.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = eventsToShow[indexPath.row]
        performSegue(withIdentifier: K.Identifiers.showEventSegue, sender: nil)
    }
    
}
