//
//  MapViewRouter.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import Foundation

protocol MapViewRoutingLogic: AnyObject {
   // func routeToDetails(indexID: Int)
}

protocol MapViewDataPassing: class {
    var dataStore: MapViewDataStore? { get }
}

final class MapViewRouter: MapViewRoutingLogic, MapViewDataPassing {
    
    weak var viewController: MapViewViewController?
    var dataStore: MapViewDataStore?
    
   // func routeToDetails(indexID: Int){}
    
}
