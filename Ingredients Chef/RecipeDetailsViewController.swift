//
//  RecipeDetailsViewController.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 04/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

//protocol
protocol RecipeDetailsDelegate: class {
    //func addIngredientTVCDidCancel(_ controller: AddIngredientTableViewController)
    func addToFavorites(_ controller: RecipeDetailsViewController,
                          didFinishAdding recipe: DetailedRecipe)
}

class RecipeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array:[String] = ["butter","milk","sugar","salt","chocolate","cinnamon"]
    var recipeId:Int = 479101
    var imageUrl:String?
    var recipe:Recipe?
    weak var delegate: RecipeDetailsDelegate?
    var detailedRecipe:DetailedRecipe?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.delegate = FavoritesTableViewController.self as? RecipeDetailsDelegate
        //timeLabel.text =
        //recipeImage.image = UIImage(named: "beef")
        
       loadImage()
       loadDetailedRecipe()
    }

    func loadDetailedRecipe(){
        
        
        FoodAPIRequest.sharedInstance.showDetailedRecipe(recipeId) { (result, error) in
            if error ==  nil{
                performUIUpdatesOnMain {
                    self.detailedRecipe = result
                    print("This is an object:\(self.detailedRecipe!)")
                    self.array = result.ingredients!
                    print("\(self.array.count) ingredients from ... fetched")
                    self.instructions.text = result.instructions
                    self.tableView.reloadData()
                }
            }else{
                print("couldn't get photos from food API")
            }
        }
        
    }
    
    func loadImage(){
        FoodAPIRequest.sharedInstance.fromUrlToData(imageUrl!) { (imageData, error) in
            if let data = imageData{
                performUIUpdatesOnMain {
                    self.recipe?.data = data
                    self.recipeImage.image = UIImage(data: self.recipe!.data!)
                    
                }
            }else{
                print("Data error: \(error)")
            }
        }
    }
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        
       // var storyboard = UIStoryboard(name: "IDEInterface", bundle: nil)
        let controller = storyboard?.instantiateViewController(withIdentifier: "FavoritesVC") as! FavoritesTableViewController
        
        controller.favString = "love"
        
        dismiss(animated: true, completion: nil)
        
        
        
      //  if let printed = detailedRecipe?.readyInMinutes {
      //      print("Here you go:\(printed)")
      //  }
        
       // let item = DetailedRecipe(ingredients: (detailedRecipe?.ingredients!)!, readyInMinutes: (detailedRecipe?.readyInMinutes!)!, instructions: (detailedRecipe?.instructions!)!, imageUrl: (detailedRecipe?.imageUrl!)!)
        //delegate?.addToFavorites(self, didFinishAdding: item)
    
        
    }
    /*func recipeLike(){
        if heart is pressed{
            1)change to another picture
            2)save the current recipe to Core Data
            3)use delegate
        }
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        
        let item = array[indexPath.row]
        cell.textLabel?.text = item

        
        return cell
    }

}
