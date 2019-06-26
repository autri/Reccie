//
//  RecipeDetailVC.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/17/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit

class RecipeDetailVC: UIViewController {
    
    
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
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        recipeName.text = recipeObj!.name
        recipeTimeMins.text = String(recipeObj!.time) + " minutes"
        recipeServing.text = String(recipeObj!.serving) + " servings"
        recipeFavorite.text = "Favorite Status: " + (recipeObj!.favorite ? "True" : "False")

        recipeIngredients.text = recipeObj?.ingredients?.value(forKey: "name") as? String
        recipeSteps.text = recipeObj?.steps?.value(forKey: "name") as? String
        
//        // add ingredients, using foreach
//        recipeIngredients?.forEach({ (ingredient) in
//            self.recipeObj!.addToIngredients(ingredient)
//        })
//
//        // add steps, using foreach
//        recipeSteps?.forEach({ (step) in
//            self.recipeObj!.addToSteps(step)
//        })
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
