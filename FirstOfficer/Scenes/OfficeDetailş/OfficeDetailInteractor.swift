//
//  OfficeDetailInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 7.08.2022.
//

import Foundation

protocol OfficeDetailBusinessLogic: AnyObject {
    func fetchOfficeDetail(request: OfficeDetail.Fetch.Request)
}

protocol OfficeDetailDataStore: AnyObject {
    var officeDetailData: OfficeData? {get set}
}

final class OfficeDetailInteractor: OfficeDetailBusinessLogic, OfficeDetailDataStore {
    
    var officeDetailData: OfficeData? // protokol değişkeni
    
    var presenter: OfficeDetailPresentationLogic?
    var worker: OfficeDetailWorkingLogic = OfficeDetailWorker()
    
    func fetchOfficeDetail(request: OfficeDetail.Fetch.Request) {
        self.presenter?.presentOfficeDetail(response: .init(office: officeDetailData))
    }
    
}
