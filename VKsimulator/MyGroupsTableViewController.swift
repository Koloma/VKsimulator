//
//  MyGroupsTableViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit
    
var myGroups:[String] = []

class MyGroupsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyGroupsTableViewCell {
            cell.groupLabel.text = "\(myGroups[indexPath.row])"
            cell.groupImageView.image = .add
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroups.count
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    @IBAction func unwindFromTableViewController(_ segue: UIStoryboardSegue){
        guard let tableVC = segue.source as? GroupsTableViewController,
              let index = tableVC.tableView.indexPathForSelectedRow else { return }
        print ("\(index)")
        let group = tableVC.groups[index.row]
        if !myGroups.contains(group){
            myGroups.append(group)
            myGroups.sort()
            tableView.reloadData()
        }

    }

}
