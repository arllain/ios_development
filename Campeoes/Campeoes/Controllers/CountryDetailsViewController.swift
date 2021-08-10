//
//  CountryDetailsViewController.swift
//  Campeoes
//
//  Created by aluno on 07/08/21.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    var worldCup:  WorldCup!
    var worldCups: [WorldCup] = []
    var winner: String!
    
    
    @IBOutlet weak var ivWinner: UIImageView!
    @IBOutlet weak var lbConquerNumber: UILabel!
    @IBOutlet weak var tvConquers: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(worldCup.winner)"
        ivWinner.image = UIImage(named: worldCup.winner)
        
        var numConquistas = 0
        var conquistas: String = ""
        
        for cup in worldCups {
            if (cup.winner == worldCup.winner){
                numConquistas+=1
                conquistas = conquistas + "- \(cup.country), \(cup.year) (\(cup.winner) \(cup.winnerScore)  X  \(cup.viceScore)  \(cup.vice)) \n"
                
            }
        }
        
        print(conquistas)
        lbConquerNumber.text = "Copas do mundo conquistadas: " + String(numConquistas)
        tvConquers.text = conquistas
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
