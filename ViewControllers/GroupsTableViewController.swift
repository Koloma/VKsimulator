//
//  GroupsTableViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit
import FirebaseDatabase

class GroupsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    private lazy var groupRef = Database.database().reference(withPath: "\(Session.shared.userId)").child(K.FireBase.pathGroups)
    
    var groups:[VKGroup] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    private func addNewGroupToFirebase(group: VKGroup){
        
        let firebaseGroup = FirebaseGroup(from: group)

        print("New group add to Firebase: \(group.name) Id: \(group.id)")

            switch Config.dataBaseType {
            case .database:
                groupRef.child("\(firebaseGroup.id)").setValue(firebaseGroup.toAnyObject())
                break
            case .firestore:
                break
            }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(VKGroupTableViewCell.nib, forCellReuseIdentifier: VKGroupTableViewCell.identifier)
        searchBar.delegate = self
        
    }

    func searchGroup(searchText : String){
        NetService.shared.groupsSearch(token: Session.shared.token, textQuery:searchText ){[weak self] results in
           
            switch results{
            case .success(let groups):
                
                DispatchQueue.main.async {
                    self?.groups = groups
                    //self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = groups[indexPath.row]
        try? RealmService.shared?.add(objects: [group])
        addNewGroupToFirebase(group: group)
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
}

extension GroupsTableViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
            searchGroup(searchText: searchText)
        }else{
            groups = []
        }
        
    }
    
}
