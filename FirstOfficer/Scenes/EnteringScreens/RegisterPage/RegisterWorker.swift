//
//  RegisterWorker.swift
//  FirstOfficer
//
//  Created by Deniz on 30.08.2022.
//

import Foundation
import Firebase

protocol RegisterWorkingLogic: AnyObject {
    func registerUsers(email: String, password: String)
}

final class RegisterWorker: RegisterWorkingLogic {
    
    func registerUsers(email: String, password: String){
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: password) { (authresult, error) in
            
            if let user = authresult?.user
            {
                print(user)
            }else
            {
                print("User can't enter.")
            }
        }
    }
}
