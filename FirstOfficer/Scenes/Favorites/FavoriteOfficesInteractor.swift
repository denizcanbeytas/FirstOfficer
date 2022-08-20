//
//  FavoriteOfficesInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import Foundation

protocol FavoriteOfficesBusinessLogic: AnyObject {
    
}

protocol FavoriteOfficesDataStore: AnyObject {
    
}

final class FavoriteOfficesInteractor: FavoriteOfficesBusinessLogic, FavoriteOfficesDataStore {
    
    var presenter: FavoriteOfficesPresentationLogic?
    var worker: FavoriteOfficesWorkingLogic = FavoriteOfficesWorker()
    
}
