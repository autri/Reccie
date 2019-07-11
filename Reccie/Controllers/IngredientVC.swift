//
//  IngredientVC.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/17/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit
import CoreData

enum IngredientTextFields: Int {
    case Amount = 0,
    UOM,
    Name
}

class IngredientVC: UITableViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    
    public var ingredientList = [Ingredient]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recipeObj: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadIngredients()
        

        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as? IngredientsTableViewCell else {
            fatalError("The dequeued cell is not an instance of IngredientCell.")
        }
        
        cell.amountOulet.placeholder = "2.5"
        if ingredientList[indexPath.row].amount != 0.0 {
            cell.amountOulet.text = String(ingredientList[indexPath.row].amount)
        }
        cell.amountOulet.tag = 0
        
        cell.uomOutlet.placeholder = "cups"
        cell.uomOutlet.inputView = cell.picker
        cell.uomOutlet.text = ingredientList[indexPath.row].uom
        cell.uomOutlet.tag = 1
        
        cell.nameOutlet.placeholder = "almonds, chopped"
        cell.nameOutlet.text = ingredientList[indexPath.row].name
        cell.nameOutlet.tag = 2

        return cell
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 0:
            if let amount = textField.text {
                if Double(amount) == nil {
                    return false
                }
                ingredientList[ingredientList.count - 1].amount = Double(amount) as! Double
            }
            break
        case 1:
            if let uom = textField.text {
                ingredientList[ingredientList.count - 1].uom = uom
            }
            break
        case 2:
            if let name = textField.text {
                ingredientList[ingredientList.count - 1].name = name
            }
            break
        default:
            return true
        }
        
        return true
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text! + " DID")
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteIngredient(ingredient: ingredientList[indexPath.row])
        ingredientList.remove(at: indexPath.row)
        tableView.reloadData()
    }

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
    
    func deleteIngredient(ingredient: Ingredient) {
        recipeObj?.removeFromIngredients(ingredient)
        context.delete(ingredient)
        saveIngredients()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? RecipeEditVC {
            saveIngredients()
            viewController.recipeIngredients = ingredientList
            viewController.recipeObj = recipeObj
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {

        for ingredient in ingredientList {
            if ingredient.uom == nil  || ingredient.amount == 0.0 || ingredient.name == "" {
                if let index = ingredientList.index(of: ingredient) {
                    ingredientList.remove(at: index)
                }
            }
            
        }
        
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
