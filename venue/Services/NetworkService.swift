//
//  NetworkService.swift
//  venue
//
//  Created by Dmitriy Butin on 24.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import Firebase
import GoogleMaps
//import CoreLocation

class NetworkService {
    static let shared = NetworkService()
    
    
    static func stopObservers(){
        let ref = Database.database().reference()
        ref.removeAllObservers()
        print("Наблюдатель удалён")
    }
    
    static func removeEvent(event: Event) {
        let ref = Database.database().reference()
        let eventRef = ref.child("events").child(event.eventID)
        eventRef.removeValue()
        print("Event removed!")
    }
    
    static func removeOldEvent(eventsID: [String]) {
        print("Запущен процесс удаления старых событий")
        let ref = Database.database().reference()
        for eventID in eventsID {
            let eventRef = ref.child("events").child(eventID)
            eventRef.removeValue()
        }
    }
    
    static func loadAllEvents() {
        let ref = Database.database().reference().child("events")
        print("... loadAllEvents > events")
        var eventsFromNet = [Event]()
        DataService.shared.events.removeAll()
        ref.observe(.value, with: { (snapshot) in
            for item in snapshot.children {
                let event = Event(snapshot: item as! DataSnapshot)
               // print("item = ", item)
                print("EventID = ", event.eventID)
                eventsFromNet.append(event) 
            }
            DataService.shared.events = eventsFromNet
            print("загружено \(eventsFromNet.count) элементов")
            print("Элементы помещены в массив \(DataService.shared.events.count)")
        })
        //        { (error) in
        //            print(error.localizedDescription)
        //        }
    }
    
//    static func loadFollowUserEvents() {
//        let ref = Database.database().reference().child("events")
//        ref.observe(.value, with: { (snapshot) in
//            for item in snapshot.children {
//
//                let snapshotValue = snapshot.value as! [String: AnyObject]
//                let userID = snapshotValue["userID"] as! String
//
//            }
//        })
//    }
        
    static func loadMyProfile (userId: String) {
        print("loadMyProfile>userId>",userId)
        let ref = Database.database().reference().child("users").child(userId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            print("loadMyProfile")
            let firstUserName = value?["firstUserName"] as? String ?? ""
            let nickNameUser = value?["nickNameUser"] as? String ?? ""
            let secondNameUser = value?["secondNameUser"] as? String ?? ""
            let userMail = value?["userMail"] as? String ?? ""
            let profile = Profile(userID: userId, userMail: userMail, firstUserName: firstUserName, secondNameUser: secondNameUser, niсkNameUser: nickNameUser)
            DataService.shared.localUser = profile
            print("Сохранён профиль для ", profile.firstUserName)
            UserDefaults.standard.set(nickNameUser, forKey: "nickNameUser")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func followMe() {
        let eventID = DataService.shared.eventID
        guard let localUser = DataService.shared.localUser else { return }
        print("eventID = ", eventID, "ID = ", localUser.userID, "niсkNameUser = ", localUser.niсkNameUser)
        let ref = Database.database().reference()
        let eventRefKey = ref.child("events").child(eventID).child("followEventUsers")
        let update = ["\(localUser.userID)": localUser.niсkNameUser]
        eventRefKey.updateChildValues(update)
        print("save Follow Event Complete !")
    }
    
    static func removeFollow() {
        let eventID = DataService.shared.eventID
        guard let localUser = DataService.shared.localUser else { return }
        print("eventID = ", eventID, "ID = ", localUser.userID, "niсkNameUser = ", localUser.niсkNameUser)
        let ref = Database.database().reference()
        let eventRefKey = ref.child("events").child(eventID).child("followEventUsers").child(localUser.userID)
        eventRefKey.removeValue()
        print("Follow removed!")
    }
    
    
}



//    static func loadAllEvents() {
//
//        let ref = Database.database().reference().child("events")
//        print("... loadAllEvents > events")
//        var eventsFromNet = [Event]()
//        DataService.shared.events.removeAll()
//        let _ = ref.observe(.value, with: { (snapshot) in //refHandle
//            for rest in snapshot.children.allObjects as! [DataSnapshot] {
//                let json = JSON(rest.value ?? [])
//                let dateEventString = json["dateEventString"].stringValue
//                let dateEventTI = json["dateEventTI"].doubleValue
//                let discriptionEvent = json["discriptionEvent"].stringValue
//                let iconEvent = json["iconEvent"].stringValue
//                let lifeTimeEvent = json["lifeTimeEvent"].doubleValue
//                let lngEvent = json["lngEvent"].doubleValue
//                let latEvent = json["latEvent"].doubleValue
//                let nameEvent = json["nameEvent"].stringValue
//                let snipetEvent = json["snipetEvent"].stringValue
//                let userID = json["userID"].stringValue
//                let eventID = json["eventID"].stringValue
//                let userNick = json["userNick"].stringValue
//
//                let coordinateEvent = CLLocationCoordinate2D(latitude: latEvent, longitude: lngEvent)
//                let date = Date(timeIntervalSince1970: dateEventTI)
//
//                var event = Event(userID: userID, userNick: userNick, nameEvent: nameEvent, coordinate: coordinateEvent, date: date)
//                event.dateEventString = dateEventString
//                event.discriptionEvent = discriptionEvent
//                event.iconEvent = iconEvent
//                event.lifeTimeEvent = lifeTimeEvent
//                event.snipetEvent = snipetEvent
//                event.eventID = eventID
//
//                eventsFromNet.append(event)
//            }
//            print("загружено \(eventsFromNet.count) элементов")
//            DataService.shared.events = eventsFromNet
//            print("Элементы помещены в массив \(DataService.shared.events.count)")
//        })
//    }
//
