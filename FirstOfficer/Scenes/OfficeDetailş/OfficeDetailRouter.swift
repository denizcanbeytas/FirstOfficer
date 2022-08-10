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
    //var officeData: [OfficeData]?
   // var office: self.dataStore?.officeDetailData?
    
    func routeToFullScreen(index: Int) {
        let storyBoard = UIStoryboard(name: "FullScreen", bundle: nil)
        let destinationVC: FullScreenViewController = storyBoard.instantiateViewController(withIdentifier: "fullScreenVC") as! FullScreenViewController
        destinationVC.router?.dataStore?.ImageData = dataStore?.officeDetailData
        destinationVC.router?.dataStore?.selectedIndex = index
       // destinationVC.router?.dataStore?.ImageData = dataStore?.officeDetailData?.images?[index]
        
//       self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        
       // destinationVC.delegateFullScreen = viewController as! FullScreenDelegate
        viewController?.present(destinationVC, animated: true) // -> pop up geçiş
    }
    
    
    
}
