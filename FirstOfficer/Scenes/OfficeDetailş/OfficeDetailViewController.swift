//
//  OfficeDetailViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 7.08.2022.
//

import UIKit

protocol OfficeDetailDisplayLogic: AnyObject {
    func displayData(viewModel:OfficeDetail.Fetch.ViewModel)
}

final class OfficeDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: OfficeDetailBusinessLogic?
    var router: (OfficeDetailRoutingLogic & OfficeDetailDataPassing)?
    var viewModel: OfficeDetail.Fetch.ViewModel?
    
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
        collectionView.register(UINib(nibName: "OfficeDetailCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "OfficeDetailCollectionViewCell")
        interactor?.fetchOfficeDetail(request: OfficeDetail.Fetch.Request())
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OfficeDetailInteractor()
        let presenter = OfficeDetailPresenter()
        let router = OfficeDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension OfficeDetailViewController: OfficeDetailDisplayLogic {
    func displayData(viewModel:OfficeDetail.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
           self.collectionView.reloadData()
        }
        
    }
    
    
}

extension OfficeDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.images?.count ?? 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfficeDetailCollectionViewCell", for: indexPath) as? OfficeDetailCollectionViewCell
        guard let model = self.viewModel else {return UICollectionViewCell()}
        cell?.config(viewModel: model)
        return cell ?? UICollectionViewCell()
    }
    
    
}
