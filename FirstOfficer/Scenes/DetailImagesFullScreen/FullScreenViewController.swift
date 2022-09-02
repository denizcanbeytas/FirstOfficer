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
    
    var isTapped = true
    
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
        setNavigationBarRightItem(image: "setGridImage")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
   }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
 
    //for image indexPath
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

    @objc func changeGrid() {
        if isTapped {
            setNavigationBarRightItem(image: "setGridImageSecond")
            collectionView.setCollectionViewLayout(createLayout(), animated: true)
            isTapped = false
            print(isTapped)
        }else {
            setNavigationBarRightItem(image: "setGridImage")
            //collectionView.collectionViewLayout = setCollectionView()
            collectionView.setCollectionViewLayout(setCollectionView(), animated: true)
            isTapped = true
            print(isTapped)
        }
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
        
        cell?.configCell(images: model.images?[indexPath.row] ?? "")
        
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

extension FullScreenViewController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.5), height: .fractionalHeight(1), spacing: 1)
        
        let fullItem = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 1)
        let verticalGroup = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(0.5), height: .fractionalHeight(1), item: fullItem, count: 2)
        
        let horizontalGroup = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.6), items: [item, verticalGroup])
        
        let mainItem = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(0.4), spacing: 1)
        let mainGroup = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight(0.5), items: [mainItem, horizontalGroup])
        
        let section = NSCollectionLayoutSection(group: mainGroup)
        
        // return
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func setCollectionView() -> UICollectionViewFlowLayout {
        let horizontalList = UICollectionViewFlowLayout()
        horizontalList.scrollDirection = .horizontal
        horizontalList.itemSize = CGSize(width: (view.frame.size.width - 40), height: (collectionView.frame.size.width + 100))
        return horizontalList
    }
    
    private func setNavigationBarRightItem(image: String) {
        let changeButton = UIBarButtonItem.init(image: UIImage(named: image), style: .done, target: self, action: #selector(changeGrid))
        navigationItem.rightBarButtonItems = [changeButton]
        
    }
}
