//
//  FavoriteOfficesViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import UIKit
import Lottie

protocol FavoriteOfficesDisplayLogic: AnyObject {
    func getFavorites(favorites: [Model])
}

final class FavoriteOfficesViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoritesTabItem: UITabBarItem!

    @IBOutlet weak var emptyLottieView: AnimationView!
    
    var interactor: FavoriteOfficesBusinessLogic?
    var router: (FavoriteOfficesRoutingLogic & FavoriteOfficesDataPassing)?
   
    var favouriteOfficesArray: [Model] = []
    
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
        tableView.register(UINib(nibName: "OfficesTableViewCell", bundle: .main), forCellReuseIdentifier: "OfficesTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        interactor?.getFavoriteOffice()
        playLottiAnimation()
        fetchData()
        // navigationBar make hidden when screen appear
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoritesTabItem.badgeValue = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // navigationBar make visible when screen Disappear
        navigationController?.setNavigationBarHidden(false, animated: animated)
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

// MARK: Extensions

extension FavoriteOfficesViewController: FavoriteOfficesDisplayLogic {
    func getFavorites(favorites: [Model]) {
        favouriteOfficesArray.removeAll()
        favouriteOfficesArray = favorites
        fetchData()
    }
}

extension FavoriteOfficesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteOfficesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OfficesTableViewCell", for: indexPath) as? OfficesTableViewCell else {return UITableViewCell()}
        
            cell.officeId = Int(favouriteOfficesArray[indexPath.row].id ?? "")
            cell.configCellForFavorites(favouriteOfficesArray[indexPath.row])
            cell.favoriteImage.image = UIImage(named: "FavoriteClicked")
            cell.delegateRemove = self
            cell.heartBtnIsTapped = false
        return cell
    }
}

extension FavoriteOfficesViewController: removeAtFavoritesProtocol {
    func removeAtFavorites(favoriteId: Int) {
        interactor?.deleteFavorites(favoritesId: favoriteId)
        interactor?.getFavoriteOffice()
        playLottiAnimation()
    }
    func fetchData() {
        tableView.reloadData()
    }
}

extension FavoriteOfficesViewController {
    
    // MARK: Extension of LottieAnimation
    func playLottiAnimation() {
        if favouriteOfficesArray.isEmpty == false {
            self.emptyLottieView.stop()
            self.emptyLottieView.backgroundColor = UIColor.clear
            //self.emptyLottieView.isHidden = true
        } else {
            //self.tableView.reloadData()
            self.createLottieAnimation()
            self.emptyLottieView.backgroundColor = UIColor.systemBackground
        }
    }
    
    func createLottieAnimation(){
        let animation = Animation.named("emptyLottie")
        emptyLottieView.animation = animation
        emptyLottieView.loopMode = .playOnce
        //emptyLottieView.animationSpeed = 0.5
        
        if (!emptyLottieView.isAnimationPlaying){
            emptyLottieView.play()
        }
    }
}
