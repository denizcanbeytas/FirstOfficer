//
//  OfficeDetailInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 7.08.2022.
//

import Foundation

protocol OfficeDetailBusinessLogic: AnyObject {
    
}

protocol OfficeDetailDataStore: AnyObject {
    
}

final class OfficeDetailInteractor: OfficeDetailBusinessLogic, OfficeDetailDataStore {
    
    var presenter: OfficeDetailPresentationLogic?
    var worker: OfficeDetailWorkingLogic = OfficeDetailWorker()
    
}
