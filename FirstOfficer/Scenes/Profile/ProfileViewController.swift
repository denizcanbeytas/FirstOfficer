//
//  ProfileViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 30.08.2022.
//

import UIKit
import Firebase
import SDWebImage

protocol ProfileDisplayLogic: AnyObject {
    func getFavorites(favorites: [Model])
}

final class ProfileViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: ProfileBusinessLogic?
    var router: (ProfileRoutingLogic & ProfileDataPassing)?
    var viewController: ProfileViewController?
    
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
        interactor?.getFavorites()
        showCurrentUser()
        collectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: animated)
        collectionView.reloadData()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    @IBAction func logoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch { print("error") }
    
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "Main") as! WelcomeViewController
        let navigationController = UINavigationController(rootViewController: destinationVC)
        navigationController.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: true, completion: nil)
    }
}

extension ProfileViewController: ProfileDisplayLogic {
    func getFavorites(favorites: [Model]) {
        favouriteOfficesArray.removeAll()
        favouriteOfficesArray = favorites
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteOfficesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell else {return UICollectionViewCell()}
        cell.imageView.sd_setImage(with: URL(string: favouriteOfficesArray[indexPath.row].image ?? ""))
        return cell
    }


}


extension ProfileViewController {
    func showCurrentUser(){
        let auth = Auth.auth()
        let email = (auth.currentUser?.email)!
        emailTF.text = email
    }
}


