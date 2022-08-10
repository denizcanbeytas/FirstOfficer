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

protocol FullScreenDelegate: AnyObject {
    func fullScreenDidScroll(indexPath: IndexPath)
}

final class FullScreenViewController: UIViewController {
    
    var interactor: FullScreenBusinessLogic?
    var router: (FullScreenRoutingLogic & FullScreenDataPassing)?
    var viewModel: FullScreen.Fetch.ViewModel?
    weak var delegateFullScreen: FullScreenDelegate?
    
  //  @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        collectionView.register(UINib(nibName: "FullScreenCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FullScreenCollectionViewCell")
        //imageView.sd_setImage(with: URL(string: viewModel?.image ?? "")) -> image içindi artık kullanılmıyor
        
    }
    
    // MARK: for image indexPath
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.scrollToItem(at: IndexPath(row: viewModel?.selectedIndex ?? 0, section: 0), at: .left, animated: true)
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
            self.collectionView.reloadData()
        }
    }
}

extension FullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullScreenCollectionViewCell", for: indexPath) as? FullScreenCollectionViewCell
        guard let model = self.viewModel else {return UICollectionViewCell()}
       // cell?.configCell(viewModel: model)
        cell?.configCell(images: model.images?[indexPath.row] ?? "")
       // cell?.configureCell(image: model.images?[indexPath.row] ?? "")
        collectionView.layoutIfNeeded()
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
    // MARK: for image indexPath
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            delegateFullScreen?.fullScreenDidScroll(indexPath: visibleIndexPath)
        }
    }
    
    
}
