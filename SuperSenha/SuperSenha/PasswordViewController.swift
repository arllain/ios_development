//
//  PasswordViewController.swift
//  SuperSenha
//
//  Created by aluno on 07/08/21.
//

import UIKit

class PasswordViewController: UIViewController {
    
    @IBOutlet weak var tvPasswords: UITextView!
    
    var numberOfCharacters: Int = 10 // default se usuario nao enviar
    var numberOfPasswords: Int = 1
    var useLetters: Bool!
    var useNumbers: Bool!
    var useCapitalLetters: Bool!
    var useSpecialCharacters: Bool!
    
    var passwordGenerator: PasswordGenerator!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passwordGenerator = PasswordGenerator(numberOfCharacters: numberOfCharacters,
                                              useLetters: useLetters,
                                              useNumbers: useNumbers,
                                              useCapitalLetters: useCapitalLetters,
                                              useSpecialLetters: useSpecialCharacters)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func generatePasswordsAgain(_ sender: UIButton) {
        tvPasswords.scrollRangeToVisible(NSRange(location: 0, length: 0)) // posiciona a scroll no topo da view
        tvPasswords.text = "" // limpa a view
        
        let passwords = passwordGenerator.generate(total: numberOfPasswords)
        for password in passwords {
            tvPasswords.text.append(password + "\n\n")
        }
    }
}
