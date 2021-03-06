//
//  MyFrendsViewController.swift
//  VKsimulator
//
//  Created by Admin on 21.01.2021.
//

import UIKit

final class MyFrendsViewController: UIViewController {

    private struct FriendsForTable{
        var firstLetter:[String] = []
        var friends:[[VKUser]] = [[]]
    }
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var cancelImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    private let viewModelFactory = UserViewModelFactory()
    
    var myFriends:[VKUser] = []
    {
        didSet{
            friends = myFriends
            filteredFriendsForTable = prepareFrendsData(friends)
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
        }
    }
    
    private var friends:[VKUser] = []
    private var filteredFriendsForTable:FriendsForTable = FriendsForTable()
    private lazy var cacheService = CacheService(container: tableView)
    
    func logOut() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController();
        let sbAnimation = SBAnimationFactory.prepearSearchBar()
        let sbAnimator = SBAnimator(animation: sbAnimation)
        sbAnimator.animate(searchImage: searchImageView, textField: searchTextField, cancelImage: cancelImageView, in: searchView)
        
        loadUsersData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setGradientBackground(colorTop: K.Gradient.colorBottom, colorBottom: K.Gradient.colorTop)
    }
    
    func filteringTableData(by filterText : String){
        let filteredData = filterText.isEmpty ? friends : friends.filter({(friend: VKUser) -> Bool in
            return friend.firstName.range(of: filterText, options: .caseInsensitive) != nil
            
        })
        filteredFriendsForTable = prepareFrendsData(filteredData)
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
    
    private func setupViewController(){
        
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Loading frends...")
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        
        tableView.register(VKUserTableViewCell.nib, forCellReuseIdentifier: VKUserTableViewCell.reuseCellID)
        tableView.register(FrendsTableViewHeader.nib, forHeaderFooterViewReuseIdentifier: FrendsTableViewHeader.identifier)
        
        tableView.sectionIndexColor = UIColor.black
        
        tableView.backgroundColor = UIColor(cgColor: K.Gradient.colorBottom)
       
    }

    @objc func refreshTableView(_ sender: AnyObject){
        loadUsersData()
        
    }
 
    private func loadDataOperation(){
        let opq = OperationQueue()
        //OPQ.maxConcurrentOperationCount = 1
        let request = NetService.shared.getUsersRequest()
        let getaDataOp = GetDataOperation(request: request)
        
        let parseData = ParseDataUserOperation()
        parseData.addDependency(getaDataOp)
        
        let saveRealOp = SaveRealOperation()
        saveRealOp.addDependency(parseData)
        
        let reloadTbaleOp = ReloadTableControllerOperation(controller: self)
        reloadTbaleOp.addDependency(parseData)
        
        opq.addOperations([getaDataOp,parseData, reloadTbaleOp, saveRealOp], waitUntilFinished: false)
        
    }
    
    private func loadUsersWithPromise(){
        NetService.shared.getUsersPromise()
            .done { (users) in
                DispatchQueue.main.async {
                    self.myFriends = users
                }
            }
            .catch { (error) in
                print(error)
            }
    }
    
    private func loadUsersData() {
        tableView.refreshControl?.myBeginRefreshing(in: tableView)
 
        //loadDataOperation()
        loadUsersWithPromise()
        
//        NetService.shared.loadUsers(){[weak self] results in
//            guard let self = self else { return }
//
//            switch results{
//            case .success(let users):
//                self.myFriends = users
//                //self.friends = users
//                //self.filteredFriendsForTable = self.prepareFrendsData(self.friends)
//                DispatchQueue.main.async {
//                    RealmService.shared?.saveUsers(users)
//                    self.tableView.reloadData()
//                    self.tableView.refreshControl?.endRefreshing()
//                }
//            case .failure(let error):
//                print(error)
//                DispatchQueue.main.async {
//                    self.myFriends = RealmService.shared?.loadUsers() ?? []
//                    //self.friends = RealmService.shared?.loadUsers() ?? []
//                    //self.filteredFriendsForTable = self.prepareFrendsData(self.friends)
//                    self.tableView.reloadData()
//                    self.tableView.refreshControl?.endRefreshing()
//                }
//            }
//        }
    }
    
    /// Подготавливает данные для отображения в таблице (разбивка на секции, сортировка)
    /// - Parameter data: Исходные данные
    /// - Returns: Данные для отображения в таблице
    private func prepareFrendsData(_ data:[VKUser]) -> FriendsForTable{
        var friendsForTable:FriendsForTable = FriendsForTable()
        friendsForTable.firstLetter = data.map( {String(($0.firstName.uppercased().prefix(1))) }).unique.sorted()
        friendsForTable.friends = Array(Dictionary(grouping:data){$0.firstName.uppercased().prefix(1)}.values)
        friendsForTable.friends.sort{ $0[0].firstName.uppercased().prefix(1) < $1[0].firstName.uppercased().prefix(1)}
        return friendsForTable
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
        return filteredFriendsForTable.friends[section].count
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredFriendsForTable.firstLetter.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VKUserTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: VKUserTableViewCell.reuseCellID, for: indexPath) as? VKUserTableViewCell{
            let friend = filteredFriendsForTable.friends[indexPath.section][indexPath.row]
            let image = cacheService.photo(atIndexpath: indexPath, byUrl: friend.photo50!)
            cell.configur(user: friend, image: image){
               
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                if  let userProperty = storyBoard.instantiateViewController(withIdentifier: "UserPropertyVeiwController") as? UserPropertyVeiwController{
                    let userViewModel = self.viewModelFactory.constructViewModel(from: [friend])                    
                    self.navigationController!.pushViewController(userProperty, animated: true)
                    userProperty.configure(with: userViewModel.first!)
                }
              
            }
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
        return filteredFriendsForTable.firstLetter
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vkUser = filteredFriendsForTable.friends[indexPath.section][indexPath.row]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if  let imageGallery = storyBoard.instantiateViewController(withIdentifier: "ImageGalleryCollectionViewController") as? ImageGalleryCollectionViewController{
            imageGallery.user = vkUser
            navigationController!.pushViewController(imageGallery, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            let delFriend = filteredFriendsForTable.friends[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if filteredFriendsForTable.friends[indexPath.section].count == 0{
                filteredFriendsForTable.firstLetter.remove(at: indexPath.section)
                filteredFriendsForTable.friends.remove(at: indexPath.section)
                tableView.deleteSections( [indexPath.section], with: .automatic)
            }
            
            if let index = friends.firstIndex (where: { (friend) -> Bool in
                return friend.firstName == delFriend.firstName && friend.lastName == delFriend.lastName
            }){
                friends.remove(at: index)
            }
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FrendsTableViewHeader.identifier) as? FrendsTableViewHeader{
            header.text = filteredFriendsForTable.firstLetter[section]
            return header
        }
        return nil
        
    }
    
 
}
