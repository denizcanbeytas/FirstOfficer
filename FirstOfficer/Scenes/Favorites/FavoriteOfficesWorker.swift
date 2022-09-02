//
//  FavoriteOfficesWorker.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import Foundation

protocol FavoriteOfficesWorkingLogic: AnyObject {
    func fetchFavoriteOffice(complation: @escaping ((Result<[Model], Error>) -> Void))
    func deleteFavorites(favoritesId: Int)
}

final class FavoriteOfficesWorker: FavoriteOfficesWorkingLogic {
    func fetchFavoriteOffice(complation: @escaping ((Result<[Model], Error>) -> Void)){
        CoreDataManager.shared.getFavoritesFromPersistance { result in
            switch result {
            case .success(let response):
                complation(.success(response))
            case .failure(let error):
                complation(.failure(error))
            }
        }
    }
    
    func deleteFavorites(favoritesId: Int) {
        CoreDataManager.shared.deleteFavoritesFromCoreData(with: favoritesId) { error in
            print("Error: \(error)")
        }
    }
}
