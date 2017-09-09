//
//  Ingredients+CoreDataClass.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 07/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation
import CoreData


public class Ingredients: NSManagedObject {
    
    func toggleChecked() {
        checked = !checked
    }
    
    convenience init(_ name:String,_ checked:Bool, context: NSManagedObjectContext?){
        
        if let ingredient = NSEntityDescription.entity(forEntityName: "Ingredients", in: context!){
            self.init(entity:ingredient, insertInto: context)
            self.text = name
            self.checked = checked
        }else{
            fatalError("Unable to find entity name!")
        }
    }

}
