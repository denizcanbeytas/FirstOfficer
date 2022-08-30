//
//  ProfileInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 30.08.2022.
//

import Foundation

protocol ProfileBusinessLogic: AnyObject {
    func getFavorites()
}

protocol ProfileDataStore: AnyObject {
    
}

final class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorkingLogic = ProfileWorker()
    
    func getFavorites(){
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
