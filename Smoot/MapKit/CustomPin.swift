//
//  CustomPin.swift
//  Smoot
//
//  Created by Julian Kronlachner on 30.05.18.
//  Copyright © 2018 73. All rights reserved.
//

import UIKit
import MapKit

class customPin: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle: String, pinSubtitle: String, location: CLLocationCoordinate2D) {
        self.coordinate = location
        self.title = pinTitle
        self.subtitle = pinSubtitle
    }
    
}
