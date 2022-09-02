//
//  MapViewInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import Foundation

protocol MapViewBusinessLogic: AnyObject {
    func getOfficeForMap(request: MapView.Fetch.Request)
}

protocol MapViewDataStore: AnyObject {
    var officeArrayForPresenter: OfficeArray? {get set}
}

final class MapViewInteractor: MapViewBusinessLogic, MapViewDataStore {
    var officeArrayForPresenter: OfficeArray?
    

    var presenter: MapViewPresentationLogic?
    var worker: MapViewWorkingLogic = MapViewWorker()
    
    func getOfficeForMap(request: MapView.Fetch.Request) {
        worker.fetchOfficeForMap { [weak self] result in
            switch result {
            case .success(let response):
                self?.officeArrayForPresenter = response
                guard let officeArrayForPresenter = self?.officeArrayForPresenter else {return}
                self?.presenter?.sendOfficeForMapToVC(response: .init(OfficesForMap: officeArrayForPresenter))
            case .failure(let error):
                print(error.localizedDescription)
            }
        
        }
    }
    
    
    
}
