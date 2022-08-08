//
//  OfficesPresenter.swift
//  FirstOfficer
//
//  Created by Deniz on 5.08.2022.
//

import Foundation

protocol OfficesPresentationLogic: AnyObject {
    func presenterOfficeData ( response: Offices.Fetch.Response)
}

final class OfficesPresenter: OfficesPresentationLogic {

    weak var viewController: OfficesDisplayLogic?
    
    func presenterOfficeData(response: Offices.Fetch.Response) {
        //
        var dataModels: [Offices.Fetch.ViewModel.Office] = []
        response.offices.forEach{ // response modeldeki data
            dataModels.append(Offices.Fetch.ViewModel.Office(address: $0.address, // real data
                                                             capacity: $0.capacity, // real data
                                                             id: $0.id, // real data
                                                             image: $0.image, // real data
                                                             images: $0.images, // real data
                                                             location: $0.location, // real data
                                                             name: $0.name, // real data
                                                             rooms: String($0.rooms ?? 0), // real data
                                                             space: $0.space)) // real data
        }
        
        viewController?.showOffices(viewModel: Offices.Fetch.ViewModel(offices: dataModels))
        
    }
}



