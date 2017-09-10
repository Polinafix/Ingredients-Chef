//
//  Recipe+CoreDataClass.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 09/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation
import CoreData


public class Recipe: NSManagedObject {
    //id:Int, title:String, imageURL:String,details:DetailedRecipe
    
    convenience init(_ id:Int,_ title:String?,_ image:Data?,_ details:Details?, context: NSManagedObjectContext?){
        
        if let recipe = NSEntityDescription.entity(forEntityName: "Recipe", in: (context)!){
            self.init(entity:recipe, insertInto: context)
            self.id = Int32(id)
            self.title = title
            self.data = image as NSData?
            self.details = details
        }else{
            fatalError("Unable to find entity name!")
        }
    }

}
