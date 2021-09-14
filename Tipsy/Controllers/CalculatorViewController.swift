//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip:String? = "10%"
    var stepperValue:Double = 2
    var finalPay = 0.0
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        tip = sender.currentTitle
        
        switch tip {
        case "0%":
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        case "10%":
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
        case "20%":
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
        default:
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        }
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        stepperValue = sender.value
        splitNumberLabel.text = String(format: "%.0f", stepperValue)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = Double(billTextField.text ?? "0.0") ?? 0
        var tipPercent: Double
        
        if tip == "0%" {
            tipPercent = 0.0
        } else if tip == "10%" {
            tipPercent = 0.1
        } else {
            tipPercent = 0.2
        }
        
        finalPay = ((bill + (bill*tipPercent))/stepperValue)
        
        self.performSegue(withIdentifier: "goToPaymentResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPaymentResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.numberOfPeople = String(format: "%.0f", stepperValue)
            destinationVC.tipPercentage = tip ?? "nil somewhere"
            destinationVC.totalAmount = String(format: "%.2f", finalPay)
        }
    }
    
}
