//
//  IngredientsTableViewController.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 01/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class IngredientsTableViewController: UITableViewController, AddIngredientTVCDelegate {
    
    var ingredients:[Ingredient] = []
    var checkedIngredients:[String] = []
    var ingredientList: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let row0Item = Ingredient()
        row0Item.text = "Milk"
        row0Item.checked = true
        ingredients.append(row0Item)
        
        let row1Item = Ingredient()
        row1Item.text = "Butter"
        row1Item.checked = true
        ingredients.append(row1Item)
        
       
        
       /* for ingr in ingredients{
            if ingr.checked{
                //print(ingr.text)
                checkedIngredients.append(ingr.text)
            }
            
        }
        ingredientList = checkedIngredients.joined(separator: ",")
        print(ingredientList)*/
        

        
    }
    
    func addIngredientTVCDidCancel(_ controller: AddIngredientTableViewController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func addIngredientTVC(_ controller: AddIngredientTableViewController, didFinishAdding item: Ingredient) {
        let newRowIndex = ingredients.count
        ingredients.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }
  

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ingredients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        
        let item = ingredients[indexPath.row]
        cell.textLabel?.text = item.text
        
        configureCheckmark(for: cell, with: item)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at:  indexPath) {
            
            let item = ingredients[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with:item)
            
            if item.checked {
                ingredientList = item.text
               
            }
            print(ingredientList)
        
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configureCheckmark(for cell: UITableViewCell,
                            with item:Ingredient) {
        
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
 
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        ingredients.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
 
    
    // MARK: - Navigation
    //Tell object B that object A is now its delegate.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddIngredient" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController
                as! AddIngredientTableViewController
            controller.delegate = self
        }else if segue.identifier == "showRecipes" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! FoundRecipesCollectionViewController
            //create a separate array of the checked ingredients
            for ingr in ingredients{
                if ingr.checked{
                    print(ingr.text)
                    checkedIngredients.append(ingr.text)
                }
                
            }
            //convert them into a string
            ingredientList = checkedIngredients.joined(separator: ",")
            
            
        }
    }


}
