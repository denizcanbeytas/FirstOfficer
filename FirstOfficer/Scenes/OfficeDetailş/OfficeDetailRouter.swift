//
//  OfficeDetailRouter.swift
//  FirstOfficer
//
//  Created by Deniz on 7.08.2022.
//

import Foundation
import UIKit

protocol OfficeDetailRoutingLogic: AnyObject {
    func routeToFullScreen(index: Int)
}

protocol OfficeDetailDataPassing: class {
    var dataStore: OfficeDetailDataStore? { get } // interactor daki dataya erişim
}

final class OfficeDetailRouter: OfficeDetailRoutingLogic, OfficeDetailDataPassing {

    weak var viewController: OfficeDetailViewController?
    var dataStore: OfficeDetailDataStore?
    
    func routeToFullScreen(index: Int) {
        let storyBoard = UIStoryboard(name: "FullScreen", bundle: nil)
        let destinationVC: FullScreenViewController = storyBoard.instantiateViewController(withIdentifier: "fullScreenVC") as! FullScreenViewController
        destinationVC.router?.dataStore?.ImageData = dataStore?.officeDetailData
        
//       self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        
        viewController?.present(destinationVC, animated: true) // -> pop up geçiş
    }
    
    
    
}
