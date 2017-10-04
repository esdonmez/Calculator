//
//  ViewController.swift
//  Calculator
//
//  Created by Onur Celik on 30/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    var firstNumberText: String = ""
    var secondNumberText: String = ""
    
    var operatorText: String = ""
    var isOperatorClicked: Bool = false
    var isFirstNumber: Bool = true
    var canClear: Bool = true
    var isError: Bool = false
    var currentText: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        resultLabel.text = "0"
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func handleButtonClick(_ sender: UIButton) {
        if canClear {
            resultLabel.text = ""
            canClear = false
        }
        
        currentText = resultLabel.text!
        let textLabel = sender.titleLabel?.text
        
        if let text = textLabel {
            switch text {
            case "÷", "×", "-", "+":
                if (firstNumberText == "") {
                    firstNumberText = "0"
                    resultLabel.text = firstNumberText
                }
                
                if (secondNumberText != "") {
                    let result = calculate()
                    firstNumberText = String(result)
                    let lastTwo = firstNumberText.suffix(2)
                    if (lastTwo == ".0") {
                        let endIndex = firstNumberText.index(firstNumberText.endIndex, offsetBy: -2)
                        let truncated = firstNumberText.prefix(upTo: endIndex)
                        resultLabel.text = String(truncated)
                    } else {
                        resultLabel.text = firstNumberText
                    }
                }
                
                if isOperatorClicked {
                    return
                }
                operatorText = text
                isFirstNumber = false
                isOperatorClicked = true
                break
            case "=":
                if (firstNumberText != "" && secondNumberText != "") {
                    isFirstNumber = true
                    isOperatorClicked = false
                    canClear = true
                    if isError {
                        let result = "Error"
                        isError = true
                        firstNumberText = result
                        resultLabel.text = result
                    } else {
                        if (secondNumberText == "0" && operatorText == "÷") {
                            let result = "Error"
                            isError = true
                            firstNumberText = result
                            secondNumberText = ""
                            resultLabel.text = result
                        } else {
                            let result = calculate()
                            firstNumberText = String(result)
                            let lastTwo = firstNumberText.suffix(2)
                            if (lastTwo == ".0") {
                                let endIndex = firstNumberText.index(firstNumberText.endIndex, offsetBy: -2)
                                let truncated = firstNumberText.prefix(upTo: endIndex)
                                resultLabel.text = String(truncated)
                            } else {
                                resultLabel.text = firstNumberText
                            }
                        }
                    }
                } else if(firstNumberText != "") {
                    resultLabel.text = firstNumberText
                } else {
                    resultLabel.text = "0"
                    canClear = true
                }
                break
            case "AC":
                firstNumberText = ""
                secondNumberText = ""
                resultLabel.text = "0"
                isOperatorClicked = false
                canClear = true
                isError = false
                break
            case "+/-":
                if isError {
                    resultLabel.text = "Error"
                } else {
                    if (currentText.first == "-") {
                        if isFirstNumber {
                            firstNumberText.remove(at: firstNumberText.startIndex)
                            resultLabel.text = firstNumberText
                        } else {
                            secondNumberText.remove(at: secondNumberText.startIndex)
                            resultLabel.text = secondNumberText
                        }
                    } else {
                        if isFirstNumber {
                            firstNumberText = "-" + firstNumberText
                            resultLabel.text = firstNumberText
                        } else {
                            secondNumberText = "-" + secondNumberText
                            resultLabel.text = secondNumberText
                        }
                    }
                }
                break
            case "%":
                if isError {
                    resultLabel.text = "Error"
                } else {
                    let firstNumber = Double(firstNumberText)!
                    let result = firstNumber / 100
                    resultLabel.text = "\(result)"
                    firstNumberText = "\(result)"
                }
                break
            default:
                if isFirstNumber {
                    firstNumberText = "\(firstNumberText)\(text)"
                } else {
                    if secondNumberText.isEmpty {
                        currentText = ""
                    }
                    secondNumberText = "\(secondNumberText)\(text)"
                }
                if (currentText == "0" && text == "0") {
                    resultLabel.text = currentText
                } else if(currentText == "0" && text != "0") {
                    resultLabel.text = text
                } else {
                    resultLabel.text = "\(currentText)\(text)"
                }
                break
            }
        }
    }
    
    func calculate() -> Double {
        let firstNumber = Double(firstNumberText)!
        let secondNumber = Double(secondNumberText)!
        firstNumberText = ""
        secondNumberText = ""
        switch operatorText {
            case "+":
                return firstNumber + secondNumber
            case "-":
                return firstNumber - secondNumber
            case "×":
                return firstNumber * secondNumber
            case "÷":
                return firstNumber / secondNumber
            default:
                return 0
        }
    }
}
