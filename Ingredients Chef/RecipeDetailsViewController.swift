//
//  RecipeDetailsViewController.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 04/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array:[String] = ["butter","milk","sugar","salt","chocolate","cinnamon"]
    var recipeId:Int = 479101

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // timeLabel.text = "15 min"
        recipeImage.image = UIImage(named: "beef")
        
        //instructions.sizeToFit()

        // Do any additional setup after loading the view.
       // loadDetailedRecipe()
    }

    func loadDetailedRecipe(){
        
        
        FoodAPIRequest.sharedInstance.showDetailedRecipe(recipeId) { (result, error) in
            if error ==  nil{
                performUIUpdatesOnMain {
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
