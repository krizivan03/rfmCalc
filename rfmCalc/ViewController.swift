//
//  ViewController.swift
//  rfmCalc
//
//  Created by Christopher Canales on 3/5/20.
//  Copyright © 2020 Christopher Canales. All rights reserved.
//

import UIKit 

class ViewController: UIViewController {
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var waistInput: UITextField!
    @IBOutlet weak var genderInput: UITextField!
    @IBOutlet weak var rfmResult: UILabel!
    @IBOutlet weak var rfmDiagnosis: UILabel!
    
    let genders = ["m","f"]
    

    @IBAction func calcButton(_ sender: Any) {
        
        if Int(heightInput.text!) == nil {
            rfmDiagnosis.textColor = UIColor.red
            rfmDiagnosis.adjustsFontSizeToFitWidth = true
            rfmDiagnosis.text = "Height must be number"
            rfmDiagnosis.isHidden = false
        }
        else if Int(waistInput.text!) == nil{
            rfmDiagnosis.textColor = UIColor.red
            rfmDiagnosis.adjustsFontSizeToFitWidth = true
            rfmDiagnosis.text = "Waist must be number"
            rfmDiagnosis.isHidden = false
        }
        else if !genders.contains(genderInput.text!.lowercased()){
            rfmDiagnosis.textColor = UIColor.red
            rfmDiagnosis.adjustsFontSizeToFitWidth = true
            rfmDiagnosis.text = "Gender must be binary"
            rfmDiagnosis.isHidden = false
        }
        else{
            var genNum: Double
            genNum = 0.0
            if genderInput.text!.lowercased() == "f" {
                genNum = 12.0;
            }
            let height = Double(heightInput.text!)
            let waist = Double(waistInput.text!)
            
            let rfm = (64-20*(height!/waist!))+genNum
            rfmResult.text = "\(rfm)"
//            RFM: 64-(20 x (63/34))+(12 x 1) = 38.9
//            let rfm = 64.0- (20.0 * (height!/waist!)) + (12.0*1.0)
            
            rfmResult.isHidden = false
            rfmDiagnosis.isHidden = false
            if genNum == 0.0 { // if male
                switch rfm {
                case 0 ... 8:
                    rfmDiagnosis.text = "You are Underfat"
                    rfmDiagnosis.textColor = UIColor.blue
                    rfmDiagnosis.adjustsFontSizeToFitWidth = true
                case 8 ... 19:
                    rfmDiagnosis.text = "You are Healthy"
                    rfmDiagnosis.textColor = UIColor.green
                    rfmDiagnosis.adjustsFontSizeToFitWidth = true
                case 19 ... 25:
                    rfmDiagnosis.text = "You are Overfat"
                    rfmDiagnosis.textColor = UIColor.yellow
                    rfmDiagnosis.adjustsFontSizeToFitWidth = true
                case 25 ... 50 :
                    rfmDiagnosis.text = "You are Obese"
                    rfmDiagnosis.textColor = UIColor.red
                    rfmDiagnosis.adjustsFontSizeToFitWidth = true
                default:
                    rfmDiagnosis.text = "Please ensure your Height, Waist and Gender info is correct"
                    rfmDiagnosis.textColor = UIColor.red
                }
            }
            else{// if female
                switch rfm {
                case 0 ... 21:
                    rfmDiagnosis.text = "You are Underfat"
                    rfmDiagnosis.textColor = UIColor.blue
                    rfmDiagnosis.adjustsFontSizeToFitWidth = true
                case 21 ... 33:
                    rfmDiagnosis.text = "You are Healthy"
                    rfmDiagnosis.textColor = UIColor.green
                    rfmDiagnosis.adjustsFontSizeToFitWidth = true
                case 33 ... 39:
                    rfmDiagnosis.text = "You are Overfat"
                    rfmDiagnosis.textColor = UIColor.yellow
                    rfmDiagnosis.adjustsFontSizeToFitWidth = true
                case 39 ... 50 :
                    rfmDiagnosis.text = "You are Obese"
                    rfmDiagnosis.textColor = UIColor.red
                    rfmDiagnosis.adjustsFontSizeToFitWidth = true
                default:
                    rfmDiagnosis.text = "Please ensure your Height, Waist and Gender info is correct"
                    rfmDiagnosis.textColor = UIColor.red
                }
            }
            
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rfmResult.isHidden = true
        rfmDiagnosis.isHidden = true
        heightInput.addDoneButtonOnKeyboard()
        waistInput.addDoneButtonOnKeyboard()
        genderInput.addDoneButtonOnKeyboard()
       
    }

}
// ------------------EXTENSION------------------------//
extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
