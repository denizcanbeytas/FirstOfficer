//
//  FavoriteOfficesViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import UIKit

protocol FavoriteOfficesDisplayLogic: AnyObject {
    
}

final class FavoriteOfficesViewController: UIViewController {
    

    
    var interactor: FavoriteOfficesBusinessLogic?
    var router: (FavoriteOfficesRoutingLogic & FavoriteOfficesDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FavoriteOfficesInteractor()
        let presenter = FavoriteOfficesPresenter()
        let router = FavoriteOfficesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension FavoriteOfficesViewController: FavoriteOfficesDisplayLogic {
    
}
