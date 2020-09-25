//
//  ManagedPrayerItem.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 25/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import CoreData

class ManagedPrayerItem: NSManagedObject {
    static let entityName = "PrayerItem"
    
    // MARK: Core Data properties
    
    @NSManaged var title: String
    @NSManaged var isFavourite: Bool
    
    // MARK: Methods
    
    static func insertNew(title: String, isFavourite: Bool, into context: NSManagedObjectContext) -> ManagedPrayerItem {
        let prayerItem = ManagedPrayerItem.insertNew(into: context)
        prayerItem.title = title
        prayerItem.isFavourite = isFavourite
        return prayerItem
    }
    
    static func fetchPrayer(withTitle title: String, from context: NSManagedObjectContext) -> ManagedPrayerItem? {
        let request = makeFetchRequest()
        request.predicate = NSPredicate(format: "title = %@", title)
        do {
            let fetchedPrayers = try context.fetch(request)
            return fetchedPrayers.first
        } catch {
            logError("Failed to fetch all managed prayer items: \(error)") // TODO: Handle error
            return nil
        }
    }
    
    static func fetchAll(from context: NSManagedObjectContext) -> [ManagedPrayerItem]? {
        let request = makeFetchRequest()
        do {
            let fetchedPrayers = try context.fetch(request)
            log("Fetched \(fetchedPrayers.count) managed prayer items.")
            return fetchedPrayers
        } catch {
            logError("Failed to fetch all managed prayer items: \(error)") // TODO: Handle error
            return nil
        }
    }
    
    static func fetchAny(from context: NSManagedObjectContext) -> ManagedPrayerItem? {
        let request = makeFetchRequest()
        request.fetchLimit = 1
        do {
            let fetchedPrayers = try context.fetch(request)
            log("Fetched \(fetchedPrayers.count) managed prayer items.")
            return fetchedPrayers.first
        } catch {
            logError("Failed to fetch any managed prayer item: \(error)") // TODO: Handle error
            return nil
        }
    }
    
    static func fetchFavouritePrayers(from context: NSManagedObjectContext) -> [ManagedPrayerItem]? {
        let request = makeFetchRequest()
        request.predicate = NSPredicate(format: "isFavourite = %d", true)
        do {
            let fetchedPrayers = try context.fetch(request)
            log("Fetched \(fetchedPrayers.count) managed prayer items.")
            return fetchedPrayers
        } catch {
            logError("Failed to fetch favourite managed prayer items: \(error)") // TODO: Handle error
            return nil
        }
    }
    
    // MARK: Private methods
    
    private static func insertNew(into context: NSManagedObjectContext) -> ManagedPrayerItem {
        return NSEntityDescription.insertNewObject(forEntityName: ManagedPrayerItem.entityName, into: context) as! ManagedPrayerItem
    }
    
    private static func makeFetchRequest() -> NSFetchRequest<ManagedPrayerItem> {
        return NSFetchRequest<ManagedPrayerItem>(entityName: ManagedPrayerItem.entityName)
    }
}
