//
//  WebKitRouter.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import Foundation

protocol WebKitRoutingLogic: AnyObject {
    
}

protocol WebKitDataPassing: class {
    var dataStore: WebKitDataStore? { get }
}

final class WebKitRouter: WebKitRoutingLogic, WebKitDataPassing {
    
    weak var viewController: WebKitViewController?
    var dataStore: WebKitDataStore?
    
}
