//
//  ProfileInteractor.swift
//  FirstOfficer
//
//  Created by Deniz on 30.08.2022.
//

import Foundation

protocol ProfileBusinessLogic: AnyObject {
    
}

protocol ProfileDataStore: AnyObject {
    
}

final class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorkingLogic = ProfileWorker()
    
}
