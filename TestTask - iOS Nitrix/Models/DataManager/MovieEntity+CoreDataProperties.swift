//
//  MovieEntity+CoreDataProperties.swift
//  TestTask - iOS Nitrix
//
//  Created by Артем Сергеев on 01.02.2024.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var tittle: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var posterImage: Data?
    @NSManaged public var backdropImage: Data?
    @NSManaged public var releaseDate: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var overview: String?
    @NSManaged public var genres: String?

}

extension MovieEntity : Identifiable {

}
