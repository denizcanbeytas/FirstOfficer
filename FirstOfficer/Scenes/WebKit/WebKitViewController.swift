//
//  WebKitViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import UIKit

protocol WebKitDisplayLogic: AnyObject {
    
}

final class WebKitViewController: UIViewController {
    
    var interactor: WebKitBusinessLogic?
    var router: (WebKitRoutingLogic & WebKitDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = WebKitInteractor()
        let presenter = WebKitPresenter()
        let router = WebKitRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension WebKitViewController: WebKitDisplayLogic {
    
}
