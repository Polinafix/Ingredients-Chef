//
//  Details+CoreDataProperties.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 09/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation
import CoreData


extension Details {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Details> {
        return NSFetchRequest<Details>(entityName: "Details");
    }

    @NSManaged public var readyInMinutes: Int32
    @NSManaged public var instructions: String?
    @NSManaged public var ingredients: [NSString]?
    @NSManaged public var recipe: Recipe?

}
