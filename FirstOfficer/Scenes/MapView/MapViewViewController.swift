//
//  MapViewViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import UIKit
import MapKit

protocol MapViewDisplayLogic: AnyObject {
    
}

final class MapViewViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var interactor: MapViewBusinessLogic?
    var router: (MapViewRoutingLogic & MapViewDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MapViewInteractor()
        let presenter = MapViewPresenter()
        let router = MapViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension MapViewViewController: MapViewDisplayLogic {
    
}
