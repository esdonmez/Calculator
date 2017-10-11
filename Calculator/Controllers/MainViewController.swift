//
//  MainViewController.swift
//  Calculator
//
//  Created by Onur Celik on 30/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var commaButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var signButton: UIButton!

    public static var historyTextArray: [String] = ["", "", "", "", ""]
    var firstNumberText: String = ""
    var secondNumberText: String = ""
    
    var operatorText: String = ""
    var isOperatorClicked: Bool = false
    var isFirstNumber: Bool = true
    var isFirstChar: Bool = true
    var isEqualPressed: Bool = false
    var canClear: Bool = true
    var isError: Bool = false
    var isDotPressed: Bool = false
    var currentText: String = ""
    var i: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        setNeedsStatusBarAppearanceUpdate()
        resultLabel.text = "0"
    }
    
    
    func configure() {
        acButton.layer.cornerRadius = acButton.layer.frame.height / 2
        zeroButton.layer.cornerRadius = zeroButton.layer.frame.height / 2
        oneButton.layer.cornerRadius = oneButton.layer.frame.height / 2
        twoButton.layer.cornerRadius = twoButton.layer.frame.height / 2
        threeButton.layer.cornerRadius = threeButton.layer.frame.height / 2
        fourButton.layer.cornerRadius = fourButton.layer.frame.height / 2
        fiveButton.layer.cornerRadius = fiveButton.layer.frame.height / 2
        sixButton.layer.cornerRadius = sixButton.layer.frame.height / 2
        sevenButton.layer.cornerRadius = sevenButton.layer.frame.height / 2
        eightButton.layer.cornerRadius = eightButton.layer.frame.height / 2
        nineButton.layer.cornerRadius = nineButton.layer.frame.height / 2
        commaButton.layer.cornerRadius = commaButton.layer.frame.height / 2
        equalButton.layer.cornerRadius = equalButton.layer.frame.height / 2
        addButton.layer.cornerRadius = addButton.layer.frame.height / 2
        minusButton.layer.cornerRadius = minusButton.layer.frame.height / 2
        multiplyButton.layer.cornerRadius = multiplyButton.layer.frame.height / 2
        divideButton.layer.cornerRadius = divideButton.layer.frame.height / 2
        percentButton.layer.cornerRadius = percentButton.layer.frame.height / 2
        signButton.layer.cornerRadius = signButton.layer.frame.height / 2
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func HistoryButton(_ sender: Any) {
        
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
                isDotPressed = false
                acButton.setTitle( "C" , for: .normal )
                isFirstChar = true
                if(isEqualPressed) {
                    isEqualPressed = false
                }
                if (firstNumberText == "") {
                    firstNumberText = "0"
                    resultLabel.text = firstNumberText
                }
                
                if (secondNumberText != "") {
                    let result = calculate()
                    isOperatorClicked = false
                    firstNumberText = String(result)
                    let lastTwo = firstNumberText.suffix(2)
                    if (lastTwo == ".0") {
                        let endIndex = firstNumberText.index(firstNumberText.endIndex, offsetBy: -2)
                        let truncated = firstNumberText.prefix(upTo: endIndex)
                        resultLabel.text = String(truncated)
                        firstNumberText = String(truncated)
                    } else {
                        resultLabel.text = firstNumberText
                    }
                }
                
                if (isOperatorClicked && operatorText == text) {
                    return
                }
                operatorText = text
                isFirstNumber = false
                isOperatorClicked = true
                break
            case "=":
                isDotPressed = false
                isFirstChar = true
                isEqualPressed = true
                if (firstNumberText != "" && secondNumberText != "") {
                    isFirstNumber = true
                    isOperatorClicked = false
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
                                firstNumberText = String(truncated)
                            } else {
                                resultLabel.text = firstNumberText
                            }
                        }
                    }
                } else if(firstNumberText != "") {
                    let lastTwo = firstNumberText.suffix(2)
                    if (lastTwo == ".0") {
                        let endIndex = firstNumberText.index(firstNumberText.endIndex, offsetBy: -2)
                        let truncated = firstNumberText.prefix(upTo: endIndex)
                        resultLabel.text = String(truncated)
                        firstNumberText = String(truncated)
                    } else {
                        resultLabel.text = firstNumberText
                    }
                } else {
                    resultLabel.text = "0"
                    canClear = true
                }
                break
            case "C", "AC":
                acButton.setTitle( "AC" , for: .normal )
                firstNumberText = ""
                secondNumberText = ""
                resultLabel.text = "0"
                isOperatorClicked = false
                isFirstChar = true
                canClear = true
                isError = false
                isDotPressed = false
                break
            case "+/-":
                acButton.setTitle( "C" , for: .normal )
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
                isDotPressed = false
                acButton.setTitle( "C" , for: .normal )
                if isError {
                    resultLabel.text = "Error"
                } else {
                    let firstNumber = Double(firstNumberText)!
                    let result = firstNumber / 100
                    if(i == 5) {
                        i = 0
                    }
                    firstNumberText = "\(result)"
                    let lastTwo = firstNumberText.suffix(2)
                    if (lastTwo == ".0") {
                        let endIndex = firstNumberText.index(firstNumberText.endIndex, offsetBy: -2)
                        let truncated = firstNumberText.prefix(upTo: endIndex)
                        resultLabel.text = String(truncated)
                        firstNumberText = String(truncated)
                    } else {
                        resultLabel.text = firstNumberText
                    }
                    MainViewController.historyTextArray[i] = "%" + firstNumberText + "=" + firstNumberText
                    i = i + 1
                }
                break
            default:
                if ((isDotPressed && text != ".") || !isDotPressed) {
                    acButton.setTitle( "C" , for: .normal )
                    if isEqualPressed {
                        isEqualPressed = false
                        firstNumberText = ""
                        resultLabel.text = ""
                        currentText = "0"
                        isFirstNumber = true
                    }
                    if (isFirstChar && text == ".") {
                        if (isFirstNumber && resultLabel.text == "") {
                            firstNumberText = "0."
                            resultLabel.text = firstNumberText
                        } else if (!isFirstNumber && resultLabel.text == "") {
                            secondNumberText = "0."
                            resultLabel.text = secondNumberText
                        }
                    } else {
                        if(isFirstChar) {
                            isFirstChar = false;
                        }
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
                    }
                }
                
                if (text == ".") {
                    isDotPressed = true
                }
                break
            }
        }
    }
    
    func calculate() -> Double {
        if(i == 5) {
            i = 0
        }
        
        let firstNumber = Double(firstNumberText)!
        let secondNumber = Double(secondNumberText)!
        var result: Double
        var resultText: String
        switch operatorText {
            case "+":
                result = firstNumber + secondNumber
            case "-":
                result = firstNumber - secondNumber
            case "×":
                result = firstNumber * secondNumber
            case "÷":
                result = firstNumber / secondNumber
            default:
                result = 0
        }
        let lastTwo = String(result).suffix(2)
        if (lastTwo == ".0") {
            let endIndex = String(result).index(String(result).endIndex, offsetBy: -2)
            let truncated = String(result).prefix(upTo: endIndex)
            resultText = String(truncated)
        } else {
            resultText = String(result)
        }
        
        MainViewController.historyTextArray[i] =  firstNumberText + operatorText + secondNumberText + "=" + resultText
        firstNumberText = ""
        secondNumberText = ""
        i = i + 1
        
        return result
    }

}
