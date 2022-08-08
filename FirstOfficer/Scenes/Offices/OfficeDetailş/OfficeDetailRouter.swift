//
//  OfficeDetailRouter.swift
//  FirstOfficer
//
//  Created by Deniz on 7.08.2022.
//

import Foundation

protocol OfficeDetailRoutingLogic: AnyObject {
    
}

protocol OfficeDetailDataPassing: class {
    var dataStore: OfficeDetailDataStore? { get }
}

final class OfficeDetailRouter: OfficeDetailRoutingLogic, OfficeDetailDataPassing {
    
    weak var viewController: OfficeDetailViewController?
    var dataStore: OfficeDetailDataStore?
    
}
