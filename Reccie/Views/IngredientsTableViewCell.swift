//
//  IngredientsTableViewCell.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 7/7/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    //MARK:- Properties
    @IBOutlet weak var amountOulet: UITextField!
    @IBOutlet weak var uomOutlet: UITextField!
    @IBOutlet weak var nameOutlet: UITextField!
    
    var ingredientObj: Ingredient?
    
    var uomArray: [String] = ["", "oz", "tbspn", "cups"]
    let picker = UIPickerView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Actions
    @IBAction func amount(_ sender: UITextField, forEvent event: UIEvent) {
        if let amount = sender.text {
            if (Double(amount) != nil) {
                ingredientObj?.amount = Double(amount)!
            }
        }
    }
    @IBAction func uom(_ sender: UITextField, forEvent event: UIEvent) {
        if let uom = sender.text {
            ingredientObj?.uom = uom
        }
    }
    @IBAction func nameIngredient(_ sender: UITextField, forEvent event: UIEvent) {
        if let name = sender.text {
            ingredientObj?.name = name
        }
    }
    
    //MARK:- UIPickerView Delegation
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uomArray.count
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uomArray[row]
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        uomOutlet.text = uomArray[row]
    }
}
