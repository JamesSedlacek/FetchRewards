//
//  CoreDataManager.swift
//  CoreDataManager
//
//  Created by James Sedlacek on 10/2/21.
//

import UIKit

struct CoreDataManager {
    private static let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    // MARK: - Append
    
    public static func append(_ event: EventVM) {
        guard let context = context else { return }
        
        let newEvent = Event(context: context)
        newEvent.id = event.id
        newEvent.date = event.date
        newEvent.time = event.time
        newEvent.title = event.title
        newEvent.location = event.location
        newEvent.url = event.url
        newEvent.imageUrl = event.imageUrl
        newEvent.latitude = event.coordinates.latitude
        newEvent.longitutde = event.coordinates.longitude
        
        do {
            try context.save()
        } catch {
            // TODO: Log &/or Handle Error
        }
    }
    
    // MARK: - Remove
    
    public static func remove(_ eventToDelete: EventVM) {
        guard let context = context else { return }
        
        do {
            let events: [Event] = try context.fetch(Event.fetchRequest())
            
            for event in events {
                if event.id == eventToDelete.id {
                    context.delete(event)
                    try context.save()
                    return
                }
            }
            
        } catch {
            // TODO: Log &/or Handle Error
        }
    }
    
    // MARK: - Contains
    
    public static func contains(_ event: EventVM) -> Bool {
        let events = getAll()
        if events.count == 0 { return false }
        return events.contains(where: {$0.id == event.id})
    }
    
    // MARK: - GetAll
    
    public static func getAll() -> [EventVM] {
        guard let context = context else { return [] }
        
        do {
            let events: [Event] = try context.fetch(Event.fetchRequest())
            var eVMs: [EventVM] = []
            for event in events {
                eVMs.append(EventVM(id: event.id,
                                    date: event.date,
                                    time: event.time,
                                    title: event.title,
                                    location: event.location,
                                    url: event.url,
                                    imageUrl: event.imageUrl,
                                    lon: event.longitutde,
                                    lat: event.latitude))
            }
            
            return eVMs
        } catch {
            // TODO: Log &/or Handle Error
        }
        
        return []
    }
}
