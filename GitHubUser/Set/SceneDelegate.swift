//
//  SceneDelegate.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/3/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowSecne = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowSecne)
        let repository = UserListRepository()
        let viewModel = UserListViewModel(repository: repository)
        let viewController = UserListViewController(viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }
}
