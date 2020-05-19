//
//  Models.swift
//  venue
//
//  Created by Dmitriy Butin on 10.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//
//import Foundation
import GoogleMaps
import Firebase

struct Event {
    let userID: String
    let nameEvent: String
    let ref: DatabaseReference?
    let latEvent: Double
    let lngEvent: Double
    let dateEventTI: Double
    var dateEventString: String = ""
    var snipetEvent: String = ""
    var discriptionEvent: String = ""
    var iconEvent: String = "marker-icon"
    var lifeTimeEvent: Double = 1
    var folowEventUsers: [String] = []
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        userID = snapshotValue["userID"] as! String
        nameEvent = snapshotValue["nameEvent"] as! String
        latEvent = snapshotValue["latEvent"] as! Double
        lngEvent = snapshotValue["lngEvent"] as! Double
        dateEventString = snapshotValue["dateEventString"] as! String
        dateEventTI = snapshotValue["dateEventTI"] as! Double
        snipetEvent = snapshotValue["snipetEvent"] as! String
        discriptionEvent = snapshotValue["discriptionEvent"] as! String
        iconEvent = snapshotValue["iconEvent"] as! String
        lifeTimeEvent = snapshotValue["lifeTimeEvent"] as! Double
        ref = snapshot.ref
    }
    
    init(userID: String, nameEvent: String, coordinate: CLLocationCoordinate2D, date: Date ) {
        self.userID = userID
        self.nameEvent = nameEvent
        self.latEvent = coordinate.latitude
        self.lngEvent = coordinate.longitude
        self.dateEventTI = date.timeIntervalSince1970
        ref = nil
    }
    
}

struct User {
    let userID: String
    let userMail: String
    let password: String
    
    let firstUserName: String
    let secondNameUser: String
    let niсkNameUser: String
}

//struct PublicUser {
//    let userID: String
//    let userMail: String
//    let niсkNameUser: String
//    let ref: DatabaseReference?
    
//    init(snapshot: DataSnapshot) {
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        userID = snapshotValue["userID"] as! String
//        userMail = snapshotValue["userMail"] as! String
//        niсkNameUser = snapshotValue["niсkNameUser"] as! String
//        ref = snapshot.ref
//    }
//}

class EventData {
    static let shared = EventData()
    var coordinateEvent = CLLocationCoordinate2D()
    var placeEvent = String()
    var dateEvent = Date()
    var dataEventString = String()
    var events = [Event]()
    
    var localUser: User!
    var publicUsers = [String]()
}