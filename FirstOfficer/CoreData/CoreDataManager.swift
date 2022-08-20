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
    var coreDataStack: CoreDataStack
    var moc: NSManagedObjectContext {
        return coreDataStack.managedContext
    }

    private init(coreDataStack: CoreDataStack = CoreDataStack(modelName: "FavoritesCoreData")) {
        self.coreDataStack = coreDataStack
    }

    private func favoritesIDPredicate(of request: NSFetchRequest<Model>, with id: Int) -> NSPredicate {
        request.predicate = NSPredicate(format: "id == %d", id)
        return request.predicate!
    }
    
    func getFavoritesFromPersistance(completion: @escaping (Result<[Model], Error>) -> Void) {
        do {
            let request: NSFetchRequest<Model> = Model.fetchRequest()
            request.returnsObjectsAsFaults = false
            let favorites = try moc.fetch(request)
            completion(.success(favorites))
        } catch {
            completion(.failure(error))
        }
    }
    
    func checkIsFavourite(with favoritesID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            let request: NSFetchRequest<Model> = Model.fetchRequest()
            request.returnsObjectsAsFaults = false
            request.predicate = favoritesIDPredicate(of: request, with: favoritesID)
            let fetchedResults = try moc.fetch(request)
            fetchedResults.first != nil ? completion(.success(true)) : completion(.success(false))
        } catch {
            completion(.failure(error))
        }
    }
    
    func getFavouritesId(completion: @escaping (Result<[String], Error>) -> Void){
        var coreDataOfficeId : [String] = []
        let request: NSFetchRequest<Model> = Model.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let favorites = try moc.fetch(request)
            for result in favorites as [NSManagedObject] {
                if let id = result.value(forKey: "id") as? String{
                    coreDataOfficeId.append(id)
                }
            }
            completion(.success(coreDataOfficeId))
        }
        catch {
            completion(.failure(error))
        }
        
    }

    func saveFavoritesToCoreData(with officeResult: Offices.Fetch.ViewModel.Office) {
        
        let favouriteOffices = Model(context: moc)
        favouriteOffices.id = officeResult.id
        favouriteOffices.image = officeResult.image
        favouriteOffices.name = officeResult.image
        favouriteOffices.address = officeResult.address
        favouriteOffices.space = officeResult.space
        favouriteOffices.rooms = officeResult.rooms
        favouriteOffices.capacity = officeResult.capacity
        coreDataStack.saveContext()
       
//        if let appDelegate = UIApplication.shared.delegate as?AppDelegate{
//            let context = appDelegate.persistentContainer.viewContext
//
//            let entityDescription = NSEntityDescription.insertNewObject(forEntityName: "Model", into: context)
//           // entityDescription.setValue(viewModel.images, forKey: "images")
//            entityDescription.setValue(officeResult.name, forKey: "name")
//            entityDescription.setValue(officeResult.rooms, forKey: "rooms")
//            entityDescription.setValue(officeResult.address, forKey: "address")
//            entityDescription.setValue(officeResult.capacity, forKey: "capacity")
//            entityDescription.setValue(officeResult.image, forKey: "image")
//            entityDescription.setValue(officeResult.id, forKey: "id")
//            entityDescription.setValue(officeResult.space, forKey: "space")
//            //entityDescription.setValue(true, forKey: "fav")
//            do{
//                try context.save()
//                print("Saved")
//            }catch{
//                print("Saving Error")
//            }
        
        print("Saved")
        
    }

    func deleteFavoritesFromCoreData(with favoriteId: Int, completion: @escaping (Error) -> Void) {
        let request: NSFetchRequest<Model> = Model.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.predicate = favoritesIDPredicate(of: request, with: favoriteId)
        do {
            let fetchedResult = try moc.fetch(request)
            if let officeModel = fetchedResult.first {
                moc.delete(officeModel)
                coreDataStack.saveContext()
            }
        } catch {
            completion(error)
        }
        
        print("Deleted")
    }
}
