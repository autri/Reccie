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

    var stepsList = [Step]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSteps()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //MARK: - TableView Datasource Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stepsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    //MARK: - Data Manipulation Methods
    
    func saveStep() {
        do {
            try context.save()
        } catch {
            print("Error saving context. \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadSteps(with request: NSFetchRequest<Step> = Step.fetchRequest()) {
        do {
            stepsList = try context.fetch(request)
        } catch {
            print("Error fetching request. \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - Add New Recipe Steps
    
    
    @IBAction func addStepButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Recipe Step", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Step", style: .default) { (action) in
            // what happens when user taps Add Step button


            let step = Step(context: self.context)
            step.name = textField.text

            print(step.name!)
            self.stepsList.append(step)
            self.tableView.reloadData()

            self.saveStep()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new step"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - TableView Delegate Methods
    
    
}
