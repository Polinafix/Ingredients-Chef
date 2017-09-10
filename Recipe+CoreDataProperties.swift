//
//  Recipe+CoreDataProperties.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 09/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe");
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var data: NSData?
    @NSManaged public var details: Details?

}
