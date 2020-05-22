//
//  EventScreenPresenter.swift
//  venue
//
//  Created by Dmitriy Butin on 21.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import GoogleMaps

/// Вывод информации
protocol EventScreenProtocol: class {
    
  func setTextToView(nickName: String, eventData: String, eventName: String, eventCategory: String, eventDiscription: String)
}

// это как мы принимаем информацию
protocol EventScreenPresenterProtocol: class {
    init(view: EventScreenProtocol, router: EventScreenRouterProtocol)
    
  func loadEventInfo()
}

class EventScreenPresenter: EventScreenPresenterProtocol {
    
    let view: EventScreenProtocol
    let router: EventScreenRouterProtocol
    
    required init(view: EventScreenProtocol, router: EventScreenRouterProtocol) {
        self.view = view
        self.router = router
    }///////////////////////////////////////////////////
   
  func loadEventInfo() {
    guard let marker = DataService.shared.marker else { return }
    guard let event = searchEvent(marker: marker) else { return }
    view.setTextToView(nickName: "Организатор: \(event.userNick)", eventData: event.dateEventString, eventName: event.nameEvent, eventCategory: event.snipetEvent, eventDiscription: event.discriptionEvent)
    }

    func searchEvent(marker: GMSMarker) -> Event? {
        let events = DataService.shared.events
        var events_ = events
        var i = (events_.count - 1)
        while i >= 0 {
            if marker.title != "\(events_[i].dateEventString) \(events_[i].nameEvent)" {
                events_.remove(at: i)
            } else if marker.position.latitude != events_[i].latEvent && marker.position.longitude != events_[i].lngEvent {
                events_.remove(at: i)
            }
            i -= 1
        }
        print("Мероприятий = ", events_.count)
        return events_.last
    }
    
    
}
