//
//  DetailedRecipe.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 05/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation

class DetailedRecipe {
    
    var ingredients:[String]?
    var readyInMinutes:Int?
    var instructions:String?
    
    
    init(ingredients: [String], readyInMinutes:Int, instructions:String) {
        self.ingredients = ingredients
        self.readyInMinutes = readyInMinutes
        self.instructions = instructions
    }
    
    
}
