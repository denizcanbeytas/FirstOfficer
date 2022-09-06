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
        favouriteOffices.name = officeResult.name
        favouriteOffices.address = officeResult.address
        favouriteOffices.space = officeResult.space
        favouriteOffices.rooms = officeResult.rooms
        favouriteOffices.capacity = officeResult.capacity
        coreDataStack.saveContext()
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
