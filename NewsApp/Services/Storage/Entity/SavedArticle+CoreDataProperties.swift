//
//  SavedArticle+CoreDataProperties.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 04.11.2022.
//
//

import Foundation
import CoreData


extension SavedArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedArticle> {
        return NSFetchRequest<SavedArticle>(entityName: "SavedArticle")
    }
    
    @nonobjc public class func fetchRequest(url: String) -> NSFetchRequest<SavedArticle> {
        let request = fetchRequest()
        let symbolPredicate = NSPredicate(format: "url == %@", url)
        
        request.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [symbolPredicate]
        )
        return request
    }

    @NSManaged public var author: String?
    @NSManaged public var descriptionArticle: String?
    @NSManaged public var image: Data?
    @NSManaged public var source: String
    @NSManaged public var title: String
    @NSManaged public var url: String

}

extension SavedArticle : Identifiable {

}
