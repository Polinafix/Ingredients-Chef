//
//  AddIngredientTableViewController.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 01/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit
import CoreData

//protocol
protocol AddIngredientTVCDelegate: class {
    func addIngredientTVCDidCancel(_ controller: AddIngredientTableViewController)
    func addIngredientTVC(_ controller: AddIngredientTableViewController,
                               didFinishAdding item: Ingredients)
}

class AddIngredientTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    weak var delegate: AddIngredientTVCDelegate?
    var managedContext: NSManagedObjectContext!
    @IBOutlet weak var staticCell: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        staticCell.layer.borderColor = UIColor.black.cgColor  // set cell border color here
        staticCell.layer.borderWidth = 1.5 // set border width here
        staticCell.layer.cornerRadius = 20
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        delegate?.addIngredientTVCDidCancel(self)
    }
    
   
    
    @IBAction func doneAdding(_ sender: UIBarButtonItem) {
        
        let ingr = Ingredients(textField.text!, true, context: managedContext)
        delegate?.addIngredientTVC(self, didFinishAdding: ingr)

    }
    //disable the done bar button if the text field is empty
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string)
            as NSString
        doneButton.isEnabled = (newText.length > 0)
        return true
    }
   
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
   


}
