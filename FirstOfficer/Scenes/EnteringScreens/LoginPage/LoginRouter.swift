//
//  LoginRouter.swift
//  FirstOfficer
//
//  Created by Deniz on 30.08.2022.
//

import Foundation

protocol LoginRoutingLogic: AnyObject {
    
}

protocol LoginDataPassing: class {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic, LoginDataPassing {
    
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
}
