//
//  RecipeAddVC.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/17/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit

class RecipeAddVC: UIViewController {
    
    var recipeObj = Recipe()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var recipeName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recipeNameText(_ sender: UITextField, forEvent event: UIEvent) {
        recipeName = sender.text!
    }
    
    @IBAction func recipeTimeText(_ sender: UITextField, forEvent event: UIEvent) {
    }
    
    @IBAction func recipeServingText(_ sender: UITextField, forEvent event: UIEvent) {
    }
    
    @IBAction func recipeFavoriteSwitch(_ sender: UISwitch, forEvent event: UIEvent) {
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        recipeObj.name = recipeName
        saveRecipe()
    }
    
    func saveRecipe() {
        do {
            try context.save()
        } catch {
            print("Error saving context. \(error)")
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
