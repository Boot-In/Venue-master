//
//  AddMarkerScreenPresenter.swift
//  venue
//
//  Created by Dmitriy Butin on 11.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

/// Вывод информации
protocol AddMarkerScreenProtocol: class {
    
}

// это как мы принимаем информацию
protocol AddMarkerScreenPresenterProtocol: class {
    init(view: AddMarkerScreenProtocol, router: AddMarkerScreenRouterProtocol)
    func saveEvent(nameEvent: String, iconEvent: String, discrEvent: String)
}

class AddMarkerScreenPresenter: AddMarkerScreenPresenterProtocol {
    
    let view: AddMarkerScreenProtocol
    let router: AddMarkerScreenRouterProtocol
    
    required init(view: AddMarkerScreenProtocol, router: AddMarkerScreenRouterProtocol) {
        self.view = view
        self.router = router
       
    }///////////////////////////////////////////////////
   
    func saveEvent(nameEvent: String, iconEvent: String, discrEvent: String) {
        let coordinate = DataService.shared.coordinateEvent
        let date = DataService.shared.dateEvent
        guard let user = Auth.auth().currentUser else { return }
        var event = Event(userID: user.uid, nameEvent: nameEvent, coordinate: coordinate, date: date)
        event.dateEventString = DataService.shared.dataEventString
        event.iconEvent = iconEvent
        event.discriptionEvent = discrEvent
        event.snipetEvent = DataService.shared.categoryEvent
        DataService.shared.events.append(event)
        /// Сохранение
        let ref = Database.database().reference()
        let eventRef = ref.child("events").child(getEventID(event))
        eventRef.setValue([
            "userID" : event.userID,
            "nameEvent" : event.nameEvent,
            "latEvent" : event.latEvent,
            "lngEvent" : event.lngEvent,
            "dateEventString" : event.dateEventString,
            "dateEventTI" : event.dateEventTI,
            "snipetEvent" : event.snipetEvent,
            "discriptionEvent" : event.discriptionEvent,
            "iconEvent" : event.iconEvent,
            "lifeTimeEvent" : event.lifeTimeEvent
        ])
        print("saveEvent Complete !")
   
    }

    func getEventID(_ event: Event) -> String {
        var iD = ""
        iD += String(event.userID[event.userID.startIndex]).lowercased()
        iD += String(Int(event.dateEventTI))
        iD += String(event.userID[event.userID.index(before: event.userID.endIndex)]).lowercased()
        iD += String(event.nameEvent.count)
        iD += String(Int(event.latEvent))+String(Int(event.lngEvent))
        print("EventID = \(iD)")
        return iD
    }

}
