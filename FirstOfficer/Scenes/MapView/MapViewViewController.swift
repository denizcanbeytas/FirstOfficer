//
//  MapViewViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import UIKit
import MapKit


protocol MapViewDisplayLogic: AnyObject {
    func displayOfficesForMap(viewModel: MapView.Fetch.ViewModel )
}

final class MapViewViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {mapView.mapType = .standard}
    }
    
    var interactor: MapViewBusinessLogic? {
        didSet {interactor?.getOfficeForMap(request: MapView.Fetch.Request())}
    }
    
    var router: (MapViewRoutingLogic & MapViewDataPassing)?
    var viewModel: MapView.Fetch.ViewModel?
    
    var annotationIndex: Int?
    let initialLocation = CLLocation(latitude: 41.015137, longitude: 28.979530)
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.centerToLocation(initialLocation)
        setVisibleArea()
        addAnnotations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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

// MARK: Extensions

extension MapViewViewController: MapViewDisplayLogic {
    func displayOfficesForMap(viewModel: MapView.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}

private extension MKMapView {
    // when map starts, we give any locations that we want
  func centerToLocation(_ location: CLLocation,regionRadius: CLLocationDistance = 20000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

extension MapViewViewController {
    
    private func addAnnotations(){
        // we created annotation with pin
        viewModel?.officesForMapArray.forEach { model in
            annotationIndex = model.id
            mapView.addAnnotation(OfficeAnnotation(coordinate: .init(latitude: model.latitude ?? 0.0,
                                                                 longitude: model.longidute ?? 0.0),
                                                                 title: model.name ?? ""))
        }
    }
    
    func setVisibleArea(){
        // we gave area limit to map
        // user only go to area of istanbul
        let oahuCenter = CLLocation(latitude: 41.015137, longitude: 28.979530)
        let region = MKCoordinateRegion(
          center: oahuCenter.coordinate,
          latitudinalMeters: 50000,
          longitudinalMeters: 60000)
        mapView.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
}

/*
 * if you want to zoom in the simulator, press opt and drag in the mapview !
 */
