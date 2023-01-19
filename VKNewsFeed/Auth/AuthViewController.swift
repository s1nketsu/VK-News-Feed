//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 16.01.2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService
        view.backgroundColor = .white
    }

    @IBAction func signInTouch(_ sender: Any) {
        authService.wakeUpSession()
    }
}

