//
//  EventScreenRouter.swift
//  venue
//
//  Created by Dmitriy Butin on 21.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

protocol EventScreenRouterProtocol: class {

  
}

final class EventScreenRouter: EventScreenRouterProtocol {
    
    weak var view: EventScreenViewController?
    weak var presenter: EventScreenPresenter?
    
    init(with vc: EventScreenViewController) {
        self.view = vc
    }
    
//func showAccountScreen() {
//    let accountScreenVC = ModuleBulder.accountScreen()
//    view?.navigationController?.pushViewController(accountScreenVC, animated: true)
//   // accountScreenVC.modalPresentationStyle = .fullScreen
//   // view?.present(accountScreenVC, animated: true)
//}
    
   
}
