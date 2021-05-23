//
//  SearchVC.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/18/21.
//

import UIKit

// MARK: - Protocols

protocol EventDelegate {
    func updateEvents(events: [EventVM])
}

// MARK: - SearchVC Class

class SearchVC: UIViewController {
    
    // MARK: - Variables
    
    var eventsToShow: [EventVM] = []
    var eventDelegate: EventDelegate?
    var selectedEvent: EventVM?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupTableView()
        setupSearchBar()
        addObserver()
    }
    
    private func setDelegates() {
        ApiManager.eventDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func addObserver() {
        let name = K.NSNotificationName.UpdateTableView.rawValue
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTableView),
                                               name: NSNotification.Name(rawValue: name),
                                               object: .none)
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView() //remove extra lines at bottom
        tableView.register(UINib(nibName: K.Identifiers.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: K.Identifiers.cellIdentifier)
    }
    
    private func setupSearchBar() {
        if let cancelButton = searchBar.value(forKey: K.SearchBarKeys.cancelButton.rawValue) as? UIButton {
            cancelButton.isEnabled = true
        }
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: K.SearchBarKeys.searchField.rawValue) as? UITextField,
            let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {

                //Magnifying glass
                glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                glassIconView.tintColor = .white
        }
        searchBar.searchTextField.textColor = .white
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func updateTableView() {
        tableView.reloadData()
    }
    
    // MARK: - perform segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ShowEventVC,
           let safeEvent = selectedEvent {
            vc.eventToShow = safeEvent
        }
    }
}
