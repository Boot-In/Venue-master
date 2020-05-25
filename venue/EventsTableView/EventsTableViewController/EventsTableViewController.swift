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
    
    var events: [Event]!
    var eventsFiltred: [Event]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeSC.selectedSegmentIndex = 3
        events = presenter.markerFiltred(range: rangeSC.selectedSegmentIndex)
        eventsFiltred = events
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        searchBar.delegate = self
        eventsTableView.backgroundColor = .clear
        eventsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        print("Элементов для таблицы = ", events.count)
        
        searchBar.barTintColor = view.backgroundColor
        
        rangeSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .selected)
        rangeSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
        //rangeSC.backgroundColor = .clear
        //rangeSC.selectedSegmentTintColor = .systemGray
    }
    
    @IBAction func rangeSCAction(_ sender: UISegmentedControl) {
        events = presenter.markerFiltred(range: sender.selectedSegmentIndex)
        eventsFiltred = events
        eventsTableView.reloadData()
    }
    
    @IBAction func removeOldEvents() {
        if let oldEvents = DataService.shared.oldEventsID, oldEvents.count > 0 {
        NetworkService.removeOldEvent(eventsID: oldEvents)
        } else { print("Старых событий нет.") }
    }
    
    @IBAction func backButtonTap() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension EventsTableViewController: EventsTableViewProtocol {
    
}

extension EventsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsFiltred.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EventTableViewCell
        cell.backgroundColor = .clear
        let event = eventsFiltred[indexPath.row]
        cell.nameEventLabel.text = "\(event.dateEventString) \(event.nameEvent)"
        cell.discriptionEventLabel.text = event.discriptionEvent
        cell.nickNameEventLabel.text = "Организатор: \(event.userNick)"
        cell.eventImage.image = UIImage(named: event.iconEvent)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataService.shared.event = eventsFiltred[indexPath.row]
        DataService.shared.eventID = eventsFiltred[indexPath.row].eventID
        presenter.goToEventScreen()
    }
    
}

extension EventsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        eventsFiltred = events
        
        if searchText.isEmpty == false {
            eventsFiltred = events.filter({ $0.nameEvent.lowercased().contains(searchText.lowercased()) })
        }
        eventsTableView.reloadData()
    }
}
