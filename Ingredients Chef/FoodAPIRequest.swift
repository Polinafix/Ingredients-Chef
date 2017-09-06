//
//  FoodAPIRequest.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 03/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation
import UIKit


class FoodAPIRequest: NSObject{
    
     static let sharedInstance = FoodAPIRequest()

    func findRecipes(_ ingredientsList:String, _ completionHandler: @escaping(_ result:[Recipe]?,_ error:NSError?) -> Void) {
    
    /* 1. Set the parameters - the required once */
    
    let methodParameters = [Constants.ParameterKeys.FillIngredients : Constants.ParameterValues.FillIngredients, Constants.ParameterKeys.Ingredients : ingredientsList,Constants.ParameterKeys.LimitLicense : Constants.ParameterValues.LimitLicense,Constants.ParameterKeys.Number : Constants.ParameterValues.Number, Constants.ParameterKeys.Ranking:Constants.ParameterValues.Ranking] as [String : Any]
    
    /* 2/3. Build the URL, Configure the request */
    let request = NSMutableURLRequest(url: urlFromParameters(methodParameters as [String:AnyObject], withPathExtension: "/findByIngredients"))
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("ACvWBPBcf2mshImXqGrthiSO9p2dp1B1SUajsnc62mal2cISWC", forHTTPHeaderField: "X-Mashape-Key")
    /* 4. Make the request */
    let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
        
        //if an error occurs, print it and re-enable the UI
        func displayError(_ error: String){
            print(error)
            performUIUpdatesOnMain {
                print("Error")
            }
        }
        
        //was there an error?
        guard (error == nil) else{
            displayError("There was an error with your request: \(error)")
            return
        }
        //Did we get a successful 2xx response?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            displayError("Your request returned a status code other than 2xx!")
            return
        }
        
        //was there any data returned?
        guard let data = data else{
            displayError("No data was returned by the request")
            return
        }
        
        /* 5. Parse the data */
        let parsedResult:[[String:AnyObject]]
        do{
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:AnyObject]]
        }catch{
            displayError("Unable to parse the data as JSON")
            
            return
        }
        
        var arrayOfRecipes = [Recipe]()
        //var arrayOfTitles = [String]()
        
            for recipe in parsedResult {
                
                guard let recipeId = recipe["id"] as? Int else {
                    print("Cannot find key id in \(parsedResult)")
                    return
                }
                guard let recipeName = recipe["title"] as? String else {
                    print("Cannot find key title in \(parsedResult)")
                    return
                }
                guard let urlString = recipe["image"] as? String else {
                    print("Cannot find key image in \(parsedResult)")
                    return
                }
                
                
                
                let recipe = Recipe(id: recipeId, title: recipeName, imageURL: urlString)
                arrayOfRecipes.append(recipe)
               
            }
        
        completionHandler(arrayOfRecipes,nil)
  
    }
    
    
    
    
    /* 7. Start the request */
    task.resume()
}
    
    func showDetailedRecipe(_ id:Int, _ completionHandler: @escaping(_ result:DetailedRecipe,_ error:NSError?) -> Void){
        
        /* 1. Set the parameters - the required once */
        
        let methodParameters = [Constants.ParameterKeys.IncludeNutrition:false] as [String : Any]
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: urlFromParameters(methodParameters as [String:AnyObject], withPathExtension: "/\(id)/information"))
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("ACvWBPBcf2mshImXqGrthiSO9p2dp1B1SUajsnc62mal2cISWC", forHTTPHeaderField: "X-Mashape-Key")
        
        /* 4. Make the request */
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            //if an error occurs, print it and re-enable the UI
            func displayError(_ error: String){
                print(error)
                performUIUpdatesOnMain {
                    print("Error")
                }
            }
            
            //was there an error?
            guard (error == nil) else{
                displayError("There was an error with your request: \(error)")
                return
            }
            //Did we get a successful 2xx response?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            //was there any data returned?
            guard let data = data else{
                displayError("No data was returned by the request")
                return
            }
            
            /* 5. Parse the data */
            let parsedResult:[String:AnyObject]
            do{
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            }catch{
                displayError("Unable to parse the data as JSON")
                
                return
            }
            
            var listOfIngr:[String] = [String]()
            
            //get the photos Dictionary at the "photos" key
            if let ingrArray = parsedResult["extendedIngredients"] as? [[String:AnyObject]]{
                for ingr in ingrArray {
                    guard let fullIngr = ingr["originalString"] as? String else{
                        print("Cannot find key originalString in \(ingr)")
                        return
                    }
                    listOfIngr.append(fullIngr)
                }
            }
            guard let readyIn = parsedResult["readyInMinutes"] as? Int else {
                print("Cannot find key readyInMinutes in \(parsedResult)")
                return
            }
            guard let instructions = parsedResult["instructions"] as? String else {
                print("Cannot find key instructions in \(parsedResult)")
                return
            }
            
            let detailedRecipe = DetailedRecipe(ingredients: listOfIngr, readyInMinutes: readyIn, instructions: instructions)
            
            
            completionHandler(detailedRecipe, nil)
            

        }
        
        /* 7. Start the request */
        task.resume()
        
        
    }
    
    func fromUrlToData(_ url: String, _ completionHandler:@escaping (_ recipeData: Data?,_ error: String?) -> Void){
        
        if let url = URL(string: url){
            let request = URLRequest(url:url)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil{
                    completionHandler(data, nil)
                }else{
                    completionHandler(nil, error?.localizedDescription)
                }
            })
            task.resume()
        }
    }


    
    func urlFromParameters(_ parameters: [String:AnyObject],withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.Spoonacular.ApiScheme
        components.host = Constants.Spoonacular.ApiHost
        components.path = Constants.Spoonacular.ApiPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
}
