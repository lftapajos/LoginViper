//
//  UserAnnotiation.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 11/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class UserAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    
}
