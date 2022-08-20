//
//  OfficesInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 5.08.2022.
//

import Foundation

protocol OfficesBusinessLogic: AnyObject {
    func fetchOffices(request: Offices.Fetch.Request)
    func fetchFilteringData(request: String)
    func saveFavoritesToCoreData(officeResult: Offices.Fetch.ViewModel.Office)
    func deleteFavoritesFromCoreData(favoriId: Int)
    //func getFavoritesID(favoritesID: Int)
}

protocol OfficesDataStore: AnyObject {
    var officeData: OfficeArray? {get} // presenter dan gelen data ların tutulduğu yer - datannın son hali
}

final class OfficesInteractor: OfficesBusinessLogic, OfficesDataStore {

    var officeData: OfficeArray?
    var presenter: OfficesPresentationLogic?
    var worker: OfficesWorkingLogic = OfficesWorker()
    
    
    
    func fetchOffices(request: Offices.Fetch.Request) {
        worker.getOffices { result in
            switch result {
            case.success(let response):
                self.officeData = response
                guard let officeData = self.officeData else {
                    return
                }
                self.presenter?.presenterOfficeData(response: Offices.Fetch.Response(offices: officeData))
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func fetchFilteringData(request: String){
        let filteringData = officeData?.filter { filter in
            return filter.space == request || filter.capacity == request || String(filter.rooms ?? 0) == request
        }
        guard let filteringData = filteringData else {
            return
        }
        self.presenter?.presenterOfficeData(response: Offices.Fetch.Response(offices: filteringData))
        print("\(filteringData)")
    }
    
    func saveFavoritesToCoreData(officeResult: Offices.Fetch.ViewModel.Office) {
        worker.saveToCoreData(officeResult: officeResult)
    }
    
    func deleteFavoritesFromCoreData(favoriId: Int){
        worker.deleteFavoritesFromCoreData(favoriId: favoriId)
    }
    
//    func getFavoritesID(favoritesID: Int){
//        CoreDataManager.shared.checkIsFavourite(with: favoritesID) { result in
//            switch result {
//            case .success(let bool):
//             
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}

// 3.adım -> çıkacağı bir yer yok completion yok
//            respnse ile gelen veriyi result a alıyor, resulttan gelen veriyi officedata ya atıyor
            
