//
//  EventsTableViewPresenter.swift
//  venue
//
//  Created by Dmitriy Butin on 22.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//
import Foundation
/// Вывод информации
protocol EventsTableViewProtocol: class {
    
}

// это как мы принимаем информацию
protocol EventsTableViewPresenterProtocol: class {
    init(view: EventsTableViewProtocol, router: EventsTableViewRouterProtocol)
    
    func markerFiltred(range: Int) -> [Event]
    func goToEventScreen()
}

class EventsTableViewPresenter: EventsTableViewPresenterProtocol {
    
    let view: EventsTableViewProtocol
    let router: EventsTableViewRouterProtocol
    
    required init(view: EventsTableViewProtocol, router: EventsTableViewRouterProtocol) {
        self.view = view
        self.router = router
    }///////////////////////////////////////////////////
   

    func markerFiltred(range: Int) -> [Event] {
        let events = DataService.shared.events
        var eventsFiltred:[Event] = []
        let today = Date().timeIntervalSince1970
        print("Сегодня: ", today, Date(timeIntervalSince1970: today))
        var interval = 0.0
        
        switch range {
        case 0: interval = today + 86400           //день
        case 1: interval = today + (86400*7)       //неделя
        case 2: interval = today + (86400*30)      //месяц
        default: interval = today + (86400*365)    //год
        }
        for event in events {
            if interval - event.dateEventTI > 0 && (event.dateEventTI + 80000 - today) > 0 {
                eventsFiltred.append(event)
            }
        }
        eventsFiltred.sort { $0.dateEventTI < $1.dateEventTI}
        print("В отфильтрованном массиве \(eventsFiltred.count) элементов")
        return eventsFiltred
    }
    
    func goToEventScreen() {
        router.showEventScreen()
    }
    
    
}
