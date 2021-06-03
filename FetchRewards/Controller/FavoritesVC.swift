//
//  FavoritesVC.swift
//  FetchRewards
//
//  Created by James Sedlacek on 6/2/21.
//

import UIKit

class FavoritesVC: UIViewController {
    
    // MARK: - Variables
    
    var eventDelegate: EventDelegate?
    var eventsToShow: [EventVM] = []
    var selectedEvent: EventVM?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBActions
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        getFavorites()
    }
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupTableView()
        addObserver()
        getFavorites()
    }
    
    private func getFavorites() {
        ApiManager.eventDelegate = self
        eventsToShow = []
        ApiManager.fetchFavorites()
    }
    
    private func addObserver() {
        let name = K.NSNotificationName.UpdateTableView.rawValue
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTableView),
                                               name: NSNotification.Name(rawValue: name),
                                               object: .none)
    }

    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView() //remove extra lines at bottom
        tableView.register(UINib(nibName: K.Identifiers.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: K.Identifiers.cellIdentifier)
    }
    
    @objc private func updateTableView() {
        tableView.reloadData()
    }
    
    // MARK: - perform segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ShowEventVC,
           let safeEvent = selectedEvent {
            vc.eventToShow = safeEvent
            vc.modalPresentationStyle = .fullScreen
        }
    }
}

// MARK: - tableview Delegate Datasource

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if eventsToShow.count == 0 { return UITableViewCell() }
        let event = eventsToShow[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.cellIdentifier) as? EventTVCell,
              let image = eventsToShow[indexPath.row].image else { return UITableViewCell() }

        //Labels
        cell.dateLabel.text = event.date
        cell.timeLabel.text = event.time
        cell.titleLabel.text = event.title
        
        //Images
        cell.displayedImageView.image = image
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
        self.navigationController?.navigationBar.isHidden = true
        performSegue(withIdentifier: K.Identifiers.showEventSegue, sender: nil)
    }
    
}

// MARK: - Event Delegate

extension FavoritesVC: EventDelegate {
    func updateEvents(events: [EventVM]) {
        eventsToShow = events
    }
}
