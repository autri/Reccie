//
//  StepVC.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/16/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit
import CoreData

class StepVC: UITableViewController {
    
    //MARK: - Properties
    var stepsList = [Step]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recipeObj: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSteps()
        
        


        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

    }

    //MARK: - TableView Datasource Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stepsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath)
        cell.textLabel?.text = stepsList[indexPath.row].name
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
    
    
    //MARK: - Data Manipulation Methods
    func loadSteps() {
        tableView.reloadData()
    }
    
    func saveSteps() {
        for step in stepsList {
            recipeObj?.addToSteps(step)
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
            saveSteps()
            viewController.recipeSteps = stepsList
            viewController.recipeObj = recipeObj
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "stepsToAddRecipe", sender: self)
    }
    
    
    //MARK: - Add New Recipe Steps
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Recipe Step", message: "", preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add Step", style: .default) { (action) in
            // what happens when user taps Add Step button
            
            
            let step = Step(context: self.context)
            step.name = textField.text
            
            print(step.name!)
            self.stepsList.append(step)
            self.tableView.reloadData()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            self.tableView.reloadData()
        }
        actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.view.tintColor = UIColor.init(red: 0.0, green: 0.569, blue: 0.576, alpha: 1.0)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new step"
            textField = alertTextField
        }
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
}
