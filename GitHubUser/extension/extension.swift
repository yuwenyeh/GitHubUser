//
//  extension.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/3/29.
//

import Foundation
import UIKit


extension UITableViewCell {
    static var name: String {
        return String(describing: self)
    }
}


extension UITableView {
    func dequeueCell< T: UITableViewCell>(indexPath: IndexPath) -> T? {
       let cell = self.dequeueReusableCell(withIdentifier: T.name,
                                 for: indexPath) as? T
        return  cell
    }
}
