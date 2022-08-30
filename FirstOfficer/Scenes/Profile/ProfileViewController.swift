//
//  ProfileViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 30.08.2022.
//

import UIKit
import Firebase

protocol ProfileDisplayLogic: AnyObject {
    
}

final class ProfileViewController: UIViewController {
    
    var interactor: ProfileBusinessLogic?
    var router: (ProfileRoutingLogic & ProfileDataPassing)?
    var viewController: ProfileViewController?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "Main") as! WelcomeViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: true, completion: nil)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC: WelcomeViewController = storyboard.instantiateViewController(identifier: "Main")
//        navigationController?.pushViewController(destinationVC, animated: true)
        
//        guard let myViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "Main") as? WelcomeViewController else {
//            fatalError("Unable to Instantiate My View Controller")
//        }
//        self.viewController?.navigationController?.pushViewController(myViewController, animated: true)
        
        print("Tıklandı")
    }
}

extension ProfileViewController: ProfileDisplayLogic {
    
}
