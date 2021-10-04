//
//  Event+CoreDataProperties.swift
//  FetchRewards
//
//  Created by James Sedlacek on 10/2/21.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var date: String
    @NSManaged public var id: Int
    @NSManaged public var imageUrl: String
    @NSManaged public var latitude: Double
    @NSManaged public var location: String
    @NSManaged public var longitutde: Double
    @NSManaged public var time: String
    @NSManaged public var title: String
    @NSManaged public var url: String

}

extension Event : Identifiable {

}
