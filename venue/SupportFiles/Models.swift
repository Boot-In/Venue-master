//
//  Models.swift
//  venue
//
//  Created by Dmitriy Butin on 10.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import GoogleMaps

struct Event {
    let userID: String
    let userNick: String
    let nameEvent: String
    let latEvent: Double
    let lngEvent: Double
    let dateEventTI: Double
    var eventID: String = ""
    var dateEventString: String = ""
    var snipetEvent: String = ""
    var discriptionEvent: String = ""
    var iconEvent: String = "marker-icon"
    var lifeTimeEvent: Double = 1
    var followEventUsers: [String] = []
    
    init(userID: String, userNick: String, nameEvent: String, coordinate: CLLocationCoordinate2D, date: Date ) {
        self.userID = userID
        self.userNick = userNick
        self.nameEvent = nameEvent
        self.latEvent = coordinate.latitude
        self.lngEvent = coordinate.longitude
        self.dateEventTI = date.timeIntervalSince1970
    }
    //    init(snapshot: DataSnapshot) {
    //        let snapshotValue = snapshot.value as! [String: AnyObject]
    //        userID = snapshotValue["userID"] as! String
    //        nameEvent = snapshotValue["nameEvent"] as! String
    //        latEvent = snapshotValue["latEvent"] as! Double
    //        lngEvent = snapshotValue["lngEvent"] as! Double
    //        dateEventString = snapshotValue["dateEventString"] as! String
    //        dateEventTI = snapshotValue["dateEventTI"] as! Double
    //        snipetEvent = snapshotValue["snipetEvent"] as! String
    //        discriptionEvent = snapshotValue["discriptionEvent"] as! String
    //        iconEvent = snapshotValue["iconEvent"] as! String
    //        lifeTimeEvent = snapshotValue["lifeTimeEvent"] as! Double
    //        ref = snapshot.ref
    //    }
}

struct Profile {
    let userID: String
    let userMail: String
    var password: String = ""
    
    let firstUserName: String
    let secondNameUser: String
    let niсkNameUser: String
}

