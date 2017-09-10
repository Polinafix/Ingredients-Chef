//
//  RecipeDetailsViewController.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 04/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit
import CoreData



class RecipeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array:[String] = []
    var recipeId:Int = 479101
    var imageUrl:String?
    var minutes:Int?
    var recipe:MyRecipe?
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext: NSManagedObjectContext!

    @IBOutlet weak var tableView: UITableView!
   // @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var instructionsView: UITextView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor(red:0.33, green:0.36, blue:0.43, alpha:1.0)
        //instructions.font = UIFont(name: "Palatino", size: 17)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
       loadImage()
       loadDetailedRecipe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
    }

    func loadDetailedRecipe(){
        FoodAPIRequest.sharedInstance.showDetailedRecipe(recipeId) { (result, error) in
            if error ==  nil{
                performUIUpdatesOnMain {
                    self.recipe?.details = result
                    self.array = result.ingredients! as [String]
                    self.instructionsView.text = result.instructions
                    self.minutes = result.readyInMinutes!
                    self.timeLabel.text = "\(self.minutes!) min"
                    self.tableView.reloadData()
                }
            }else{
                
                self.showAlert(title: "Error", message: "\(error?.localizedDescription)")
            }
        }
        
    }
    
    func showAlert(title:String, message:String?) {
        
        if let message = message {
            let alert = UIAlertController(title: title, message: "\(message)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func loadImage(){
        FoodAPIRequest.sharedInstance.fromUrlToData(imageUrl!) { (imageData, error) in
            if let data = imageData{
                performUIUpdatesOnMain {
                    self.recipe?.data = data
                    self.recipeImage.image = UIImage(data: self.recipe!.data! as Data)
                    
                }
            }else{
                print("Data error: \(error)")
            }
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        managedContext = appDelegate.getContext()
        let details = Details(array, minutes!, instructionsView.text!, context: managedContext)
        _ = Recipe(recipeId, recipe?.title, recipe?.data,details, context: managedContext)
        CoreDataStack.saveContext(managedContext)
        
        favButton.isHidden = true
        
        //show the alert message
        displayAlert()
        
      // dismiss(animated: true, completion: nil)
        
        
    }
    
    func displayAlert() {
        
        let alert = UIAlertController(title: "Success!", message: "This recipe has just been added to your favorites!", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        
        let item = array[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Palatino", size: 17)
        cell.textLabel?.text = item
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping

        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

}
