//
//  EventsTableViewController.swift
//  venue
//
//  Created by Dmitriy Butin on 22.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import UIKit

class EventsTableViewController: UIViewController {
    
    var presenter: EventsTableViewPresenterProtocol!
    
    @IBOutlet weak var rangeSC: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var eventsTableView: UITableView!
    
    let events = DataService.shared.events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // eventsTableView.delegate = self
       // eventsTableView.dataSource = self
     
    }
    
    
    @IBAction func backButtonTap() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

extension EventsTableViewController: EventsTableViewProtocol {
    
}

extension EventsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EventTableViewCell
        let event = events[indexPath.row]
        cell.nameEventLabel.text = "\(event.dateEventString) \(event.nameEvent)"
        cell.discriptionEventLabel.text = event.discriptionEvent
        cell.nickNameEventLabel.text = "Организатор: \(event.userNick)"
        return cell
    }
    
    
}
