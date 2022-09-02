//
//  FavoriteOfficesRouter.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import Foundation

protocol FavoriteOfficesRoutingLogic: AnyObject {
    
}

protocol FavoriteOfficesDataPassing: class {
    var dataStore: FavoriteOfficesDataStore? { get }
}

final class FavoriteOfficesRouter: FavoriteOfficesRoutingLogic, FavoriteOfficesDataPassing {
    
    weak var viewController: FavoriteOfficesViewController?
    var dataStore: FavoriteOfficesDataStore?
    
}
