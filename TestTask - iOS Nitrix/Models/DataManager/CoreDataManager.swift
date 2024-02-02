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
    let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    do {
      let movies = try viewContext.fetch(fetchRequest)
      let uniqueMovies = movies.reduce(into: [MovieEntity]()) { result, movie in
        if !result.contains(where: { $0.id == movie.id }) {
          result.append(movie)
        }
      }
      return uniqueMovies
    } catch {
      print("Error fetching movies: \(error.localizedDescription)")
      return []
    }
  }
  
  public func delete(movieEntity: MovieEntity) {
    let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", movieEntity.id as NSNumber)
    
    do {
      let movies = try viewContext.fetch(fetchRequest)
      movies.forEach { viewContext.delete($0) }
      saveContext()
    } catch {
      print("Error deleting movie: \(error.localizedDescription)")
    }
  }
  
  
}
