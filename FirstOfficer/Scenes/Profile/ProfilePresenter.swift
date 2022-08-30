//
//  ProfilePresenter.swift
//  FirstOfficer
//
//  Created by Deniz on 30.08.2022.
//

import Foundation

protocol ProfilePresentationLogic: AnyObject {
    func sendFavoritesToVC(favorites: [Model])
}

final class ProfilePresenter: ProfilePresentationLogic {
    
    weak var viewController: ProfileDisplayLogic?
    
    func sendFavoritesToVC(favorites: [Model]){
        viewController?.getFavorites(favorites: favorites)
    }
    
}
