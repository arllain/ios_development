//
//  ConsoleViewController.swift
//  MyGames
//
//  Created by aluno on 29/08/21.
//

import UIKit

class ConsoleViewController: UIViewController {
    
    @IBOutlet weak var lbConsoleName: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    
    var console: Console!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //title = console.name
        //lbConsoleName.text = console?.name
        lbConsoleName.text = console.name ?? ""
        
        if let image = console.cover as? UIImage {
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "noCoverFull")
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! AddEditPlataformaViewController
        vc.console = console
    }
}
