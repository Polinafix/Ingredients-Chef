//
//  Ingredient.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 01/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation


class Ingredient {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
