//
//  LoginWorker.swift
//  FirstOfficer
//
//  Created by Deniz on 30.08.2022.
//

import Foundation
import Firebase

protocol LoginWorkingLogic: AnyObject {
    func loginUser(email: String, password: String)
}

final class LoginWorker: LoginWorkingLogic {
    
    func loginUser(email: String, password: String){
        
//        let auth = Auth.auth()
//        auth.signIn(withEmail: email, password: password) { (authdata, error) in
//            if error != nil {
//                let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: .alert)
//            }
//        }
    }
}
