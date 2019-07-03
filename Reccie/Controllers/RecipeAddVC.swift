//
//  RecipeAddVC.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/17/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit

class RecipeAddVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var recipePhoto: UIImageView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recipeObj: Recipe? = nil
    
    var recipeName = ""
    var recipeTime = 0
    var recipeServing = 0
    var recipeFavorite = false
    
    var recipeIngredients: [Ingredient]? = nil
    var recipeSteps: [Step]? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        
        
        // Do any additional setup after loading the view.
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
        print(recipeName)
        
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
        recipeObj = Recipe(context: context)
        recipeObj!.name = recipeName
        recipeObj!.time = Int32(recipeTime)
        recipeObj!.serving = Int32(recipeServing)
        recipeObj!.favorite = recipeFavorite
        
        print(recipeIngredients?[0].name)
        
        saveRecipe()
        
//        recipeIngredients?[0].parentRecipe = recipeObj
//        // add ingredients, using foreach
//        recipeIngredients?.forEach({ (ingredient) in
//            self.recipeObj!.addToIngredients(ingredient)
//        })
//
//        // add steps, using foreach
//        recipeSteps?.forEach({ (step) in
//            self.recipeObj!.addToSteps(step)
//        })
//
//        saveRecipe()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "recipeList", sender: self)
    }
    
    
    func saveRecipe() {
        do {
            try context.save()
        } catch {
            print("Error saving context. \(error)")
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? IngredientVC {
            viewController.recipeObj = recipeObj
        }
        
        if let viewController = segue.destination as? StepVC {
            viewController.recipeObj = recipeObj
        }
        
    }

}
