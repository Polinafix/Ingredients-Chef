//
//  FoundRecipesCollectionViewController.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 02/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FoundRecipesCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var recipesArray:[Recipe] = [Recipe]()
    var chosenIngredients:String = "" 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRecipes()
        
        collectionView!.contentInset = UIEdgeInsets(top: 15, left: 40, bottom: 15, right: 40)
        
        

        /*let space:CGFloat = 8.0
        let dimension = (view.frame.size.width - (2 * space)) / 2.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)*/
    }

    //downloading images from Flickr
    func loadRecipes(){
        
        FoodAPIRequest.sharedInstance.findRecipes { (results, error) in
            
            if error ==  nil{
                performUIUpdatesOnMain {
                    if (results?.count)! > 0{
                        
                        self.recipesArray = results!
                        print("\(self.recipesArray.count) photos from ... fetched")
                        self.collectionView?.reloadData()
                        
                    }else{
                       print("no photos for this location")
                    }
                }
            }else{
                print("couldn't get photos from flickr")
            }
        }
  
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
   

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return recipesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RecipeCell
        
        let recipe = recipesArray[indexPath.row]
        cell?.imageView.image = UIImage(named: "default")
        cell?.recipeName.text = "Loading"
        cell?.activityIndicator.startAnimating()
        
        if recipe.data != nil{
            performUIUpdatesOnMain {
                cell?.activityIndicator.stopAnimating()
                cell?.activityIndicator.hidesWhenStopped = true
            }
            cell?.imageView.image = UIImage(data: recipe.data!)
        }else{
            FoodAPIRequest.sharedInstance.fromUrlToData(recipe.imageURL, { (returnedData, error) in
                
                if let recipeData = returnedData{
                    performUIUpdatesOnMain {
                        recipe.data = recipeData
                        cell?.imageView.image = UIImage(data: recipe.data!)
                        cell?.recipeName.text = recipe.title
                        cell?.activityIndicator.stopAnimating()
                        cell?.activityIndicator.hidesWhenStopped = true
                        
                    }
                }else{
                    print("Data error: \(error)")
                }
            })
        }
    
        // Configure the cell
    
        return cell!
    }

    // MARK: UICollectionViewDelegate



}
