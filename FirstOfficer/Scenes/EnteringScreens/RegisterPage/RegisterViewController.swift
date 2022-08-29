//
//  RegisterViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 27.07.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var facebookView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        btnView.layer.borderColor = UIColor(named: "LoginBtnBorderColor")?.cgColor
    }
}

extension RegisterViewController {
    func setupNavigationBar(){
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.label
    }
}
