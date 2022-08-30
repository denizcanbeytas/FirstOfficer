//
//  RegisterViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 27.07.2022.
//

import UIKit

protocol RegisterDisplayLogic: AnyObject {
    
}

class RegisterViewController: UIViewController {
    

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    var interactor: RegisterBusinessLogic?
    var router: (RegisterRoutingLogic & RegisterDataPassing)?
    
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
        setupNavigationBar()
        hideKeyboardWhenTappedAround() 
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        btnView.layer.borderColor = UIColor(named: "LoginBtnBorderColor")?.cgColor
    }
    
    private func setup() {
        let viewController = self
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        if let email = emailTF.text, let password = passwordTF.text{
            interactor?.getRegister(email: email, password: password)
        }
        
        let alert = UIAlertController(title: "Register", message: "Register is successful.", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default)
        {
            action in
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        
        alert.addAction(okayAction)
        self.present(alert, animated: true)
    }
}

extension RegisterViewController {
    func setupNavigationBar(){
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.label
    }
}

extension RegisterViewController: RegisterDisplayLogic {
}
