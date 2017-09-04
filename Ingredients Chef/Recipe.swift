//
//  Recipe.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 03/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation

class Recipe {
    var id:Int?
    var title = ""
    var imageURL = ""
    var data:Data?
    
    init(id:Int, title:String, imageURL:String) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
    
}
