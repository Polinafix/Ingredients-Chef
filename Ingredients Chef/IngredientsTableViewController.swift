//
//  IngredientsTableViewController.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 01/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit
import CoreData

class IngredientsTableViewController: UITableViewController, AddIngredientTVCDelegate {
    
    var ingredients:[Ingredients] = []
    var checkedIngredients:[String] = []
    var ingredientList: String = ""
    var managedContext: NSManagedObjectContext!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //creating custom colors
    let brightGreen = UIColor(red: 137, green: 176, blue: 174)
    let lightGreen = UIColor(red: 190, green: 227, blue: 219)
    let myPurple = UIColor(red:85, green:91, blue:110)
    let lightGrey = UIColor(red: 250, green: 249, blue: 249)
    
    var button = UIButton()
    var emptyLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(IngredientsTableViewController.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //create a floating button
        createButton(160)
        
        if ingredients.isEmpty {
            button.isHidden = true
            starterMessage(message: " Please add your Ingredients to start searching for amazing recipes! ", viewController: self, empty:true)
        }
        
        //fetch ingredients from Core Data
        fetchIngredients()
       
      
    }
    
    func orientationChanged()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation))
        {
            createButton(160)
        }
    }
    
    
    func createButton(_ size:CGFloat){
        
        button = UIButton(frame:CGRect(origin: CGPoint(x:self.view.frame.width/1.5, y: self.view.frame.size.height - size), size: CGSize(width: 80, height: 80)))
        let image = UIImage(named: "arrow")
        button.setImage(image, for: .normal)
        self.navigationController?.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(IngredientsTableViewController.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        if ingredients.isEmpty {
            button.isHidden = true
            starterMessage(message: " Please add your Ingredients to start searching for amazing recipes! ", viewController: self,empty:true)
        }else{
            button.isHidden = false
            starterMessage(message: "", viewController: self,empty:false)
        }
    }
    
    func starterMessage(message:String, viewController:UITableViewController,empty:Bool) {
        let messageLabel = UILabel(frame: CGRect(x:0,y:0,width:viewController.view.bounds.size.width,height: viewController.view.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        if empty {
        viewController.tableView.backgroundView = messageLabel;
            viewController.tableView.separatorStyle = .none;
        } else {
            viewController.tableView.backgroundView = UIView();
            viewController.tableView.separatorStyle = .singleLine
            viewController.tableView.tableFooterView?.isHidden = true
            tableView.tableFooterView = UIView()
            
        }
    }
    
    func buttonAction(sender:UIButton) {
        performSegue(withIdentifier: "showRecipes", sender: self)
        
    }
    
    func addIngredientTVCDidCancel(_ controller: AddIngredientTableViewController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func addIngredientTVC(_ controller: AddIngredientTableViewController, didFinishAdding item: Ingredients) {
        let newRowIndex = ingredients.count
        ingredients.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        CoreDataStack.saveContext(managedContext)
        dismiss(animated: true, completion: nil)
    }
    
    func fetchIngredients(){
        let ingrFetch:NSFetchRequest<Ingredients> = Ingredients.fetchRequest()
        managedContext = appDelegate.getContext()
        
        do{
            let results = try managedContext.fetch(ingrFetch)
            
            if results.count > 0{
                for result in results{
                    ingredients.append(result)
                    
                }
                tableView.reloadData()
            }else{
                print("no ingredients added yet")
            }
            
        }catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
  

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.clear
        return header
    }
    

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ingredients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        
        let item = ingredients[indexPath.row]
        cell.textLabel?.text = item.text
        cell.textLabel?.font = UIFont(name: "Palatino", size: 19)
        
        cell.layer.cornerRadius = 10//set corner radius here
        cell.layer.borderColor = UIColor.black.cgColor  // set cell border color here
        cell.layer.borderWidth = 0.8 // set border width here
        
        
        configureCheckmark(for: cell, with: item)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at:  indexPath) {
            
            let item = ingredients[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with:item)
            CoreDataStack.saveContext(managedContext)
            
            
            if item.checked {
                ingredientList = item.text!
               
            }
            print(ingredientList)
        
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configureCheckmark(for cell: UITableViewCell,
                            with item:Ingredients) {
        
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
 
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let ingrToDelete = ingredients[indexPath.row]
        ingredients.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        managedContext.delete(ingrToDelete)
        CoreDataStack.saveContext(managedContext)
        if ingredients.isEmpty {
            button.isHidden = true
            starterMessage(message: " Please add your Ingredients to start searching for amazing recipes! ", viewController: self,empty:true)
        }else{
            button.isHidden = false
        }
        
    }
 
    
    // MARK: - Navigation
    //Tell object B that object A is now its delegate.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddIngredient" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController
                as! AddIngredientTableViewController
            controller.delegate = self
            controller.managedContext = managedContext
        }else if segue.identifier == "showRecipes" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! FoundRecipesCollectionViewController
            //create a separate array of the checked ingredients
            for ingr in ingredients{
                if ingr.checked{
                    print(ingr.text!)
                    checkedIngredients.append(ingr.text!)
                }
                
            }
            //convert them into a string
            ingredientList = checkedIngredients.joined(separator: ",")
            controller.chosenIngredients = ingredientList
                        
        }
    }

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/225
        let newGreen = CGFloat(green)/225
        let newBlue = CGFloat(blue)/225
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
