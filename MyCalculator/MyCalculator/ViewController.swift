//
//  ViewController.swift
//  MyCalculator
//
//  Created by Hao WU on 10/29/16.
//  Copyright © 2016 Hao WU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isUserTyping : Bool = false
    var didUserTypeDot : Bool = false
    var calculatorBackend=CalculatorModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TouchDigit(_ sender: UIButton) {
        if(isUserTyping==false){
            DisplayText.text=sender.currentTitle
        }
        else{
            if didUserTypeDot==false || (didUserTypeDot==true && (sender.currentTitle != ".")) {
                DisplayText.text! += sender.currentTitle!
            }
        }
        if(sender.currentTitle == "."){
            didUserTypeDot=true
        }
        isUserTyping=true
        calculatorBackend.setAccumulator(displayValue : DisplayText.text!)
    }
    
    @IBAction func Clear(_ sender: UIButton) {
        calculatorBackend.clear()
        DisplayText!.text=String(0)
    }
    @IBAction func TouchOperation(_ sender: UIButton) {
        if (isUserTyping){
            calculatorBackend.setAccumulator(displayValue: DisplayText.text!)
            isUserTyping=false
        }
        calculatorBackend.performOperation(inputSign: sender.currentTitle!)
        DisplayText.text = String(calculatorBackend.getResult())
        isUserTyping=false
    }
    

    @IBOutlet weak var DisplayText: UILabel!
}

