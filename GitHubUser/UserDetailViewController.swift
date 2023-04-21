//
//  UserDetailViewController.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/4/16.
//

import UIKit

final class UserDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var twitterName: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    private let viewModel: UserDetailViewModelType
    init(viewModel: UserDetailViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel)
        viewModel.getUserDetail()
    }
    private func bind(_ viewModel: UserDetailViewModelType) {
        viewModel.userDetail.observe(on: self) { [weak self] _ in
            DispatchQueue.main.async {
                self?.updateView(dataModel: viewModel.userDetail.value) }
        }
    }
    private func updateView(dataModel: UserDetailDataModel) {
        userName.text = dataModel.name
        loginLabel.text = dataModel.login
        twitterName.text = dataModel.twitterName
        followingLabel.text = dataModel.following?.description
        followersLabel.text = dataModel.followers?.description
    }
}
