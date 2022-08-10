//
//  FullScreenPresenter.swift
//  FirstOfficer
//
//  Created by Deniz on 9.08.2022.
//

import Foundation

protocol FullScreenPresentationLogic: AnyObject {
    func presentImage(response: FullScreen.Fetch.Response)
}

final class FullScreenPresenter: FullScreenPresentationLogic {
    weak var viewController: FullScreenDisplayLogic?
    
    func presentImage(response: FullScreen.Fetch.Response) {
        viewController?.displayData(viewModel: FullScreen.Fetch.ViewModel(image: response.officeImages?.image))
    }
    
}
