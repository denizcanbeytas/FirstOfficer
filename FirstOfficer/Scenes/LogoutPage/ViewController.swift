//
//  ViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 5.07.2022.
//

import UIKit

class ViewController: UIViewController {

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

        setupUI()
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Offices", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(identifier: "OfficesVC")
//        self.navigationController?.pushViewController(destinationVC, animated: true)
        
        self.navigationController?.pushViewController(PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal), animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        btnView.layer.borderColor = UIColor(named: "LoginBtnBorderColor")?.cgColor
    }
    
    func setupUI() {
        loginView.layer.cornerRadius = 30
        btnView.layer.cornerRadius = 18
        btnView.layer.borderColor = UIColor(named: "LoginBtnBorderColor")?.cgColor
        btnView.layer.borderWidth = 4
        
        loginView.layer.masksToBounds = false
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOpacity = 0.2
        loginView.layer.shadowOffset = .zero
        loginView.layer.shadowRadius = 3
        
        facebookView.layer.cornerRadius = 22
        twitterView.layer.cornerRadius = 22
        emailView.layer.cornerRadius = 22
        
        
    }

}
