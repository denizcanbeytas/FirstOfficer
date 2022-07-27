//
//  WelcomeViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 27.07.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

 
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var loginBtnView: UIView!
    @IBOutlet weak var createBtnView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uiDesign()
    }
    

    func uiDesign(){
        
        createBtnView.layer.cornerRadius = 10
        createBtnView.layer.borderWidth = 1
        
        loginBtnView.layer.cornerRadius = 10
        loginBtnView.layer.borderWidth = 1
    }
    @IBAction func createBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    @IBAction func loginBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
}
