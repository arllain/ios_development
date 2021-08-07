//
//  CountryDetailsViewController.swift
//  Campeoes
//
//  Created by aluno on 07/08/21.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    var worldCup:  WorldCup!
    var winner: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(worldCup.winner)"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
