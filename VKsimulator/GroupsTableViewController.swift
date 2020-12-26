//
//  GroupsTableViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    //let groupsDemo:[String] = (1...50).map{String($0)}
    let groups:[String] = ["Animals"
                           ,"Rock Musick"
                           ,"Naturals"
                           ,"Citys of the world dfd fdf df df dfdfdfdfdfdfdfdfdffff"
                           ,"Burito Club"
                           ,"RHorsessssss"].sorted()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GroupsTableViewCell {
            //cell.groupsLabel.text = "[\(indexPath.section), \(indexPath.row)], \(groups[indexPath.row])"
            cell.groupsLabel.text = "\(groups[indexPath.row])"
            return cell
        }
        return UITableViewCell()
    }


}
