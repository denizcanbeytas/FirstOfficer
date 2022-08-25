//
//  MapViewViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import UIKit
import MapKit
import CoreLocation

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
    
    var locationManager = CLLocationManager()
    var annotationIndex: Int?
    let regionInMeters: Double = 10000
    
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
        locationManager.delegate = self
        locationSetup()
        setPins()
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
    
    func locationSetup(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.showsScale = true
    }
    
    private func setPins(){
        viewModel?.officesForMapArray.forEach { model in
            annotationIndex = model.id
            mapView.addAnnotation(OfficeAnnotation(coordinate: .init(latitude: model.latitude ?? 0.0,
                                                                 longitude: model.longidute ?? 0.0),
                                                                 title: model.name ?? ""))
        }
    }
    
//    func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//    
//    func checkLocationServices() {
//        if CLLocationManager.locationServicesEnabled() {
//             setupLocationManager()
////            checkLocationAuthorization()
//        } else {
//            // Show alert letting the user know they have to turn this on.
//        }
//    }
//    
//    func checkLocationAuthorization() {
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse:
//            mapView.showsUserLocation = true
//            centerViewOnUserLocation()
//            locationManager.startUpdatingLocation()
//            break
//        case .denied:
//            // Show alert instructing them how to turn on permissions
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            // Show an alert letting them know what's up
//            break
//        case .authorizedAlways:
//            break
//        }
//    }
//    
//    func centerViewOnUserLocation() {
//        if let location = locationManager.location?.coordinate {
//            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//            mapView.setRegion(region, animated: true)
//        }
//    }
}

extension MapViewViewController: MapViewDisplayLogic {
    func displayOfficesForMap(viewModel: MapView.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}

extension MapViewViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard !(annotation is MKUserLocation) else {
//            return nil
//        }
//
//        let annotationIdentifier = "\(annotationIndex ?? 0)"
//        var annotationView: MKAnnotationView?
//        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
//            annotationView = dequeuedAnnotationView
//            annotationView?.annotation = annotation
//        } else {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//
//            let navigationButton = UIButton(type: .detailDisclosure)
//            navigationButton.setImage(UIImage(named: "golocation"), for: .normal)
//            annotationView?.rightCalloutAccessoryView = navigationButton
//
//            let closeButton = UIButton(type: .detailDisclosure)
//            closeButton.setImage(UIImage(named: "info"), for: .highlighted)
//            closeButton.tag = 1
//            annotationView?.leftCalloutAccessoryView = closeButton
//        }
//
//        if let annotationView = annotationView {
//            annotationView.canShowCallout = true
//            annotationView.image = UIImage(named: "FavoriteClicked")
//            annotationView.backgroundColor = .white
//        }
//          return annotationView
//    }
    //MARK: Setting annotation buttons
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        
//        //Birden fazla buton ve tek fonksiyon olduğu için tag'ladık.
//        if control.tag == 0 {
//            guard let selectedAnnotation = view.annotation else {
//                return
//            }
//
//            let requestLocation = CLLocation(latitude: selectedAnnotation.coordinate.latitude, longitude: selectedAnnotation.coordinate.longitude)
//            
//            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemark, error in
//                
//                if let placemarks = placemark {
//                    if placemarks.count > 0 {
//                        let newPlacemark = MKPlacemark(placemark: placemarks[0])
//                        let item = MKMapItem(placemark: newPlacemark)
//                        
//                        item.name = selectedAnnotation.title ?? ""
//                        
//                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//                        item.openInMaps(launchOptions: launchOptions)
//                    }
//                }
//            }
//        } else {
//            if let routeID = Int(view.reuseIdentifier ?? "") {
//                router?.routeToDetails(indexID: routeID)
//            }
//            
//        }
//        
//    }
}

extension MapViewViewController: CLLocationManagerDelegate {
//    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locationManager.location?.coordinate else {
//            return
//        }
//        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
//        let region = MKCoordinateRegion(center: location, span: span)
//        mapView.setRegion(region, animated: true)
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //
    }
}
