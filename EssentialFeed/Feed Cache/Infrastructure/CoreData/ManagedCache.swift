//
//  ManagedCache.swift
//  EssentialFeed
//
//  Created by Julius on 19/06/2022.
//

import CoreData

@objc(ManagedCache)
 class ManagedCache: NSManagedObject {
    @NSManaged var timestamp: Date
    @NSManaged var feed: NSOrderedSet
    
     var localFeed: [LocalFeedImage] {
        return feed.compactMap { ($0 as? ManagedFeedImage)?.local}
    }
}

extension ManagedCache {
     static func find(in context: NSManagedObjectContext) throws -> ManagedCache? {
        let request = NSFetchRequest<ManagedCache>(entityName: entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }
    
    static func deleteCache(in context: NSManagedObjectContext) throws {
        try find(in: context).map(context.delete).map(context.save)
    }
    
     static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedCache {
         try deleteCache(in: context)
        return ManagedCache(context: context)
    }
}

