//
//  ViewController.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/3/27.
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet weak var mTableView: UITableView!
    let viewModel: UserListViewModelType
    var pageViewController = UIPageViewController()
    var viewControllers : [UIViewController] = []
    var seelectedIndex: Int = 0
    
    
    
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
        initPage()
        initViewController()
      
    }
    private func bind(_ viewModel: UserListViewModelType) {
        viewModel.userList.observe(on: self) {[weak self] _ in self?.updateView()}
    }
    private func updateView() {
        DispatchQueue.main.async {
            self.mTableView.reloadData()
        }
    }
    
    func initViewController(){
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.init(red: 1, green: 0.2, blue: 0.4, alpha: 0.3)
        viewController.view.tag = 0
        
        let viewController1 = UIViewController()
        viewController1.view.backgroundColor = UIColor.init(red: 0.4, green: 0.3, blue: 1, alpha: 0.3)
        viewController1.view.tag = 1
        
        viewControllers.append(viewController)
        viewControllers.append(viewController1)
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: false)
    }
    
    func initPage(){
        pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
        pageViewController.view.frame = CGRect.init(x: 0, y: 74, width: self.view.frame.width, height: self.view.frame.height - 74)
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.isEditing = true
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        
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

extension UserListViewController:UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    //從左往右滑
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        seelectedIndex = viewController.view.tag
        let pageIndex = viewController.view.tag - 1
        if pageIndex < 0 {
            return nil
        }
        return viewControllers[pageIndex]
    }
    
    //從右往左滑
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        seelectedIndex = viewController.view.tag
        let pageIndex = viewController.view.tag + 1
        if pageIndex > 1 {
            return nil
        }
        return viewControllers[pageIndex]
    }
    
    
}
