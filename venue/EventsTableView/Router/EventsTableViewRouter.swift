//
//  EventsTableViewRouter.swift
//  venue
//
//  Created by Dmitriy Butin on 22.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

protocol EventsTableViewRouterProtocol: class {

  
}

final class EventsTableViewRouter: EventsTableViewRouterProtocol {
    
    weak var view: EventsTableViewController?
    weak var presenter: EventsTableViewPresenter?
    
    init(with vc: EventsTableViewController) {
        self.view = vc
    }
    
//func showAccountScreen() {
//    let accountScreenVC = ModuleBulder.accountScreen()
//    view?.navigationController?.pushViewController(accountScreenVC, animated: true)
//   // accountScreenVC.modalPresentationStyle = .fullScreen
//   // view?.present(accountScreenVC, animated: true)
//}
    
   
}
