//
//  OfficeDetailViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 7.08.2022.
//

import UIKit
import SDWebImage
import AVKit

protocol OfficeDetailDisplayLogic: AnyObject {
    func displayData(viewModel:OfficeDetail.Fetch.ViewModel)
}

final class OfficeDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
   // @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailRoomsLabel: UILabel!
    @IBOutlet weak var detailSpaceLabel: UILabel!
    @IBOutlet weak var detailCapacityLabel: UILabel!
    @IBOutlet weak var detailAddressLabel: UILabel!
    @IBOutlet weak var roomsView: UIView!
    @IBOutlet weak var spaceView: UIView!
    @IBOutlet weak var capacityView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var detailOfficeName: UILabel!
    
    @IBOutlet weak var videoView: UIView!
    
    var interactor: OfficeDetailBusinessLogic?
    var router: (OfficeDetailRoutingLogic & OfficeDetailDataPassing)?
    var viewModel: OfficeDetail.Fetch.ViewModel?
    
    var player: AVPlayer!
    var avpController = AVPlayerViewController()
    
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
        setupNavigationBar()
        configureVideoPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       navigationController?.setNavigationBarHidden(false, animated: animated)
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
    @IBAction func webKitButtonClicked(_ sender: Any) {
        router?.routeToWebPage()
    }
    @IBAction func previousPageClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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

// MARK: Extensions

extension OfficeDetailViewController{
    func setupUI() {
      //  detailImageView.sd_setImage(with: URL(string: viewModel?.image ?? ""))
        detailRoomsLabel.text = viewModel?.rooms
        detailSpaceLabel.text = viewModel?.space
        detailCapacityLabel.text = viewModel?.capacity
        detailAddressLabel.text = viewModel?.address
        detailOfficeName.text = viewModel?.name
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.label
    }
    
    func configureVideoPlayer(){
        guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else {
            debugPrint("video  not found")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        avpController.player = player
        avpController.view.frame.size.height = videoView.frame.size.height
        avpController.view.frame.size.width = videoView.frame.size.width
        self.videoView.addSubview(avpController.view)
    
    }
}
