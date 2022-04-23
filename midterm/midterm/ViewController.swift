//
//  ViewController.swift
//  midterm
//
//  Created by ming on 23/4/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let colors = [
        "color1": UIColor(rgb: 0xE6BA95),
        "color2": UIColor(rgb: 0xFAFDD6),
        "color3": UIColor(rgb: 0xE4E9BE),
        "color4": UIColor(rgb: 0xA2B38B),
        "color5": UIColor(rgb: 0x789395),
        "color6":  UIColor(rgb: 0xFBF8F1),
        "blackish": UIColor(rgb: 0x2D2D2B),
    ]
    
    let operators = CharacterSet(["+", "-", "*", "/", "%"])
    
    @IBOutlet weak var additionalLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operationButtons: [UIButton]!
    @IBOutlet var specialButtons: [UIButton]!
    @IBOutlet weak var clearButton: UIButton!
    
    var currentOperation: String = ""
    var additional: String = "" {
        didSet {
            self.additionalLabel.text = additional
        }
    }
    
    var answer: String = "" {
        didSet {
            self.answerLabel.text = answer
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = colors["color6"]
        additionalLabel.textColor = colors["blackish"]
        answerLabel.textColor = colors["blackish"]
        
        for numberButton in numberButtons {
            numberButton.backgroundColor = colors["color4"]
            numberButton.setTitleColor(colors["color2"], for: .normal)
            numberButton.titleLabel?.font = .systemFont(ofSize: numberButton.frame.height/2)
            numberButton.layer.cornerRadius = numberButton.frame.height/2
        }
        
        for operationButton in operationButtons {
            operationButton.backgroundColor = colors["color1"]
            operationButton.setTitleColor(colors["color2"], for: .normal)
            operationButton.titleLabel?.font = .systemFont(ofSize: operationButton.frame.height/2)
            operationButton.layer.cornerRadius = operationButton.frame.height/2
        }
        
        for specialButton in specialButtons {
            specialButton.backgroundColor = colors["color3"]
            specialButton.setTitleColor(colors["color5"], for: .normal)
            specialButton.titleLabel?.font = .systemFont(ofSize: specialButton.frame.height/2)
            specialButton.layer.cornerRadius = specialButton.frame.height/2
        }
        
        additional = ""
        answer = "0"
    }
    
    @IBAction func onClearButtonClick(_ sender: UIButton) {
        if sender.currentTitle == "AC" {
            additional = ""
            answer = "0"
            currentOperation = ""
            
        } else  if sender.currentTitle == "C" {
            answer = "0"
            
            for char in additional.reversed() {
                if String(char).rangeOfCharacter(from: operators) != nil {
                    break
                }
                additional = String(additional.dropLast())
            }
            
            if let lastChar = additional.last {
                currentOperation = String(lastChar)
            }
            
            if answer == "" || answer == "-" {
                answer = "0"
            }
        }
    
        updateOperationButtonsColor()
        updateClearButton()
    }
    
    @IBAction func onNumberButtonClick(_ sender: UIButton) {
        if let number = sender.currentTitle {
            if additional == "" && number == "0" {
                return
            }
 
            currentOperation = ""
            additional += number
            
            if answer == "0" {
                answer = number
            } else {
                answer += number
            }
        }
        
        updateOperationButtonsColor()
        updateClearButton()
    }
    
    @IBAction func onOperationButtonClick(_ sender: UIButton) {
        if additional == "" {
            additional = "0"
        }
        
        if let operation = sender.currentTitle {
            if currentOperation.rangeOfCharacter(from: operators) != nil {
                additional = String(additional.dropLast())
            }
                
            currentOperation = operation
            additional += operation
            answer = "0"
        }
        
        updateOperationButtonsColor()
    }
    
    @IBAction func onDotButtonClick(_ sender: UIButton) {
        if additional.last == "." {
            return
        }
        
        if additional == "" {
            additional = "0"
        }
        
        if let dot = sender.currentTitle {
            currentOperation = ""
            additional += dot
            answer += dot
        }
        
        updateOperationButtonsColor()
    }
    
    @IBAction func onEqualButtonClick(_ sender: UIButton) {
        let formula = additional.replacingOccurrences(of: "%", with: "/100.0")
        
        var expression: NSExpression?
        
        if formula.rangeOfCharacter(from: CharacterSet(["."])) != nil {
            expression = NSExpression(format: formula)
        } else {
            expression = NSExpression(format: formula+".0")
        }
        
        let ans = expression?.expressionValue(with: nil, context: nil) as! Double
        answer = ans.trimAndStringify
        
        clearButton.setTitle("AC", for: .normal)
    }
    
    func updateOperationButtonsColor() {
        for operationButton in operationButtons {
            if operationButton.currentTitle == currentOperation {
                operationButton.backgroundColor = colors["color2"]
                operationButton.setTitleColor(colors["color1"], for: .normal)
            } else {
                operationButton.backgroundColor = colors["color1"]
                operationButton.setTitleColor(colors["color2"], for: .normal)
            }
        }
    }
    
    func updateClearButton() {
        if additional == "" || String(additional.last!).rangeOfCharacter(from: operators) != nil {
            clearButton.setTitle("AC", for: .normal)
        } else {
            clearButton.setTitle("C", for: .normal)
        }
    }
}

