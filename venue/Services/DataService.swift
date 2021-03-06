//
//  DataService.swift
//  venue
//
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import GoogleMaps
//import CoreLocation

class DataService {
    static var shared = DataService()
    
    var coordinateEvent = CLLocationCoordinate2D()
    var placeEvent = String()
    var dateEvent = Date()
    var dataEventString = String()
    var categoryEvent = String()
    var events = [Event]()
    var oldEventsID: [String]? = []
    var event: Event!
    var eventID = String()
    var localUser: Profile!
    var fallowUsers: [String] = []
    var markerDidTapped = false
    var marker: GMSMarker!
}
