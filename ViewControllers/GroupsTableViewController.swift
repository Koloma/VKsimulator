//
//  GroupsTableViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    var groups:[VKGroup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(VKGroupTableViewCell.nib, forCellReuseIdentifier: VKGroupTableViewCell.identifier)
        tableView.register(UINib(nibName: "HeaderTableView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderTableView")
        
        NetService.shared.groupsSearch(token: Session.shared.token, textQuery:"GeekBrains"){[weak self] results in
            guard let self = self else { return }
            
            switch results{            
            case .success(let groups):
                self.groups = groups
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }

        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "unwindFromTableViewController", sender: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VKGroupTableViewCell.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: VKGroupTableViewCell.identifier, for: indexPath) as? VKGroupTableViewCell {
            cell.configur(group: groups[indexPath.row])
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
