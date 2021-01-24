//
//  RefreshControl+ext.swift
//  VKsimulator
//
//  Created by Admin on 21.01.2021.
//

import UIKit


extension UIRefreshControl {
    func myBeginRefreshing(in tableView: UITableView) {
        beginRefreshing()
        let contentOffset = CGPoint(x: 0, y: -frame.size.height)
        tableView.setContentOffset(contentOffset, animated: true)
    }
}
