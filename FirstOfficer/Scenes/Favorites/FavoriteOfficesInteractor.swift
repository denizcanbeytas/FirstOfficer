//
//  FavoriteOfficesInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import Foundation

protocol FavoriteOfficesBusinessLogic: AnyObject {
    func getFavoritesID()
}

protocol FavoriteOfficesDataStore: AnyObject {
    
}

final class FavoriteOfficesInteractor: FavoriteOfficesBusinessLogic, FavoriteOfficesDataStore {
    
    var presenter: FavoriteOfficesPresentationLogic?
    var worker: FavoriteOfficesWorkingLogic = FavoriteOfficesWorker()
    
    func getFavoritesID(){
        CoreDataManager.shared.getFavouritesId { response in
            switch response {
            case .success(let favouriteID):
                self.presenter?.sendFavoritesIDToVC(favouritesID: favouriteID)
            case .failure(let error):
                print(error)
                // SİL
            }
        
        }
    }
}
