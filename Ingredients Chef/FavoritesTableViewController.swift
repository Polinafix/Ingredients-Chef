//
//  FavoritesTableViewController.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 06/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit
import CoreData



class FavoritesTableViewController: UITableViewController {
    
    var favorites:[Recipe] = []
    var favString:String = ""
    var favs:[Details]?
    var anotherView:RecipeDetailsViewController?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext: NSManagedObjectContext!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites = []
        fetchRecipes()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 90

    }

    func fetchRecipes(){
        let recipeFetch:NSFetchRequest<Recipe> = Recipe.fetchRequest()
        managedContext = appDelegate.getContext()
        
        do{
            let results = try managedContext.fetch(recipeFetch)
            
            if results.count > 0{
                for result in results {
                    favorites.append(result)
                   
                }
                tableView.reloadData()
            }else{
                print("no favorite recipes yet")
            }
            
        }catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (favorites.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as? FavoriteCell
        
        let item = favorites[indexPath.row]
        cell?.recipeName.text = item.title
        let cookingTime = item.details?.readyInMinutes
        cell?.timeToCook.text = "\(cookingTime!) min"
        cell?.recipeImage.image = UIImage(data: item.data as! Data)
        cell?.recipeName.numberOfLines = 0
        cell?.recipeName.lineBreakMode = NSLineBreakMode.byWordWrapping
 
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chosenRecipe = favorites[indexPath.row]
        performSegue(withIdentifier: "showFavDetail", sender: chosenRecipe)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let recipeToDelete = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        managedContext.delete(recipeToDelete)
        CoreDataStack.saveContext(managedContext)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showFavDetail") {
            
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! RecipeDetailsViewController
            controller.savedRecipe = sender as? Recipe
            controller.isFavoriteDetail = true
        }
    }
 


}
