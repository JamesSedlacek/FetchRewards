//
//  SearchVC.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/18/21.
//

import UIKit

protocol EventDelegate {
    func updateEvents(events: [Event])
}

class SearchVC: UIViewController {
    
    // MARK: - Variables
    
    var eventsToShow: [Event] = [] //TODO: get from UserDefaults
    var eventDelegate: EventDelegate?
    var selectedEvent: Event?
    let cellIdentifier = "EventTVCell"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBActions
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        ApiManager.eventDelegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTableView),
                                               name: NSNotification.Name(rawValue: "UpdateTableView"),
                                               object: .none)
    }
    
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() //remove extra lines at bottom
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField,
            let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {

                //Magnifying glass
                glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                glassIconView.tintColor = .white
        }
        searchBar.searchTextField.textColor = .white
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
//        searchBar.resignFirstResponder()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? EventTVCell else { return UITableViewCell() }
        
        guard let image = eventsToShow[indexPath.row].image else { return UITableViewCell() }
        
        cell.awakeFromNib()
        cell.dateLabel.text = eventsToShow[indexPath.row].date
        cell.timeLabel.text = eventsToShow[indexPath.row].time
        cell.titleLabel.text = eventsToShow[indexPath.row].title
        cell.displayedImageView.image = image
        
        //TODO: fix logic when persistence is done, if needed
        if !eventsToShow[indexPath.row].isFavorited {
            cell.heartImageView.alpha = 0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = eventsToShow[indexPath.row]
        performSegue(withIdentifier: "ShowEventSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: - Event Delegate

extension SearchVC: EventDelegate {
    func updateEvents(events: [Event]) {
        eventsToShow = events
    }
}
