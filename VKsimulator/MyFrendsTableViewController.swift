//
//  MyFrendsTableViewController.swift
//  VKsimulator
//
//  Created by Admin on 27.12.2020.
//

import UIKit

class MyFrendsTableViewController: UITableViewController {
    
    @IBAction private func tapLogOutButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private var myFrends:[VKUser] = []
    private var firstLetters:[String] = []
    private var groupsLetterUser:[[VKUser]] = [[]]
    
    private var actiIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Updating frends...")
        refreshControl?.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        refreshControl?.beginRefreshing()
        
        loadUsersData()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupsLetterUser.count
    }

    @objc func refreshTableView(_ sender: AnyObject){
        loadUsersData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsLetterUser[section].count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return firstLetters
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if firstLetters.count > 0{
            return firstLetters[section].uppercased()
        }
        else { return nil }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyFrendsTableViewCell{
            cell.nicNameLabel.text = groupsLetterUser[indexPath.section][indexPath.row].nicName
            cell.descriptionLabel.text = groupsLetterUser[indexPath.section][indexPath.row].description
            cell.userImage.image = groupsLetterUser[indexPath.section][indexPath.row].avatar
            cell.userImage.rounded()
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            groupsLetterUser[indexPath.section].remove(at: indexPath.row)
            if groupsLetterUser[indexPath.section].count == 0 {
                groupsLetterUser.remove(at: indexPath.section)
                firstLetters.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .fade)
            }

            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if  let frendsCollectionViewController = storyBoard.instantiateViewController(withIdentifier: "FrendsCollectionViewController") as? FrendsCollectionViewController{
                //Здесь передаем данные в frendsCollectionViewController
                navigationController?.pushViewController(frendsCollectionViewController, animated: true)
            }
            print("Selected cell row: \(indexPath.row)")
    }
    
    
    private func showIndicator(){
        actiIndicatorView.center = self.view.center
        actiIndicatorView.hidesWhenStopped = true
        actiIndicatorView.style = UIActivityIndicatorView.Style.large
        view.addSubview(actiIndicatorView)
        actiIndicatorView.startAnimating()
    }
    
    
    private func loadUsersData() {
        //showIndicator()
        let networkService = NetworkService()
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async{
            self.myFrends = networkService.GetUsers(userCount: 20)
            self.firstLetters = self.myFrends.map({ String($0.nicName.uppercased().prefix(1)) }).unique.sorted()
            self.groupsLetterUser = Array(Dictionary(grouping:self.myFrends){$0.nicName.uppercased().prefix(1)}.values)
            self.groupsLetterUser.sort { $0[0].nicName.uppercased().prefix(1) < $1[0].nicName.uppercased().prefix(1)}

            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                //self.actiIndicatorView.stopAnimating()
            }
        }
    }
        
}
