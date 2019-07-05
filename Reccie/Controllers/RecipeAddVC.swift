//
//  RecipeAddVC.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/17/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit
import CoreData

class RecipeAddVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var recipePhoto: UIImageView!
    @IBOutlet weak var recipeNamePlaceholder: UITextField!
    @IBOutlet weak var recipeTimePlaceholder: UITextField!
    @IBOutlet weak var recipeServingPlaceholder: UITextField!
    @IBOutlet weak var recipeFavoritePlaceholder: UISwitch!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recipeObj: Recipe?
    
    var recipeName: String?
    var recipeTime = 0
    var recipeServing = 0
    var recipeFavorite = false
    
    var recipeIngredients: [Ingredient]?
    var recipeSteps: [Step]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadRecipe()
        
        recipeNamePlaceholder.text = recipeObj?.name
        recipeSteps = recipeObj?.steps?.allObjects as? [Step]
        recipeIngredients = recipeObj?.ingredients?.allObjects as? [Ingredient]
        
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        
        
        // Do any additional setup after loading the view.
        if recipeObj?.serving != 0 {
            recipeServingPlaceholder.text = String(recipeObj!.serving)
            recipeServing = Int(recipeObj!.serving)
        }
        
        if recipeObj?.time != 0 {
            recipeTimePlaceholder.text = String(recipeObj!.time)
            recipeTime = Int(recipeObj!.time)
        }
        
        recipeFavoritePlaceholder.isOn = (recipeObj?.favorite)!
        recipeFavorite = recipeObj!.favorite
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        recipePhoto.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    


    //MARK: - Actions
    @IBAction func selectRecipeImage(_ sender: UITapGestureRecognizer) {
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.sourceType = .camera
        
        // Make sure RecipeAddVC is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func recipeNameText(_ sender: UITextField, forEvent event: UIEvent) {
        if let name = sender.text {
            recipeName = name
        } else {
            print("Name not found. Name is required. Give name.")
        }
        
        print("From recipe name IBAction \(recipeName)")
        
    }
    
    @IBAction func recipeTimeText(_ sender: UITextField, forEvent event: UIEvent) {
        if let time = Int(sender.text ?? "") {
            recipeTime = time
        } else {
            print("Recipe time not found")
        }
        print(recipeTime)
    }
    
    @IBAction func recipeServingText(_ sender: UITextField, forEvent event: UIEvent) {
        if let serving = Int(sender.text ?? "") {
            recipeServing = serving
        } else {
            print("Recipe serving not found")
        }
        print(recipeServing)
    }
    
    @IBAction func recipeFavoriteSwitch(_ sender: UISwitch, forEvent event: UIEvent) {
        recipeFavorite = sender.isOn
        print(recipeFavorite)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        saveRecipe()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        // add method to delete the recipe object
        deleteRecipe()
        performSegue(withIdentifier: "recipeList", sender: self)
    }
    
    //MARK: - Model Manipulation
    func saveRecipe() {
        // user never interacted with recipe name field, so don't set the name to nil
        if recipeName != nil {
            recipeObj?.name = recipeName
        }
        
        if recipeTime != nil {
            recipeObj!.time = Int32(recipeTime)
        }
        if recipeServing != nil {
            recipeObj!.serving = Int32(recipeServing)
        }
        if recipeFavorite != nil {
            recipeObj!.favorite = recipeFavorite
        }
        
        
        
        do {
            try context.save()
        } catch {
            print("Error saving context. \(error)")
        }
    }
    
    func deleteRecipe() {
        if let deletedRecipe = recipeObj {
            context.delete(deletedRecipe)
            saveRecipe()
        }
    }
    
    // consider removing if not used
    func loadRecipe(with request: NSFetchRequest<Recipe> = Recipe.fetchRequest()) {
        do {
            let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: context)
            var recipe = NSManagedObject(entity: entity!, insertInto: context)
            
            var recipes: [Recipe] = []
            recipes = try context.fetch(request)
            recipe = recipes.last!
            recipeObj = context.object(with: recipe.objectID) as? Recipe
            
        } catch {
            print("Error fetching request. \(error)")
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? IngredientVC {
            saveRecipe()
            viewController.recipeObj = recipeObj
            if let ingredients = recipeIngredients {
                viewController.ingredientList = ingredients
            }
        }
        
        if let viewController = segue.destination as? StepVC {
            saveRecipe()
            viewController.recipeObj = recipeObj
            if let steps = recipeSteps {
                viewController.stepsList = steps
            }
        }
        
    }

}
