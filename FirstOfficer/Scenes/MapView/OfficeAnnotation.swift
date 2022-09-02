//
//  OfficeAnnotation.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import Foundation
import MapKit

class OfficeAnnotation : NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D ,title: String)
    {
        self.coordinate = coordinate
        self.title = title
    }
}
