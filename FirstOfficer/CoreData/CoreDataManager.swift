//
//  CoreDataManager.swift
//  FirstOfficer
//
//  Created by Deniz on 20.08.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {

    static let shared = CoreDataManager()

    func checkIsFavourite(with movieID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {

    }

    func getMoviesFromPersistance(completion: @escaping (Result<[Model], Error>) -> Void) {

    }

    func saveFavoritesToCoreData(with officeResult: Offices.Fetch.ViewModel.Office) {
       
        if let appDelegate = UIApplication.shared.delegate as?AppDelegate{
            let context = appDelegate.persistentContainer.viewContext

            let entityDescription = NSEntityDescription.insertNewObject(forEntityName: "OfficeModel", into: context)
           // entityDescription.setValue(viewModel.images, forKey: "images")
            entityDescription.setValue(officeResult.name, forKey: "name")
            entityDescription.setValue(officeResult.rooms, forKey: "rooms")
            entityDescription.setValue(officeResult.address, forKey: "address")
            entityDescription.setValue(officeResult.capacity, forKey: "capacity")
            entityDescription.setValue(officeResult.image, forKey: "image")
            entityDescription.setValue(officeResult.id, forKey: "id")
            entityDescription.setValue(officeResult.space, forKey: "space")
            //entityDescription.setValue(true, forKey: "fav")
            do{
                try context.save()
                print("Saved")
            }catch{
                print("Saving Error")
            }
    }
        
        //let favoriteOffices = Model(context: moc)
//        favoriteOffices.id = officeResult.id
//        favoriteOffices.name = officeResult.name
//        favoriteOffices.address = officeResult.address
//        favoriteOffices.image = officeResult.image
//        favoriteOffices.capacity = officeResult.capacity
//        favoriteOffices.rooms = officeResult.rooms
//        favoriteOffices.space = officeResult.space
        
        print("Saved")
        
    }

    func deleteFavoritesFromCoreData(with movieID: Int, completion: @escaping (Error) -> Void) {

    }
}
