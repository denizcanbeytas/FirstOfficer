//
//  RegisterInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 30.08.2022.
//

import Foundation

protocol RegisterBusinessLogic: AnyObject {
    func getRegister(email: String, password: String)
}

protocol RegisterDataStore: AnyObject {
    
}

final class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore {
    
    var presenter: RegisterPresentationLogic?
    var worker: RegisterWorkingLogic = RegisterWorker()
    
    func getRegister(email: String, password: String){
        worker.registerUsers(email: email, password: password)
    }
    
}
