//
//  ShowEventVC.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/18/21.
//

import UIKit

class ShowEventVC: UIViewController {
    
    // MARK: - Variables
    
    var eventToShow: Event?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var displayedImageView: UIImageView!
    
    // MARK: - IBActions
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        guard let safeEvent = eventToShow else { return }
        let isFavorited = UserDefaultsManager.contains(key: .Favorites, element: safeEvent.id)
        
        if isFavorited {
            UserDefaultsManager.remove(favoriteID: safeEvent.id)
        } else {
            UserDefaultsManager.append(favoriteID: safeEvent.id)
        }
        
        setHeartIcon()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setHeartIcon()
    }
    
    private func setup() {
        guard let safeEvent = eventToShow else { return }
        displayedImageView.image = safeEvent.image
        displayedImageView.layer.cornerRadius = 8
        displayedImageView.clipsToBounds = true
        titleLabel.text = safeEvent.title
        dateLabel.text = safeEvent.date + " " + safeEvent.time
        locationLabel.text = safeEvent.location
    }
    
    private func setHeartIcon() {
        guard let safeEvent = eventToShow else { return }
        let isFavorited = UserDefaultsManager.contains(key: .Favorites, element: safeEvent.id)
        let iconImage = isFavorited ? K.Images.heartFilled : K.Images.emptyHeart
        heartButton.tintColor = isFavorited ? .red : .black
        heartButton.setImage(iconImage, for: .normal)
    }

}
