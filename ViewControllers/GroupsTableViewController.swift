//
//  GroupsTableViewController.swift
//  VKsimulator
//
//  Created by Admin on 26.12.2020.
//

import UIKit

final class GroupsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    private lazy var cacheService = CacheService(container: tableView)
    
    var groups:[VKGroup] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(VKGroupTableViewCell.nib, forCellReuseIdentifier: VKGroupTableViewCell.identifier)
        searchBar.delegate = self
        
    }

    func searchGroup(searchText : String){
        NetService.shared.groupsSearch(textQuery:searchText ){[weak self] results in
           
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
            let image = cacheService.photo(atIndexpath: indexPath, byUrl: groups[indexPath.row].photo50)
            cell.configur(group: groups[indexPath.row], image: image)
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
