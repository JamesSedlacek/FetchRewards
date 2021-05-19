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
        safeEvent.isFavorited.toggle()
        setHeartIcon()
        //TODO: Add-to/remove-from favorited events
        //TODO: persist data
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setHeartIcon()
    }
    
    private func setup() {
        guard let safeEvent = eventToShow else { return }
        displayedImageView.layer.cornerRadius = 8
        displayedImageView.clipsToBounds = true
        displayedImageView.image = safeEvent.image
        titleLabel.text = safeEvent.title
        dateLabel.text = safeEvent.date + " " + safeEvent.time
        locationLabel.text = safeEvent.location
    }
    
    private func setHeartIcon() {
        guard let safeEvent = eventToShow else { return }
        let iconImage = safeEvent.isFavorited ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        heartButton.setImage(iconImage, for: .normal)
        heartButton.tintColor = safeEvent.isFavorited ? .red : .black
    }

}
