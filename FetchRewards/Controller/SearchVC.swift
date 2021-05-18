//
//  SearchVC.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/18/21.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - Variables
    
    var eventsToShow: [Event] = [] //TODO: get from UserDefaults
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBActions
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() //remove extra lines at bottom
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
//        searchBar.resignFirstResponder()
    }

}

// MARK: - SearchBar Delegate

extension SearchVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 { return }
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
        //TODO: code
        return UITableViewCell()
    }
    
    
}
