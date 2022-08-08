//
//  OfficesRouter.swift
//  FirstOfficer
//
//  Created by Deniz on 5.08.2022.
//

import Foundation
import UIKit

protocol OfficesRoutingLogic: AnyObject {
    func routerToOfficeDetail(index: Int)
}

protocol OfficesDataPassing: class {
    var dataStore: OfficesDataStore? { get }
}

final class OfficesRouter: OfficesRoutingLogic, OfficesDataPassing {

    weak var viewController: OfficesViewController?
    var dataStore: OfficesDataStore?
    
    func routerToOfficeDetail(index: Int) {
        let storyboard = UIStoryboard(name: "OfficeDetail", bundle: nil)
        let destinationVC: OfficeDetailViewController = storyboard.instantiateViewController(withIdentifier: "detailVC") as! OfficeDetailViewController
        destinationVC.router?.dataStore?.officeDetailData = dataStore?.officeData?[index] // -> data'yı tekli göndereceğimiz için array in içindeki değeri array olmayan dataya atacağız
        
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

}
