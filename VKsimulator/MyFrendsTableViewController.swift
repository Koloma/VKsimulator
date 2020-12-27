//
//  MyFrendsTableViewController.swift
//  VKsimulator
//
//  Created by Admin on 27.12.2020.
//

import UIKit

class MyFrendsTableViewController: UITableViewController {
    
    var myFrends:[VKUser] = [VKUser(id: 0, nicName: "Pushkin", fio: "Alexandr Sergeevich", avatarImage: UIImage(systemName: "person.fill.checkmark"))
                            ,VKUser(id: 1, nicName: "lozzz", fio: "Ivanov Ivan Ivanich", avatarImage: UIImage())
                            ,VKUser(id: 2, nicName: "Tanchik", fio: "Popova Taniya", avatarImage: UIImage(systemName: "eyes.inverse"))
                            ,VKUser(id: 3, nicName: "Vovan", fio: "Petrovich", avatarImage: UIImage(systemName: "mustache"))
                            ,VKUser(id: 4, nicName: "electrik", fio: "", avatarImage: UIImage(systemName: "eye.slash"))]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFrends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyFrendsTableViewCell{
            cell.nicNameLabel.text = myFrends[indexPath.row].nicName
            cell.userImage.image = myFrends[indexPath.row].avatarImage
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyFrendsTableViewCell{
            cell.nicNameLabel.text = myFrends[indexPath.row].nicName
            cell.userImage.image = myFrends[indexPath.row].avatarImage
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if  let frendsCollectionViewController = storyBoard.instantiateViewController(withIdentifier: "FrendsCollectionViewController") as? FrendsCollectionViewController{
                frendsCollectionViewController.frend = myFrends[indexPath.row]
                navigationController?.pushViewController(frendsCollectionViewController, animated: true)
            }
            //print("Selected cell row: \(indexPath.row)")
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            myFrends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
