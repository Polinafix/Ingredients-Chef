//
//  DetailedRecipe.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 05/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation



class DetailedRecipe {
    var name:String?
    var ingredients:[String]?
    var readyInMinutes:Int?
    var instructions:String?
    var imageUrl:String?
    var data:Data?
    
    
    init(ingredients: [String], readyInMinutes:Int, instructions:String, imageUrl:String) {
        self.ingredients = ingredients
        self.readyInMinutes = readyInMinutes
        self.instructions = instructions
        self.imageUrl = imageUrl
    }
    
    
}
