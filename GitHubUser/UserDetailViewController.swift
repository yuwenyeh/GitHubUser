//
//  UserDetailViewController.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/4/16.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var twitterName: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    private var viewModel: UserDetailViewModel
    init(data: UserDataModel) {
        viewModel = UserDetailViewModel(userDetail: data)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUserDetail()
        initView(dataModel:viewModel.userDetail.value)
    }
    
    func initView(dataModel :UserDetailDataModel){
        userName.text = dataModel.name
        loginLabel.text = dataModel.login
        twitterName.text = dataModel.twitterName
        followingLabel.text = dataModel.following?.description
        followersLabel.text = dataModel.followers?.description
    }
    
}
