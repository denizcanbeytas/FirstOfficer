//
//  OfficesInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 5.08.2022.
//

import Foundation

protocol OfficesBusinessLogic: AnyObject {
    func fetchOffices(request: Offices.Fetch.Request)
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
}

// 3.adım -> çıkacağı bir yer yok completion yok
//            respnse ile gelen veriyi result a alıyor, resulttan gelen veriyi officedata ya atıyor
            
