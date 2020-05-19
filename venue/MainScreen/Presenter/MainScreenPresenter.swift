//
//  MainScreenPresenter.swift
//  venue
//
//  Created by Dmitriy Butin on 10.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import Foundation
import GoogleMaps
import Firebase
import SwiftyJSON

/// Вывод информации
protocol MainScreenProtocol: class {
    func setMarkers(markers: [GMSMarker])
}

// это как мы принимаем информацию
protocol MainScreenPresenterProtocol: class {
    init(view: MainScreenProtocol, router: MainScreenRouterProtocol)
    func createMarkers()
    func startLocationService()
    func goAccountScreen()  ///удалить
    func goAddMarkerScreen()
    func goLoginScreen()
    func checkUserLoginStatus()
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    let view: MainScreenProtocol
    let router: MainScreenRouterProtocol
    var ref: DatabaseReference!
    
    
    required init(view: MainScreenProtocol, router: MainScreenRouterProtocol) {
        self.view = view
        self.router = router
    }///////////////////////////////////////////////////
   
    func startLocationService() {
        LocationService.shared.start()
        //createMarkers()
        loadAllEvents()
    }
    

    func checkUserLoginStatus() {
        Auth.auth().addStateDidChangeListener({[weak self] (auth, user) in
            if user != nil {
                self?.router.showAccountScreen()
            } else {
                self?.router.showLoginScreen()
            }
        })
    }
    
    func goAccountScreen() {   /// удалить позже
        router.showAccountScreen()
    }
    
    func goLoginScreen() {
        router.showLoginScreen()
    }
    
    func goAddMarkerScreen() {
        router.showAddMarkerScreen()
    }

    func loadAllEvents() {
        ref = Database.database().reference(withPath: "users")
        EventData.shared.publicUsers.removeAll()
        ref.observe(.value) { (snapshot) in
      
            for uid in snapshot.children.allObjects as! [DataSnapshot] {
                let publicUser = uid.key
                EventData.shared.publicUsers.append(publicUser)
                print("UserID = \(uid.key)")
            }
        }
        
        for pu in EventData.shared.publicUsers {
            ref.child(pu)
            
        }
        
        
//        ref = Database.database().reference().child("events")
//        print("...loadAllEvents>events")
//        let _ = ref.observe(.value, with: { (snapshot) in //refHandle
//            EventData.shared.events.removeAll()
//            for rest in snapshot.children.allObjects as! [DataSnapshot] {
//                let json = JSON(rest.value ?? [])
//                let nameEvent = json["nameEvent"].stringValue
//                let lat = json["lat"].doubleValue
//                let lng = json["lng"].doubleValue
//                let dateId = json["dateId"].doubleValue
//                let date = Date().addingTimeInterval(dateId)
//                let snipetEvent = json["snipetEvent"].stringValue
//                let coordinateEvent = CLLocationCoordinate2D(latitude: lat, longitude: lng)
//                let img = UIImage(systemName: "person")!
//             //   let event = Event(coordinateEvent: coordinateEvent, dateEvent: date, nameEvent: nameEvent, snipetEvent: snipetEvent, iconEvent: img)
//             //   MarkerData.shared.markers.append(event)
//            }
//
//           self.createMarkers()
//        })
    }
    
    func createMarkers() {
        var markers: [GMSMarker] = []
        let events = EventData.shared.events
        
        for event in events {
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: event.latEvent, longitude: event.lngEvent) )
            marker.icon = UIImage(named: event.iconEvent)
            marker.title = event.nameEvent
            marker.snippet = event.dateEventString
            markers.append(marker)
        }
    
        view.setMarkers(markers: markers)
    }

}
