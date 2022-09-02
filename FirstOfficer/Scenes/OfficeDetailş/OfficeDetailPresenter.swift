//
//  OfficeDetailPresenter.swift
//  FirstOfficer
//
//  Created by Deniz on 7.08.2022.
//

import Foundation

protocol OfficeDetailPresentationLogic: AnyObject {
    func presentOfficeDetail(response: OfficeDetail.Fetch.Response)
}

final class OfficeDetailPresenter: OfficeDetailPresentationLogic {
    
    weak var viewController: OfficeDetailDisplayLogic?
    
    func presentOfficeDetail(response: OfficeDetail.Fetch.Response) {
        viewController?.displayData(viewModel: OfficeDetail.Fetch.ViewModel(address: response.office?.address,
                                                                            capacity: response.office?.capacity,
                                                                            id: response.office?.id,
                                                                            image: response.office?.image,
                                                                            images: response.office?.images,
                                                                            location: response.office?.location,
                                                                            name: response.office?.name,
                                                                            rooms: String(response.office?.rooms ?? 1),
                                                                            space: response.office?.space))
    }
    

    
}
