//
//  LLBWindowManager.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class LLBWindowManager: NSObject {
    static let defaultInstance = LLBWindowManager()
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LLBWindowManager.userLoggedIn), name: UserDidLoginViaInstaGramNotificaiton, object: nil)
    }
    
    var window: UIWindow = UIWindow(frame: UIScreen.mainScreen().bounds) {
        willSet(newWindow) {
            self.window = newWindow
        }
        didSet {
            prepareWindow()
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func prepareWindow() {
        window.rootViewController = initialViewController()
        window.makeKeyAndVisible()
    }
    
    private func initialViewController() -> UIViewController {
        print("login state access token \(Storage.accessToken()!)")
        if Storage.accessToken()!.isEmpty {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LLBLoginController") as! LLBLoginController
            return vc
        } else {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LLBTagsImageViewController") as! LLBTagsImageViewController
            return vc
        }
    }
}

// MARK:- View Controllers

extension LLBWindowManager {
    private func makeRootViewController(viewController: UIViewController) {
        window.rootViewController?.view.alpha = 0
        UIView.transitionFromView((window.rootViewController?.view)!, toView: (viewController.view)!, duration: 0.65, options: .TransitionCrossDissolve) { (isFinished: Bool) in
            self.window.rootViewController = viewController
            self.window.rootViewController?.view.alpha = 1
        }
    }
}

// MARK:- Notification Actions

extension LLBWindowManager {
    func userLoggedIn() {
        Storage.setUserLoginState(LoginState.loggedIn.rawValue)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc: LLBTagsImageViewController = storyboard.instantiateViewControllerWithIdentifier("LLBTagsImageViewController") as! LLBTagsImageViewController
        makeRootViewController(vc)
    }
    
    func userLoggedOut() {
        Storage.setUserLoginState(LoginState.loggedOut.rawValue)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc: LLBLoginController = storyboard.instantiateViewControllerWithIdentifier("LLBLoginController") as! LLBLoginController
        makeRootViewController(vc)
    }
}
