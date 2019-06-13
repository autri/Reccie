//
//  ViewController.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/11/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit

class RecipeListVC: UITableViewController {

    var recipeList = ["Cake", "Pizza", "Rice"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    //MARK - Tableview Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeItemCell", for: indexPath)
        cell.textLabel?.text = recipeList[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Recipes
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Recipe", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Recipe", style: .default) { (action) in
            // what happens when user taps Add Recipe button
            print(textField.text!)
            self.recipeList.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new recipe"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    

}

