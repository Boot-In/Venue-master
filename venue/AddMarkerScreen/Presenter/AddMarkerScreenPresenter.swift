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
import CoreLocation

/// Вывод информации
protocol AddMarkerScreenProtocol: class {
    func fieldInfo(nik: String, name: String, caregiry: String, icon: String, discription: String)
}

// это как мы принимаем информацию
protocol AddMarkerScreenPresenterProtocol: class {
    init(view: AddMarkerScreenProtocol, router: AddMarkerScreenRouterProtocol)
    
    func saveEvent(nameEvent: String, iconEvent: String, discrEvent: String)
    func loadTFFromEvent(event: Event)
}

class AddMarkerScreenPresenter: AddMarkerScreenPresenterProtocol {
    
    let view: AddMarkerScreenProtocol
    let router: AddMarkerScreenRouterProtocol
    
    required init(view: AddMarkerScreenProtocol, router: AddMarkerScreenRouterProtocol) {
        self.view = view
        self.router = router
       
    }///////////////////////////////////////////////////
   
    func loadTFFromEvent(event: Event) {
        let coordinate = CLLocationCoordinate2D(latitude: event.latEvent, longitude: event.lngEvent)
        DataService.shared.coordinateEvent = coordinate
        view.fieldInfo(nik: event.userNick, name: event.nameEvent, caregiry: event.snipetEvent, icon: event.iconEvent, discription: event.discriptionEvent)
    }
    
    func saveEvent(nameEvent: String, iconEvent: String, discrEvent: String) {
        let coordinate = DataService.shared.coordinateEvent
        let date = DataService.shared.dateEvent
        guard let user = Auth.auth().currentUser else { return }
        let userNick = DataService.shared.localUser.niсkNameUser
        var event = Event(userID: user.uid, userNick: userNick, nameEvent: nameEvent, coordinate: coordinate, date: date)
        event.dateEventString = DataService.shared.dataEventString
        event.iconEvent = iconEvent
        event.discriptionEvent = discrEvent
        event.snipetEvent = DataService.shared.categoryEvent
        /// DataService.shared.events.append(event)  ????
        /// Сохранение
        let ref = Database.database().reference()
        let eventRef = ref.child("events").child(getEventID(event))
        eventRef.setValue([
            "userID" : event.userID,
            "eventID" : getEventID(event),
            "userNick": event.userNick,
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
        print("EventID = \(getEventID(event))")
    }

    func getEventID(_ event: Event) -> String {
        var iD = ""
        iD += String(event.userID[event.userID.startIndex]).lowercased()
        iD += String(Int(event.dateEventTI))
        iD += String(event.userID[event.userID.index(before: event.userID.endIndex)]).lowercased()
        iD += String(event.nameEvent.count)
        iD += String(Int(event.latEvent))+String(Int(event.lngEvent))
        return iD
    }

}
