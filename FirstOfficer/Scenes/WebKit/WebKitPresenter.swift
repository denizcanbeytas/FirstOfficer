//
//  WebKitPresenter.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import Foundation

protocol WebKitPresentationLogic: AnyObject {
    
}

final class WebKitPresenter: WebKitPresentationLogic {
    
    weak var viewController: WebKitDisplayLogic?
    
}
