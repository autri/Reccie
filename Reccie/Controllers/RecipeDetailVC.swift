//
//  RecipeDetailVC.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/17/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit

class RecipeDetailVC: UIViewController {
    
    //MARK: - Properties
    
    var recipeObj: Recipe? = nil
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTimeMins: UILabel!
    @IBOutlet weak var recipeServing: UILabel!
    @IBOutlet weak var recipeFavorite: UILabel!
    
    @IBOutlet weak var recipeIngredients: UITextView!
    @IBOutlet weak var recipeSteps: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        recipeIngredients.isEditable = false
        recipeSteps.isEditable = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recipeIngredients.contentOffset = .zero
        recipeSteps.contentOffset = .zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let name = recipeObj?.name {
            recipeName.text = name
        }
        if let time = recipeObj?.time {
            recipeTimeMins.text = String(time) + (time == 1 ? " minute" : " minutes")
        }
        if let serving = recipeObj?.serving {
            recipeServing.text = String(serving) + (serving == 1 ? " serving" : " servings")
        }
        if let favorite = recipeObj?.favorite {
            recipeFavorite.text = "Favorite Status: " + String(favorite)
        }
        
        if let steps = recipeObj?.steps?.allObjects as? [Step] {
            var stepsString = ""
            for step in steps {
                stepsString += "\(step.name!) \n"
            }
            recipeSteps.text = stepsString
        }
        
        if let ingredients = recipeObj?.ingredients?.allObjects as? [Ingredient] {
            var ingredientsString = ""
            for ingredient in ingredients {
                ingredientsString += "\(ingredient.name!) \n"
            }
            recipeIngredients.text = ingredientsString
        }
    }

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
