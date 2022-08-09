//
//  FullScreenRouter.swift
//  FirstOfficer
//
//  Created by Deniz on 9.08.2022.
//

import Foundation

protocol FullScreenRoutingLogic: AnyObject {
    
}

protocol FullScreenDataPassing: class {
    var dataStore: FullScreenDataStore? { get }
}

final class FullScreenRouter: FullScreenRoutingLogic, FullScreenDataPassing {
    
    weak var viewController: FullScreenViewController?
    var dataStore: FullScreenDataStore?
    
}
