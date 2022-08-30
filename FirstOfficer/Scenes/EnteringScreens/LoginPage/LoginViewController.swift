//
//  ViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 5.07.2022.
//

import UIKit
import Firebase

protocol LoginDisplayLogic: AnyObject {
    
}

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    
    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?
    
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
        // Do any additional setup after loading the view.
        
        let mainUrl = Bundle.main.infoDictionary?["BACKEND_URL"] as? String
        print(mainUrl)
        
        let showVersion = (Bundle.main.infoDictionary?["SHOW_VERSION"] as? String) == "YES"
        if showVersion {
            // TODO: show version label
        } else {
            // hide
        }

        setupNavigationBar()
        hideKeyboardWhenTappedAround()
    }
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Offices", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(identifier: "OfficesVC")
//        self.navigationController?.pushViewController(destinationVC, animated: true)
        
        if emailTF.text != "" && passwordTF.text != "" {
            let auth = Auth.auth()
            auth.signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (authdata, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(OKAction)
                    self.present(alert, animated: true)

                } else {
                    self.navigationController?.pushViewController(PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal), animated: true)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message:"username/password ?", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(OKAction)
            self.present(alert, animated: true)
        }        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        btnView.layer.borderColor = UIColor(named: "LoginBtnBorderColor")?.cgColor
    }
}

extension LoginViewController {
    func setupNavigationBar(){
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.label
    }
}

extension LoginViewController: LoginDisplayLogic {
}
