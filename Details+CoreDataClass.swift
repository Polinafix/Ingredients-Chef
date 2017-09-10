//
//  Details+CoreDataClass.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 09/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation
import CoreData


public class Details: NSManagedObject {
    
    convenience init(_ ingredients:[String],_ readyInMinutes:Int,_ instructions:String?,context: NSManagedObjectContext?){
    
        if let detail = NSEntityDescription.entity(forEntityName: "Details", in: context!){
            self.init(entity:detail, insertInto: context)
            self.ingredients = ingredients as [NSString]?
            self.readyInMinutes = Int32(readyInMinutes)
            self.instructions = instructions
            
        }else{
            fatalError("Unable to find entity name!")
        }
    }

}
