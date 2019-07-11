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
    var editDelete = false
    var editSyle = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isEditing = true
        
        loadSteps()
        

        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath) as? StepsTableViewCell else {
            fatalError("The dequeued cell is not an instance of StepCell.")
        }
        
        cell.stepNameOutlet.text = stepsList[indexPath.row].name
        cell.orderOutlet.text = String(stepsList[indexPath.row].order) + "."

        return cell
    }
 
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteStep(step: stepsList[indexPath.row])
        stepsList.remove(at: indexPath.row)
        
        for step in stepsList {
            if let index = stepsList.index(of: step) {
                step.order = Int16(index) + 1
            }
        }
        
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if editSyle == 1 {
            return .none
        } else if editSyle == 2 {
            return .delete
        } else if editSyle == 3 {
            return .insert
        }
        return .none
    }
    
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return editDelete
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedObject = self.stepsList[fromIndexPath.row]
        stepsList.remove(at: fromIndexPath.row)
        stepsList.insert(movedObject, at: to.row)
        
        tableView.reloadData()
    }
    

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
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
    
    func deleteStep (step: Step) {
        recipeObj?.removeFromSteps(step)
        context.delete(step)
        saveSteps()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? RecipeEditVC {
            saveSteps()
            viewController.recipeSteps = stepsList
            viewController.recipeObj = recipeObj
        }
    }
    
    //MARK:- Action Items
    
    @IBAction func deleteItems(_ sender: UIBarButtonItem) {
        editDelete = !editDelete
        if editSyle == 1 {
            editSyle = 2
        } else if editSyle == 2 {
            editSyle = 1
        } else if editSyle == 3 {
            editSyle = 1
        }
        tableView.reloadData()
    }
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        for step in stepsList {
            if step.name == "" {
                if let index = stepsList.index(of: step) {
                    stepsList.remove(at: index)
                }
            }
        }
        performSegue(withIdentifier: "stepsToAddRecipe", sender: self)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Recipe Step", message: "", preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add Step", style: .default) { (action) in
            // what happens when user taps Add Step button


            let step = Step(context: self.context)
            step.name = textField.text

            print(step.name!)
            self.stepsList.append(step)
            step.order = Int16(self.stepsList.count)
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
