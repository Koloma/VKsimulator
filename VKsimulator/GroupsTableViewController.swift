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
                           ,"Wheri long grop nicName Citys of the world Moscow, Stambul?"
                           ,"Burito Club"
                           ,"RHorsessssss"].sorted()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "VKGroupTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? VKGroupTableViewCell {
//            //cell.groupsLabel.text = "[\(indexPath.section), \(indexPath.row)], \(groups[indexPath.row])"
//            cell.groupNameLable.text = "\(groups[indexPath.row])"
//            return cell
//        }
//        return UITableViewCell()
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GroupsTableViewCell {
            //cell.groupsLabel.text = "[\(indexPath.section), \(indexPath.row)], \(groups[indexPath.row])"
            cell.groupsLabel.text = "\(groups[indexPath.row])"
            return cell
        }
        return UITableViewCell()
    }


}
