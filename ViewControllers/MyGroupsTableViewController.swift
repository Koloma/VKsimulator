//
//  MyGroupsTableViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit
    
class MyGroupsTableViewController: UITableViewController {

    private var myGroups:[VKGroup.Group] = []
    
    @IBAction private func logOutButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(VKGroupTableViewCell.nib, forCellReuseIdentifier: VKGroupTableViewCell.identifier)
        NetService.shared.loadGroups(token: Session.shared.token){[weak self] groups in
            guard let self = self else { return }
            self.myGroups = groups
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: VKGroupTableViewCell.identifier, for: indexPath) as? VKGroupTableViewCell {
            cell.configur(group: myGroups[indexPath.row])
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
//        guard let tableVC = segue.source as? GroupsTableViewController,
//              let index = tableVC.tableView.indexPathForSelectedRow else { return }
//        print ("\(index)")
//        let group = tableVC.groups[index.row]
//        if !myGroups.contains(group){
//            myGroups.append(group)
//            myGroups.sort()
//            tableView.reloadData()
//        }

    }

}
