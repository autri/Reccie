//
//  RecipeAddVC.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/17/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit

class RecipeAddVC: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recipeObj: Recipe? = nil
    
    var recipeName = ""
    var recipeTime = 0
    var recipeServing = 0
    var recipeFavorite = false
    
    var recipeIngredients: [Ingredient]? = nil
    var recipeSteps: [Step]? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recipeNameText(_ sender: UITextField, forEvent event: UIEvent) {
        recipeName = sender.text!
        print(recipeName)
        
    }
    
    @IBAction func recipeTimeText(_ sender: UITextField, forEvent event: UIEvent) {
        recipeTime = Int(sender.text!)!
        print(recipeTime)
    }
    
    @IBAction func recipeServingText(_ sender: UITextField, forEvent event: UIEvent) {
        recipeServing = Int(sender.text!)!
        print(recipeServing)
    }
    
    @IBAction func recipeFavoriteSwitch(_ sender: UISwitch, forEvent event: UIEvent) {
        recipeFavorite = sender.isOn
        print(recipeFavorite)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        recipeObj = Recipe(context: context)
        recipeObj!.name = recipeName
        recipeObj!.time = Int32(recipeTime)
        recipeObj!.serving = Int32(recipeServing)
        recipeObj!.favorite = recipeFavorite
        
        // add ingredients, using foreach
        recipeIngredients?.forEach({ (ingredient) in
            self.recipeObj!.addToIngredients(ingredient)
        })
            
        // add steps, using foreach
        recipeSteps?.forEach({ (step) in
            self.recipeObj!.addToSteps(step)
        })
        
        saveRecipe()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "recipeList", sender: self)
    }
    
    
    func saveRecipe() {
        do {
            try context.save()
        } catch {
            print("Error saving context. \(error)")
        }
        
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? IngredientVC {
            viewController.recipeObj = recipeObj
        }
        
        if let viewController = segue.destination as? StepVC {
            viewController.recipeObj = recipeObj
        }
        
    }

}
