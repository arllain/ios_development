//
//  WorldCupTableViewCell.swift
//  Campeoes
//
//  Created by aluno on 01/08/21.
//

import UIKit

class WorldCupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbCountry: UILabel!
    @IBOutlet weak var ivWinner: UIImageView!
    @IBOutlet weak var lbWinner: UILabel!
    @IBOutlet weak var lbWinnerScore: UILabel!
    @IBOutlet weak var ivVice: UIImageView!
    @IBOutlet weak var lbVice: UILabel!
    @IBOutlet weak var lbViceScore: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with worldCup: WorldCup) {
        ivWinner.image = UIImage(named: worldCup.winner)
        ivVice.image = UIImage(named: worldCup.vice)
        lbYear.text = "\(worldCup.year)"
        lbWinner.text = worldCup.winner
        lbWinnerScore.text = worldCup.winnerScore
        lbVice.text = worldCup.vice
        lbViceScore.text = worldCup.viceScore
        lbCountry.text = worldCup.country
    }

}
