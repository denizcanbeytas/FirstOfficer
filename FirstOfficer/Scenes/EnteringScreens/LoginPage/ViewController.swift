//
//  ViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 5.07.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var btnView: UIView!
    
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
    
    @IBAction func loginClicked(_ sender: UIButton) {
        self.navigationController?.pushViewController(PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal), animated: true)
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
