//
//  FavoriteOfficesPresenter.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import Foundation

protocol FavoriteOfficesPresentationLogic: AnyObject {
    func sendFavoritesIDToVC(favouritesID: [String])
}

final class FavoriteOfficesPresenter: FavoriteOfficesPresentationLogic {
    
    weak var viewController: FavoriteOfficesDisplayLogic?
    
    func sendFavoritesIDToVC(favouritesID: [String]){
        viewController?.getFavoritesIDFromCoreData(favouritesID: favouritesID)
    }
}
