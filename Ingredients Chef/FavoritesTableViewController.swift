//
//  FavoritesTableViewController.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 06/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit



class FavoritesTableViewController: UITableViewController {
    
    var favorites:[String] = ["cat","dog"]
    var favString:String = ""
    var favs:[DetailedRecipe]?
    var anotherView:RecipeDetailsViewController?
    
    override func viewWillAppear(_ animated: Bool) {
        //anotherView?.delegate = self
        favorites.append(favString)
        print(favString)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  favorites?.append("cart")
      //  favorites?.append("dog")
        
        
        
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

   /* func addToFavorites(_ controller: RecipeDetailsViewController, didFinishAdding recipe: DetailedRecipe) {
        let newRowIndex = favorites?.count
        favorites?.append("hhhhgh")
        let indexPath = IndexPath(row: newRowIndex!, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }*/

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (favorites.count)
       // return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath)
        
        let item = favorites[indexPath.row]
        cell.textLabel?.text = item
        
        /*let item = favs?[indexPath.row]
        cell.textLabel?.text = item?.name
        let minutes = String(describing: item?.readyInMinutes)
        cell.detailTextLabel?.text = minutes + "min"*/
        //cell.imageView?.image\
        //cell.textLabel?.text = "gggg"
        

        

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
