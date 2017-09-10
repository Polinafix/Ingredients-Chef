//
//  FavoriteDetailsViewController.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 09/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class FavoriteDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var time: UILabel!
  //  @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    var minutes:Int?
    
    var array:[String] = []
    var recipe:Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        array = (recipe?.details?.ingredients)! as [String]
        self.textView.text = recipe?.details?.instructions
      //  self.instructions.text = recipe?.details?.instructions
        self.minutes = Int((recipe?.details?.readyInMinutes)!)
        self.time.text = "\(self.minutes!) mins"
        self.imageView.image = UIImage(data: (recipe?.data)! as Data)
        
        tableView.separatorColor = UIColor(red:0.33, green:0.36, blue:0.43, alpha:1.0)
       // instructions.font = UIFont(name: "Palatino", size: 17)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        
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
