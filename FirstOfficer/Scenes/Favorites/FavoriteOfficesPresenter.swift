//
//  FavoriteOfficesPresenter.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import Foundation

protocol FavoriteOfficesPresentationLogic: AnyObject {
    func sendFavoritesToVC(favorites: [Model])
}

final class FavoriteOfficesPresenter: FavoriteOfficesPresentationLogic {
    
    weak var viewController: FavoriteOfficesDisplayLogic?
    
    func sendFavoritesToVC(favorites: [Model]){
        viewController?.getFavorites(favorites: favorites)
    }
}
