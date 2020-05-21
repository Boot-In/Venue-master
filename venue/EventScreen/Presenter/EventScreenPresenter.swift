//
//  EventScreenPresenter.swift
//  venue
//
//  Created by Dmitriy Butin on 21.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import Foundation

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
   
    //view.setTextToView(nickName: <#T##String#>, eventData: <#T##String#>, eventName: <#T##String#>, eventCategory: <#T##String#>, eventDiscription: <#T##String#>)
    }


}
