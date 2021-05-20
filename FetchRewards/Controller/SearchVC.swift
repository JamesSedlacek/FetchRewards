//
//  SearchVC.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/18/21.
//

import UIKit

// MARK: - Protocols

protocol EventDelegate {
    func updateEvents(events: [Event])
}

// MARK: - SearchVC Class

class SearchVC: UIViewController {
    
    // MARK: - Variables
    
    var eventsToShow: [Event] = [] 
    var eventDelegate: EventDelegate?
    var selectedEvent: Event?
    
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
    func updateEvents(events: [Event]) {
        eventsToShow = events
    }
}
