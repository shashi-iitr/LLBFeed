//
//  LLBLoginController.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class LLBLoginController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.alpha = 0;
    }

    @IBAction func didTapLoginButton(sender: AnyObject) {
        webView.alpha = 1
        loginButton.alpha = 0
        let request: NSURLRequest = NSURLRequest.init(URL: NSURL.init(string: kAuthURL)!)
        webView.loadRequest(request)
    }
    
    //MARK: UIWebViewDelegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return isWebviewLoadingRequiredAfterUserLoggedIn(request)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("\(error)")
    }
    
    //MARK: Helpers
    
    func isWebviewLoadingRequiredAfterUserLoggedIn(request: NSURLRequest) -> Bool {
        let urlStr = request.URL?.absoluteString
        if (urlStr?.containsString("access_token="))! {
            print(request.URL!)
            let parts = (urlStr?.componentsSeparatedByString("access_token="))! as NSArray
            let accessTokenParts = parts.lastObject
            print(accessTokenParts!)
            Storage.setAccessToken(accessTokenParts! as! String)
            NSNotificationCenter.defaultCenter().postNotificationName(UserDidLoginViaInstaGramNotificaiton, object: self)
            
            return false
        }
        
        return true
    }
}
