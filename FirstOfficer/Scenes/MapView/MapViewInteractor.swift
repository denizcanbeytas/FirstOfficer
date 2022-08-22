//
//  MapViewInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import Foundation

protocol MapViewBusinessLogic: AnyObject {
    
}

protocol MapViewDataStore: AnyObject {
    
}

final class MapViewInteractor: MapViewBusinessLogic, MapViewDataStore {
    
    var presenter: MapViewPresentationLogic?
    var worker: MapViewWorkingLogic = MapViewWorker()
    
}
