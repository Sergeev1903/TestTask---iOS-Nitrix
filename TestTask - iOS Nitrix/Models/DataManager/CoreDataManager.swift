//
//  CoreDataManager.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 01.02.2024.
//

import Foundation
import CoreData

class CoreDataManager {
  static let shared = CoreDataManager()
  
  private init() {}
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "TestTask___iOS_Nitrix")
    container.loadPersistentStores { storeDescription, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  var viewContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // MARK: - Core Data saving support
  public func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  // MARK: - MovieEntity methods
  public func createMovieEntity() -> MovieEntity {
    let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: viewContext)!
    let movieEntity = MovieEntity(entity: entity, insertInto: viewContext)
    return movieEntity
  }
  
  public func fetchAllMovies() -> [MovieEntity] {
      let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
      do {
          let movies = try viewContext.fetch(fetchRequest)
          var uniqueMovies = [MovieEntity]()
          var movieIDs = Set<Int32>()
          movies.forEach {
              if !movieIDs.contains($0.id) {
                  uniqueMovies.append($0)
                  movieIDs.insert($0.id)
              }
          }
          return uniqueMovies
      } catch {
          print("Error fetching movies: \(error.localizedDescription)")
          return []
      }
  }

  public func delete(movieEntity: MovieEntity) {
    viewContext.delete(movieEntity)
    saveContext()
  }
}
