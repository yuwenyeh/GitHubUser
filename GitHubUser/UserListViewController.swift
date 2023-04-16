//
//  ViewController.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/3/27.
//

import UIKit
import Foundation

class UserListViewController: UIViewController {
    @IBOutlet weak var mTableView: UITableView!
    let viewModel: UserListViewModelType
    init(_ viewModel: UserListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.registerCell(UserTableViewCell.self)
        viewModel.getUserList()
        bind(viewModel)
    }
    private func bind(_ viewModel: UserListViewModelType) {
        viewModel.userList.observe(on: self) {[weak self] _ in self?.updateView()}
    }
    private func updateView() {
        DispatchQueue.main.async {
            print("viewModel.userList.value = \(self.viewModel.userList.value.count)")
            self.mTableView.reloadData()
        }
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UserTableViewCell = tableView.dequeueCell(indexPath: indexPath) else {
            return UITableViewCell()
        }
        cell.textLabel?.text = viewModel.userList.value[indexPath.row].name
        return cell
    }
}

