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
        tableView.register(VKGroupTableViewCell.nib, forCellReuseIdentifier: VKGroupTableViewCell.identifier)
        tableView.register(UINib(nibName: "HeaderTableView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderTableView")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: VKGroupTableViewCell.identifier, for: indexPath) as? VKGroupTableViewCell {
            cell.configur(groupName: groups[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableView") as? HeaderTableView{
            header.text = "Header View TEXT"
            return header
        }
        return nil
    }

}
