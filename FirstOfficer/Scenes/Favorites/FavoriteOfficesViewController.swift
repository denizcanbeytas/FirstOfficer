//
//  FavoriteOfficesViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 21.08.2022.
//

import UIKit

protocol FavoriteOfficesDisplayLogic: AnyObject {
    func getFavoritesIDFromCoreData(favouritesID: [String])
}

final class FavoriteOfficesViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    var interactor: FavoriteOfficesBusinessLogic?
    var router: (FavoriteOfficesRoutingLogic & FavoriteOfficesDataPassing)?
    
    var favouriteOfficesArray: [Model] = [] 
    var coreDataFavouriteOfficeId : [String] = []
    
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
        interactor?.getFavoritesID()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        fetchFavoritesOfficesFromPersistance()
        fetchData()
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
    
    func fetchFavoritesOfficesFromPersistance() {
        CoreDataManager.shared.getFavoritesFromPersistance { result in
            switch result {
            case .success(let favourites):
                self.favouriteOfficesArray = favourites
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension FavoriteOfficesViewController: FavoriteOfficesDisplayLogic {
    func getFavoritesIDFromCoreData(favouritesID: [String]) {
        coreDataFavouriteOfficeId.removeAll()
        coreDataFavouriteOfficeId = favouritesID
        //fetchData()
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
            //self.favouriteOfficesArray.remove(at: indexPath.row)
        return cell
    }
    
}

extension FavoriteOfficesViewController: removeAtFavoritesProtocol {
    func removeAtFavorites(favoriteId: Int) {
        CoreDataManager.shared.deleteFavoritesFromCoreData(with: favoriteId) { error in
            print("Error: \(error)")
        }
    }
    func fetchData() {
        tableView.reloadData()
    }
}
