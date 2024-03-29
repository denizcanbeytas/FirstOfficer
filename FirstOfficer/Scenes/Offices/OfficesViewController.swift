//
//  OfficesViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 5.08.2022.
//

import UIKit
import CoreData

protocol OfficesDisplayLogic: AnyObject {
    func showOffices(viewModel: Offices.Fetch.ViewModel)
    func getFavoritesIDFromCoreData(favouritesID: [String])
}

final class OfficesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searcBar: UISearchBar!
    @IBOutlet weak var filterBtnImage: UIImageView!
    
    var interactor: OfficesBusinessLogic?
    var router: (OfficesRoutingLogic & OfficesDataPassing)?
    var viewModel: Offices.Fetch.ViewModel?
    
    
    var items = [itemsForFiltering]()
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 4
    var selectedRow = 0
    
    var favouritesID: Int?
    var coreDataFavouriteOfficeId : [String] = []
    
    var iter = ""
    var idArray = [String]()
    
    // for the searchBar
    var allData = [Offices.Fetch.ViewModel.Office]()
    var filteringData : [Offices.Fetch.ViewModel.Office] = []
    
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
        interactor?.fetchOffices(request: Offices.Fetch.Request())
        tableView.register(UINib(nibName: "OfficesTableViewCell", bundle: .main), forCellReuseIdentifier: "OfficesTableViewCell")
        searcBar.delegate = self
        //interactor?.getFavoritesID()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        interactor?.getFavoritesID()
    }

    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OfficesInteractor()
        let presenter = OfficesPresenter()
        let router = OfficesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: PickerView and ToolBar
    
    @IBAction func pickerButton(_ sender: Any) {
        
        createPickerView()
        // for filter btn selected image
        filterBtnImage.image = UIImage(named: "filterCloseIamge")
        
    }
    private func createPickerView(){

        // creating pickerData
        let capacity: itemsForFiltering = .init(firstItem: "Capacity", secondItem: ["0-5","0-10", "5-10", "10-15","10-25","15-20"])
        let rooms: itemsForFiltering = .init(firstItem: "Rooms", secondItem: ["0", "1", "2", "3","4", "5", "6", "7","8", "9", "10", "11"])
        let space: itemsForFiltering = .init(firstItem: "Space", secondItem: ["25m2", "50m2", "75m2", "100m2","125m2", "150m2"])
        
        items.append(capacity)
        items.append(rooms)
        items.append(space)
        
        // creating pickerView and alerts
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:screenHeight))
        pickerView.delegate = self
        pickerView.dataSource = self
        
        vc.view.addSubview(pickerView)
        
        let alert = UIAlertController(title: "Select Office Detail", message: "", preferredStyle: .actionSheet)
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in

            self.interactor?.fetchOffices(request: Offices.Fetch.Request())
            self.filterBtnImage.image = UIImage(named: "filterImage")
        }))
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { [self] (UIAlertAction) in
            // for filter btn selected image
            self.filterBtnImage.image = UIImage(named: "filterImage")
            interactor?.fetchFilteringData(request: self.iter )
        }))
        self.present(alert, animated: true, completion: nil)
        //
    }
    
}
// MARK: Extensions
extension OfficesViewController: OfficesDisplayLogic {
    func getFavoritesIDFromCoreData(favouritesID: [String]) {
        coreDataFavouriteOfficeId.removeAll()
        coreDataFavouriteOfficeId = favouritesID
        fetch()
    }
    

    func showOffices(viewModel: Offices.Fetch.ViewModel) {
        self.viewModel = viewModel
        // for the searchBar
        self.filteringData = viewModel.offices
        self.allData = viewModel.offices
        //
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension OfficesViewController: addToFavoriteProtocol, removeAtFavoritesProtocol {
    
    func addToFavorite(officeResult: Offices.Fetch.ViewModel.Office) {
        interactor?.saveFavoritesToCoreData(officeResult: officeResult)
    }
    func removeAtFavorites(favoriteId: Int) {
        interactor?.deleteFavoritesFromCoreData(favoriId: favoriteId)
    }
    func fetch(){
        // tableView.reloadData for all func of delegate
        tableView.reloadData()
    }
}

extension OfficesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !filteringData.isEmpty {
            return filteringData.count // for the searchBar
        }else {
            return viewModel?.offices.count ?? 1
        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OfficesTableViewCell", for: indexPath) as? OfficesTableViewCell else {return UITableViewCell()}
        
        guard let model = viewModel?.offices[indexPath.row] else { return UITableViewCell()}
        
        cell.config(viewModel: model)
        
        cell.delegateAdd = self
        cell.delegateRemove = self

        cell.favoriteImage.image = UIImage(named: "FavoriteUnClicked")
        cell.heartBtnIsTapped = true
        for i in coreDataFavouriteOfficeId {
            if i == model.id {
                cell.favoriteImage.image = UIImage(named: "FavoriteClicked")
                cell.heartBtnIsTapped = false
            }
        }
        
        cell.btnActionTap = { [weak self] in
            if cell.heartBtnIsTapped == true {
                if let tabItems = self?.tabBarController?.tabBar.items{
                    let item = tabItems[1]
                    item.badgeValue = "new"
                    item.badgeColor = UIColor.lightGray
                }
            }
        }
        // ask !!!
        if !filteringData.isEmpty { // for the searchBar
            let hey = filteringData[indexPath.row]
            cell.config(viewModel: hey)
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routerToOfficeDetail(index:indexPath.row )
    }
}

extension OfficesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return items.count
        } else {
            let selectedItem = pickerView.selectedRow(inComponent: 0)
            return items[selectedItem].secondItem?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return items[row].firstItem
        } else {
            let selectedItem = pickerView.selectedRow(inComponent: 0)
            return items[selectedItem].secondItem?[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(0)
        pickerView.reloadComponent(1)
        
        let selectedItem = pickerView.selectedRow(inComponent: 0)
        let selectedData = items[selectedItem].secondItem?[row]
        iter = selectedData ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 100
    }
}

extension OfficesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        self.filteringData = self.allData.filter{office in
            if office.name!.lowercased().contains(searchText.lowercased()){
                return true
            }
            if searchText == ""{
                return true
            }
            return false
        }
        self.tableView.reloadData()
    }
}

