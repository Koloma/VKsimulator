//
//  MyFrendsViewController.swift
//  VKsimulator
//
//  Created by Admin on 21.01.2021.
//

import UIKit

class MyFrendsViewController: UIViewController {

    struct VKUsersForTable{
        var firstLetter:[String] = []
        var vkUsers:[[VKUser]] = [[]]
    }
    private let VKuserCount = 20
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var cancelImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    private var dataVkUsers:[VKUser] = []
    private var filteredVkUsersForTable = VKUsersForTable()
    private let networkService = NetworkService()
    
    private var myWaitIndicatorView = MyWaitIndicatorView()
    
    
    func logOut() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView();
        loadUsersData(count: VKuserCount)
        let sbAnimation = SBAnimationFactory.prepearSearchBar()
        let sbAnimator = SBAnimator(animation: sbAnimation)
        sbAnimator.animate(searchImage: searchImageView, textField: searchTextField, cancelImage: cancelImageView, in: searchView)
        
        if let credential = Session.shared.getCredential() {
            print(credential)
        }
        
    }
    @IBAction func searchTapped(_ sender: UITapGestureRecognizer) {
        let sbAnimation = SBAnimationFactory.makeAnimation()
        let sbAnimator = SBAnimator(animation: sbAnimation)
        sbAnimator.animate(searchImage: searchImageView, textField: searchTextField, cancelImage: cancelImageView, in: searchView)
    }
    
    @IBAction func cancelTapped(_ sender: UITapGestureRecognizer) {
        if !searchTextField.text!.isEmpty{
            searchTextField.text = ""
            textFieldDidChange(searchTextField)
        }
        searchTextField.endEditing(true)
        
        let sbAnimation = SBAnimationFactory.clearAnimation()
        let sbAnimator = SBAnimator(animation: sbAnimation)
        sbAnimator.animate(searchImage: searchImageView, textField: searchTextField, cancelImage: cancelImageView, in: searchView)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        filteringTableData(by: textField.text!)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setGradientBackground(colorTop: K.Gradient.colorBottom, colorBottom: K.Gradient.colorTop)
    }
    
    func filteringTableData(by filterText : String){
        let filteredData = filterText.isEmpty ? dataVkUsers : dataVkUsers.filter({(vkUser: VKUser) -> Bool in
            return vkUser.nicName.range(of: filterText, options: .caseInsensitive) != nil
            
        })
        filteredVkUsersForTable = prepareVKusersData(filteredData)
        tableView.reloadData()
    }
    
    func setGradientBackground(colorTop: CGColor, colorBottom: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom, colorTop]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = searchView.bounds
        searchView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupView(){
        
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Loading frends...")
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        
        tableView.register(VKUserTableViewCell.nib, forCellReuseIdentifier: VKUserTableViewCell.identifier)
        tableView.register(FrendsTableViewHeader.nib, forHeaderFooterViewReuseIdentifier: FrendsTableViewHeader.identifier)
        
        tableView.sectionIndexColor = UIColor.black
        
        tableView.backgroundColor = UIColor(cgColor: K.Gradient.colorBottom)
       
    }

    @objc func refreshTableView(_ sender: AnyObject){
        loadUsersData(count: VKuserCount)
    }
 
    private func loadUsersData(count userCount:Int) {
        myWaitIndicatorView.isHidden = false
        tableView.refreshControl?.myBeginRefreshing(in: tableView)
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async{
            self.dataVkUsers = self.networkService.GetUsers(userCount: userCount)
            self.filteredVkUsersForTable = self.prepareVKusersData(self.dataVkUsers)

            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.myWaitIndicatorView.isHidden = true
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    /// Подготавливает данные для отображения в таблице (разбивка на секции, сортировка)
    /// - Parameter data: Исходные данные
    /// - Returns: Данные для отображения в таблице
    private func prepareVKusersData(_ data:[VKUser])->VKUsersForTable{
        var vkUsersForTable:VKUsersForTable = VKUsersForTable()
        vkUsersForTable.firstLetter = data.map( {String($0.nicName.uppercased().prefix(1)) }).unique.sorted()
        vkUsersForTable.vkUsers = Array(Dictionary(grouping:data){$0.nicName.uppercased().prefix(1)}.values)
        vkUsersForTable.vkUsers.sort{ $0[0].nicName.uppercased().prefix(1) < $1[0].nicName.uppercased().prefix(1)}
        return vkUsersForTable
    }
}

// MARK: - UITextField
extension MyFrendsViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        searchTextField.endEditing(true)
        return true
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MyFrendsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredVkUsersForTable.vkUsers[section].count
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredVkUsersForTable.firstLetter.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: VKUserTableViewCell.identifier, for: indexPath) as? VKUserTableViewCell{
            let vkUser = filteredVkUsersForTable.vkUsers[indexPath.section][indexPath.row]
            cell.configur(nicName: vkUser.nicName, description: vkUser.description, userImage: vkUser.avatar)
            return cell
        }
        return UITableViewCell()
    }
  
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeAnimation()
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0.1
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return filteredVkUsersForTable.firstLetter
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vkUser = filteredVkUsersForTable.vkUsers[indexPath.section][indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if  let newsFeed = storyBoard.instantiateViewController(withIdentifier: "NewsFeedViewController") as? NewsFeedViewController{
            //Здесь передаем данные в NewsFeedViewController
            newsFeed.userNewsFeed = vkUser
            navigationController!.pushViewController(newsFeed, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            let delVkUser = filteredVkUsersForTable.vkUsers[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if filteredVkUsersForTable.vkUsers[indexPath.section].count == 0{
                filteredVkUsersForTable.firstLetter.remove(at: indexPath.section)
                filteredVkUsersForTable.vkUsers.remove(at: indexPath.section)
                tableView.deleteSections( [indexPath.section], with: .automatic)
            }
            
            if let index = dataVkUsers.firstIndex (where: { (vkUser:VKUser ) -> Bool in
                return vkUser.nicName == delVkUser.nicName && vkUser.description == delVkUser.description
            }){
                dataVkUsers.remove(at: index)
            }
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FrendsTableViewHeader.identifier) as? FrendsTableViewHeader{
            header.textL = filteredVkUsersForTable.firstLetter[section]
            return header
        }
        return nil
        
    }
    
 
}
