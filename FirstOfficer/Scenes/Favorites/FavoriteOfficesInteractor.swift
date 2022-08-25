//
//  FavoriteOfficesInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import Foundation

protocol FavoriteOfficesBusinessLogic: AnyObject {
    func getFavoriteOffice()
}

protocol FavoriteOfficesDataStore: AnyObject {
    
}

final class FavoriteOfficesInteractor: FavoriteOfficesBusinessLogic, FavoriteOfficesDataStore {
    
    var presenter: FavoriteOfficesPresentationLogic?
    var worker: FavoriteOfficesWorkingLogic = FavoriteOfficesWorker()
    
    func getFavoriteOffice(){
        worker.fetchFavoriteOffice { response in
            switch response {
            case .success(let favorites):
                self.presenter?.sendFavoritesToVC(favorites: favorites)
            case .failure(let error):
                print(error)
            }
        }
    }

}
