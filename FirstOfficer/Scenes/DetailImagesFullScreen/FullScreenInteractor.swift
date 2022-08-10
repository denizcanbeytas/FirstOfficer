//
//  FullScreenInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 9.08.2022.
//

import Foundation

protocol FullScreenBusinessLogic: AnyObject {
    func fetchImage(request: FullScreen.Fetch.Request)
}

protocol FullScreenDataStore: AnyObject {
    var ImageData: OfficeData? {get set}
    var selectedIndex: Int? {get set}
}

final class FullScreenInteractor: FullScreenBusinessLogic, FullScreenDataStore {
    var selectedIndex: Int?
    
    
    var ImageData: OfficeData?
    var presenter: FullScreenPresentationLogic?
    var worker: FullScreenWorkingLogic = FullScreenWorker()
    
    func fetchImage(request: FullScreen.Fetch.Request) {
        self.presenter?.presentImage(response: .init(officeImages: ImageData, selectedIndex: selectedIndex))
    }
    
    
    
}
