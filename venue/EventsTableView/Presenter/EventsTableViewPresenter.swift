//
//  EventsTableViewPresenter.swift
//  venue
//
//  Created by Dmitriy Butin on 22.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

/// Вывод информации
protocol EventsTableViewProtocol: class {
    
}

// это как мы принимаем информацию
protocol EventsTableViewPresenterProtocol: class {
    init(view: EventsTableViewProtocol, router: EventsTableViewRouterProtocol)
    
}

class EventsTableViewPresenter: EventsTableViewPresenterProtocol {
    
    let view: EventsTableViewProtocol
    let router: EventsTableViewRouterProtocol
    
    required init(view: EventsTableViewProtocol, router: EventsTableViewRouterProtocol) {
        self.view = view
        self.router = router
    }///////////////////////////////////////////////////
   

    
    
}
