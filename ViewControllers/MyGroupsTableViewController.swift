//
//  MyGroupsTableViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit
import RealmSwift
import FirebaseDatabase
    
class MyGroupsTableViewController: UITableViewController {

    private var myGroupsNotificationToken: NotificationToken?
    private lazy var groupRef = Database.database().reference(withPath: "\(Session.shared.userId)").child(K.FireBase.pathGroups)
    
    private var myGroups:Results<VKGroup>?{
        let groups: Results<VKGroup>? = RealmService.shared?.loadGroups()
        return groups?.sorted(byKeyPath: "name", ascending: true)
    }
    
    private lazy var myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = K.Colors.refresher
        refreshControl.attributedTitle = NSAttributedString(string: "Reload Data", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    private func showAlert(title: String? = nil,
                           message: String? = nil,
                           handler: ((UIAlertAction) -> Void)? = nil,
                           completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: completion)
    }
    
    @IBAction private func logOutButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(VKGroupTableViewCell.nib, forCellReuseIdentifier: VKGroupTableViewCell.identifier)
        tableView.refreshControl = myRefreshControl
        notification()
        loadGroupsData()
    }
    
    func notification(){
        myGroupsNotificationToken = myGroups?.observe { [weak self] change in
            switch change {
            case .initial(let group):
                print("Initialize \(group.count)")
                break
            case .update(let group, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                print("""
                    New count \(group.count)
                    Deletions \(deletions)
                    Insertions \(insertions)
                    Modifications \(modifications)
                    """
                    )
                self?.tableView.beginUpdates()
                let deletionIndexPaths = deletions.map { IndexPath(item: $0, section: 0) }
                self?.tableView.deleteRows(at: deletionIndexPaths, with: .automatic)
                self?.tableView.insertRows(at: insertions.map { IndexPath(item: $0, section: 0) }, with: .automatic)
                self?.tableView.reloadRows(at: modifications.map { IndexPath(item: $0, section: 0) }, with: .automatic)
                self?.tableView.endUpdates()
                
                break
            case .error(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }

    
    @objc func refreshTableView(_ sender: AnyObject){
        loadGroupsData(){ [weak self] in
            DispatchQueue.main.async {
                self?.myRefreshControl.endRefreshing()
            }
        }
    }
    
    private func loadGroupsData(complition: (() -> Void)? = nil){
        NetService.shared.loadGroups(token: Session.shared.token){[weak self] result in
            switch result{
            case .success(let groups):
                DispatchQueue.main.async {
                    RealmService.shared?.saveGroups(groups)
                    
                    let firebaseGroups = groups.map{FirebaseGroup(from: $0) }
                    print("Groups saved to Firebase")
                    for group in firebaseGroups{
                        switch Config.dataBaseType {
                        case .database:
                            self?.groupRef.child("\(group.id)").setValue(group.toAnyObject())
                            break
                        case .firestore:
                            break
                        }
                    }
                        
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
//                DispatchQueue.main.async {
//                    self?.myGroups = RealmService.shared?.loadGroups()
//                    self?.tableView.reloadData()
//                }
            }
            complition?()
       }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VKGroupTableViewCell.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: VKGroupTableViewCell.identifier, for: indexPath) as? VKGroupTableViewCell{
            let group = myGroups?[indexPath.row]
            cell.configur(group: group!)
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            guard let group = myGroups?[indexPath.row] else {
                tableView.deselectRow(at: indexPath, animated: true)
                return
            }
            //try? RealmService.shared?.delete(object: group)
            print("VKGroup removed from Firebase: \(group.name) Id: \(group.id)")
            groupRef.child("\(group.id)").removeValue()
        }
    }
    
    @IBAction func unwindFromTableViewController(_ segue: UIStoryboardSegue){
        guard let tableVC = segue.source as? GroupsTableViewController,
              let index = tableVC.tableView.indexPathForSelectedRow else { return }
        print ("\(index)")
        let group = tableVC.groups[index.row]
        do {
            try RealmService.shared?.add(objects: [group])
        } catch {
            print(error)
        }
        
//        if !myGroups?.contains(group){
//            myGroups.append(group)
//            myGroups.sort()
//            tableView.reloadData()
//        }
    }

}
