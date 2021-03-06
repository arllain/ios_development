//
//  CountryTableViewController.swift
//  Campeoes
//
//  Created by aluno on 07/08/21.
//

import UIKit

class CountryTableViewController: UITableViewController {
    
    var worldCups: [WorldCup] = []
    var worldCupsWinners: [WorldCup] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountryWorldCups()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadCountryWorldCups() {
        let fileURL = Bundle.main.url(forResource: "winners", withExtension: ".json")!
        let jsonData = try! Data(contentsOf: fileURL)
        
        do {
            worldCups = try JSONDecoder().decode([WorldCup].self, from: jsonData)
            worldCupsWinners = removeDuplicateElements(worldCup: worldCups)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func removeDuplicateElements(worldCup: [WorldCup]) -> [WorldCup] {
        var uniqueWorldCups = [WorldCup]()
        for worldCups in worldCups {
            if !uniqueWorldCups.contains(where: {$0.winner ==  worldCups.winner}) {
                uniqueWorldCups.append(worldCups)
            }
        }
        return uniqueWorldCups
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return worldCupsWinners.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryCell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        let worldCup = worldCupsWinners[indexPath.row]
        
        // Configure the cell...
        countryCell.textLabel?.text = "\(worldCup.winner)"
        countryCell.imageView?.image = UIImage(named: worldCup.winner)
    
        return countryCell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destination as! CountryDetailsViewController
        let worldCupWinner = worldCupsWinners[tableView.indexPathForSelectedRow!.row]
        vc.worldCup = worldCupWinner
        vc.worldCups = worldCups
        
    }

}
