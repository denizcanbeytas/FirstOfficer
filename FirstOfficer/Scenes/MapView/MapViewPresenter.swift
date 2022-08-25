//
//  MapViewPresenter.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import Foundation

protocol MapViewPresentationLogic: AnyObject {
    func sendOfficeForMapToVC(response: MapView.Fetch.Response)
}

final class MapViewPresenter: MapViewPresentationLogic {
    
    weak var viewController: MapViewDisplayLogic?
    
    func sendOfficeForMapToVC(response: MapView.Fetch.Response){
        var offices: [MapView.Fetch.ViewModel.OfficesForMap] = []
        response.OfficesForMap.forEach{
            offices.append(MapView.Fetch.ViewModel.OfficesForMap(id: $0.id,
                                                                 latitude: $0.location?.latitude,
                                                                 longidute: $0.location?.longitude,
                                                                 name: $0.name))
        }
        viewController?.displayOfficesForMap(viewModel: .init(officesForMapArray: offices))
    }
}
