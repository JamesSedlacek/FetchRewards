//
//  MapVC.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/19/21.
//

import UIKit
import CoreLocation
import MapKit

class MapVC: UIViewController {
    
    // MARK: - Variables
    
    var eventLocation: CLLocationCoordinate2D?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupBackButton()
    }
    
    func setupBackButton() {
        backButton.layer.cornerRadius = backButton.layer.frame.width / 2
        backButton.clipsToBounds = true
    }
    
    func setupMap() {
        guard let safeLocation = eventLocation else {
            navigationController?.popViewController(animated: true)
            return
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = safeLocation
        mapView.addAnnotation(annotation)
        let mapCamera = MKMapCamera(lookingAtCenter: safeLocation,
                                    fromDistance: 2000,
                                    pitch: 75,
                                    heading: 0)
        mapView.setCamera(mapCamera, animated: true)
    }

}
