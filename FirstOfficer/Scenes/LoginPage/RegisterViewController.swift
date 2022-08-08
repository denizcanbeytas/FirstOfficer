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

        setupUI()
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
