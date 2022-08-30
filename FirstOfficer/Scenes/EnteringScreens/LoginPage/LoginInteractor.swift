//
//  LoginInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 30.08.2022.
//

import Foundation

protocol LoginBusinessLogic: AnyObject {
    func getLogin(email: String, password: String)
}

protocol LoginDataStore: AnyObject {
    
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorkingLogic = LoginWorker()
    
    func getLogin(email: String, password: String){
        
    }
    
}
