//
//  OfficeDetailViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 7.08.2022.
//

import UIKit
import SDWebImage

protocol OfficeDetailDisplayLogic: AnyObject {
    func displayData(viewModel:OfficeDetail.Fetch.ViewModel)
}

final class OfficeDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailRoomsLabel: UILabel!
    @IBOutlet weak var detailSpaceLabel: UILabel!
    @IBOutlet weak var detailCapacityLabel: UILabel!
    @IBOutlet weak var detailAddressLabel: UILabel!
    @IBOutlet weak var roomsView: UIView!
    @IBOutlet weak var spaceView: UIView!
    @IBOutlet weak var capacityView: UIView!
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var detailOfficeName: UILabel!
    
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
        setupUI()
    }
    
    func setupUI() {
        detailImageView.sd_setImage(with: URL(string: viewModel?.image ?? ""))
        detailRoomsLabel.text = viewModel?.rooms
        detailSpaceLabel.text = viewModel?.space
        detailCapacityLabel.text = viewModel?.capacity
        detailAddressLabel.text = viewModel?.address
        detailOfficeName.text = viewModel?.name
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
        cell?.config(images: model.images?[indexPath.row] ?? "") // -> cell de görünmesi için images'ın tıklanılan index'teki elemanını gönderdik
        //cell?.config(image: model.images![indexPath.row] )
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToFullScreen(index: indexPath.row)
    }
    
    
    
}

extension OfficeDetailViewController{

}
