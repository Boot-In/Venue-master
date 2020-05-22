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
    func goAddMarkerScreen()
    func goLoginScreen()
    func goToEventScreen()
    func goToEventTableView()
    func checkUserLoginStatus()
    func checkUserStatus()
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    let view: MainScreenProtocol
    let router: MainScreenRouterProtocol
    var ref: DatabaseReference!
    var user: User?
    
    required init(view: MainScreenProtocol, router: MainScreenRouterProtocol) {
        self.view = view
        self.router = router
    }///////////////////////////////////////////////////
   
    func startLocationService() {
        LocationService.shared.start()
        //createMarkers()
        loadAllEvents()
    }
    
    func checkUserLoginStatus () {
        print("...checkUserLoginStatus")
        Auth.auth().addStateDidChangeListener({[weak self] (auth, user) in
            if user != nil {
                self?.user = user
                self?.loadMyProfile(userId: user!.uid)
            }
        })
    }
    
    func checkUserStatus() {
        if self.user != nil {
            print("...user?.uid", user?.uid ?? "")
            self.router.showAccountScreen()
        } else {
            self.router.showLoginScreen()
        }
    }
    
    func goToEventScreen(){
        router.showEventScreen()
    }
    
    func goLoginScreen() {
        router.showLoginScreen()
    }
    
    func goAddMarkerScreen() {
        router.showAddMarkerScreen()
    }
    
    func goToEventTableView() {
        router.showTableViewScreen()
    }
    
    func loadMyProfile (userId: String) {
        print("loadMyProfile>userId>",userId)
        ref = Database.database().reference().child("users").child(userId)
        print("loadMyProfile")
        let _ = ref.observe(.value, with: { (snapshot) in //refHandle
           // DataService.shared.events.removeAll()
            let json = JSON(snapshot.value ?? [])
            print("loadMyProfile>json>",json)
           
            let firstUserName = json["firstUserName"].stringValue
            let nickNameUser = json["nickNameUser"].stringValue
            let secondNameUser = json["secondNameUser"].stringValue
            let userMail = json["userMail"].stringValue
            //let password = json["password"].stringValue
            
            let profile = Profile(userID: userId, userMail: userMail, firstUserName: firstUserName, secondNameUser: secondNameUser, niсkNameUser: nickNameUser)
            DataService.shared.localUser = profile
            UserDefaults.standard.set(nickNameUser, forKey: "nickNameUser")
        })
    }
    
    
    func loadAllEvents() {
        
        ref = Database.database().reference().child("events")
        print("...loadAllEvents>events")
        let _ = ref.observe(.value, with: { (snapshot) in //refHandle
            DataService.shared.events.removeAll()
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                let json = JSON(rest.value ?? [])
                
                let dateEventString = json["dateEventString"].stringValue
                let dateEventTI = json["dateEventTI"].doubleValue
                let discriptionEvent = json["discriptionEvent"].stringValue
                let iconEvent = json["iconEvent"].stringValue
                let lifeTimeEvent = json["lifeTimeEvent"].doubleValue
                let lngEvent = json["lngEvent"].doubleValue
                let latEvent = json["latEvent"].doubleValue
                let nameEvent = json["nameEvent"].stringValue
                let snipetEvent = json["snipetEvent"].stringValue
                let userID = json["userID"].stringValue
                let userNick = json["userNick"].stringValue
        
                let coordinateEvent = CLLocationCoordinate2D(latitude: latEvent, longitude: lngEvent)
                let date = Date().addingTimeInterval(dateEventTI)
                
                var event = Event(userID: userID, userNick: userNick, nameEvent: nameEvent, coordinate: coordinateEvent, date: date)
                event.dateEventString = dateEventString
                event.discriptionEvent = discriptionEvent
                event.iconEvent = iconEvent
                event.lifeTimeEvent = lifeTimeEvent
                event.snipetEvent = snipetEvent
                
                DataService.shared.events.append(event)
            }
            
            self.createMarkers()
        })
    }
    
    func createMarkers() {
        var markers: [GMSMarker] = []
        let events = DataService.shared.events
        
        for event in events {
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: event.latEvent, longitude: event.lngEvent) )
            marker.icon = UIImage(named: event.iconEvent)
            marker.title = "\(event.dateEventString) \(event.nameEvent)"
            marker.snippet = event.snipetEvent
            markers.append(marker)
        }
    
        view.setMarkers(markers: markers)
    }

}
