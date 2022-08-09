//
//  FullScreenViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 9.08.2022.
//

import UIKit
import SDWebImage

protocol FullScreenDisplayLogic: AnyObject {
    func displayData(viewModel: FullScreen.Fetch.ViewModel)
}

final class FullScreenViewController: UIViewController {
    
    var interactor: FullScreenBusinessLogic?
    var router: (FullScreenRoutingLogic & FullScreenDataPassing)?
    var viewModel: FullScreen.Fetch.ViewModel?
    @IBOutlet weak var imageView: UIImageView!
    
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
        interactor?.fetchImage(request: FullScreen.Fetch.Request())
        //imageView.sd_setImage(with: URL(string: viewModel?.images))
        
    }
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FullScreenInteractor()
        let presenter = FullScreenPresenter()
        let router = FullScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension FullScreenViewController: FullScreenDisplayLogic {
    func displayData(viewModel: FullScreen.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            //
        }
    }
    
    
}
