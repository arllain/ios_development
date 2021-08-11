//
//  ViewController.swift
//  SuperSenha
//
//  Created by aluno on 07/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tfTotalPasswords: UITextField!
    @IBOutlet weak var tfNumberOfCharacters: UITextField!
    @IBOutlet weak var swLetters: UISwitch!
    @IBOutlet weak var swNumbers: UISwitch!
    @IBOutlet weak var swSpecialCharacters: UISwitch!
    @IBOutlet weak var swCaptitalLetters: UISwitch!
    @IBOutlet weak var btPasswordGenerate: UIButton!

    let myCustomRGBColor = UIColor(red: 152.0/255.0, green: 36.0/255.0, blue: 101.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let passwordsViewController = segue.destination as! PasswordViewController
        
        // forma mais segura (usar if let)
        if let numberOfPasswords = Int(tfTotalPasswords.text!) {
            // se conseguir obter o valor do campo e converter para inteiro
            passwordsViewController.numberOfPasswords = numberOfPasswords
        }
        if let numberOfCharacters = Int(tfNumberOfCharacters.text!) {
            passwordsViewController.numberOfCharacters = numberOfCharacters
        }
        passwordsViewController.useNumbers = swNumbers.isOn
        passwordsViewController.useCapitalLetters = swCaptitalLetters.isOn
        passwordsViewController.useLetters = swLetters.isOn
        passwordsViewController.useSpecialCharacters = swSpecialCharacters.isOn
        
        // forcar encerrar o modo de edicao // remove o foco e libera teclado
        view.endEditing(true)
    }
    
    @IBAction func acaoLetrasMinusculas(_ sender: UISwitch) {
        if (!sender.isOn && !swNumbers.isOn  && !swCaptitalLetters.isOn && !swSpecialCharacters.isOn){
           isEnableButton(isEnable: false)
        }else{
           isEnableButton(isEnable: true)
        }
    
    }

    @IBAction func acaoNumeros(_ sender: UISwitch) {
        if (!sender.isOn && !swLetters.isOn  && !swCaptitalLetters.isOn && !swSpecialCharacters.isOn){
           isEnableButton(isEnable: false)
        }else{
            isEnableButton(isEnable: true)
        }
    }
    
    @IBAction func acaoLetrasMaiusculas(_ sender: UISwitch) {
        if (!sender.isOn && !swNumbers.isOn  && !swLetters.isOn && !swSpecialCharacters.isOn){
           isEnableButton(isEnable: false)
        }else{
            isEnableButton(isEnable: true)
        }
    }
    
    
    @IBAction func acaoCaracteresEpeciais(_ sender: UISwitch) {
        if (!sender.isOn && !swNumbers.isOn  && !swCaptitalLetters.isOn && !swLetters.isOn){
            isEnableButton(isEnable: false)
        }else{
            isEnableButton(isEnable: true)
        }
    }
    
    func isEnableButton(isEnable:Bool){
        if(isEnable) {
            btPasswordGenerate.isEnabled = true
            btPasswordGenerate.backgroundColor = myCustomRGBColor
            
        }else {
            btPasswordGenerate.isEnabled = false
            btPasswordGenerate.backgroundColor = UIColor.lightGray
        }
    }
    
}

