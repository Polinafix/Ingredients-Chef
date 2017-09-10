//
//  MyRecipe.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 09/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation

class MyRecipe {
    var id:Int?
    var title = ""
    var imageURL = ""
    var data:Data?
    var details:DetailedRecipe?

    init(id:Int, title:String, imageURL:String,details:DetailedRecipe?) {
    self.id = id
    self.title = title
    self.imageURL = imageURL
    self.details = details
    }
    
}
