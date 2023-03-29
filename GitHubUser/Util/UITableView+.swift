//
//  UITableView+.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/3/29.
//

import UIKit

extension UITableView {
    func dequeueCell< T: UITableViewCell>(indexPath: IndexPath) -> T? {
       let cell = self.dequeueReusableCell(withIdentifier: T.name,
                                 for: indexPath) as? T
        return  cell
    }
    func registerCell (_ aCell: UITableViewCell.Type) {
         self.register(UINib(nibName: aCell.name,
                             bundle: nil),
                       forCellReuseIdentifier: aCell.name)
    }
}
