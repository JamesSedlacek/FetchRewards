//
//  SearchVC.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/18/21.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - Variables
    
    internal var eventsToShow: [EventVM] = []
    internal var selectedEvent: EventVM?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() // remove extra lines at bottom
        tableView.register(UINib(nibName: K.Identifiers.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: K.Identifiers.cellIdentifier)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: K.SearchBarKeys.searchField.rawValue) as? UITextField,
            let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {

                //Magnifying glass
                glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                glassIconView.tintColor = .white
        }
        searchBar.searchTextField.textColor = .white
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
}
