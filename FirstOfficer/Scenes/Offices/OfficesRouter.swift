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
    var dataStore: OfficesDataStore? { get } // interactor daki OfficesDataStore protocol ü tipinde bir değişken
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

/*
    - destinationVC.router?.dataStore?.officeDetailData = dataStore?.officeData?[index] -> açıklaması
        . Detail sayfasına, tıklanan tableView hücresindeki elemanın değerlerini göndereceğimiz için, karşı taraftaki data array olmayacak.
 
    - destinationVC ile diğer sayfanın router ına erişebildik çünkü router değişkeni diğer sayafanın vc sinde var.
    - Data nın işlenmeden önceki geldiği son nokta interactor dadır.
 
 */
