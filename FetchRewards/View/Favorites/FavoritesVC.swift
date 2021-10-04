//
//  FavoritesVC.swift
//  FetchRewards
//
//  Created by James Sedlacek on 6/2/21.
//

import UIKit
import SkeletonView

class FavoritesVC: UIViewController {
    
    // MARK: - Variables
    
    internal var eventsToShow: [EventVM] = []
    internal var selectedEvent: EventVM?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavBar()
        
        eventsToShow = CoreDataManager.getAll()
        setupTableView()
        
        // If there are events to show, load their images
        if eventsToShow.count > 0 {
            loadImages()
        }
    }
    
    // MARK: - Setup
    
    private func setupNavBar() {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = K.Colors.accent
        appearance.titleTextAttributes = [ .foregroundColor : UIColor.white,
                                           .font : K.Fonts.navBar]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() //remove extra lines at bottom
        tableView.register(UINib(nibName: K.Identifiers.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: K.Identifiers.cellIdentifier)
        tableView.reloadData()
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .clouds,
                                                                    secondaryColor: K.Colors.accent ?? .lightGray),
                                               animation: nil,
                                               transition: .crossDissolve(0.25))
    }
    
    // MARK: - perform segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ShowEventVC,
           let safeEvent = selectedEvent {
            vc.eventToShow = safeEvent
            vc.modalPresentationStyle = .fullScreen
            vc.hidesBottomBarWhenPushed = true
        }
    }
    
    // MARK: - Update TableView
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.stopSkeletonAnimation()
            self.view.hideSkeleton()
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Load Images
    
    private func loadImages() {
        var imagesLoadedCount = 0
        for event in eventsToShow {
            event.loadImage(completionHandler: { [weak self] wasImageLoaded in
                guard let self = self else { return }
                if wasImageLoaded {
                    imagesLoadedCount += 1
                    
                    // Update tableview when ALL images are loaded
                    if imagesLoadedCount == self.eventsToShow.count {
                        self.updateTableView()
                    }
                } else {
                    // TODO: Handle image loading error
                }
            })
        }
    }
   
}
