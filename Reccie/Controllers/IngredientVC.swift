//
//  IngredientVC.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/17/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit
import CoreData

class IngredientVC: UITableViewController {
    
    //MARK: - Properties
    
    var ingredientList = [Ingredient]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recipeObj: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadIngredients()
        

        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ingredientList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = ingredientList[indexPath.row].name
        cell.accessoryType = .detailButton
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    
    // MARK: - Model Manipulation Methods
    func loadIngredients() {
        tableView.reloadData()
    }

    func saveIngredients() {
        for ingredient in ingredientList {
            recipeObj?.addToIngredients(ingredient)
        }
        do {
            try context.save()
        } catch {
            print("Error saving context. \(error)")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? RecipeAddVC {
            saveIngredients()
            viewController.recipeIngredients = ingredientList
            viewController.recipeObj = recipeObj
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ingredientsToAddRecipe", sender: self)
    }
    

    //MARK: - Add New Recipe Ingredients
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Recipe Ingredient", message: "", preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add Ingredient", style: .default) { (action) in
            
            // what happens when user taps Add Ingredient button
            let ingredient = Ingredient(context: self.context)
            ingredient.setValue(textField.text, forKey: "name")
            
            print(ingredient.name!)
            self.ingredientList.append(ingredient)
            self.tableView.reloadData()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            self.tableView.reloadData()
        }
        actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.view.tintColor = UIColor.init(red: 0.0, green: 0.569, blue: 0.576, alpha: 1.0)
        alert.view.action
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new ingredient"
            textField = alertTextField
        }
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
}
