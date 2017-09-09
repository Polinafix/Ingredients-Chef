//
//  Ingredients+CoreDataProperties.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 07/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation
import CoreData


extension Ingredients {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredients> {
        return NSFetchRequest<Ingredients>(entityName: "Ingredients");
    }

    @NSManaged public var text: String?
    @NSManaged public var checked: Bool

}
