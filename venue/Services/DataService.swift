//
//  DataService.swift
//  venue
//
//  Created by Ахмед Фокичев on 19.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import Foundation
import CoreLocation

class DataService {
    static let shared = DataService()
    
    var coordinateEvent = CLLocationCoordinate2D()
    var placeEvent = String()
    var dateEvent = Date()
    var dataEventString = String()
    var categoryEvent = String()
    var events = [Event]()
    var localUser: Profile!
    var publicUsers = [String]()
}
