//
//  LLBTagsImageViewController.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class LLBTagsImageViewController: UIViewController {
    var currentIndex = 0
    var screenSizeHalfHeight: CGFloat = CGFloat()
    var feedGroup = [LLBPhotoFeed]?()
    var previousPhotoFeedView: LLBPhotoFeedView?
    var currentPhotoFeedView: LLBPhotoFeedView?
    var nextPhotoFeedView: LLBPhotoFeedView?
    let screenSize = UIScreen.mainScreen().bounds.size

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var noPhotoLabel: UILabel!
    // MARK: - View lifecycle
    @IBOutlet weak var reloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noPhotoLabel.alpha = 0
        reloadButton.alpha = 0
        screenSizeHalfHeight = UIScreen.mainScreen().bounds.size.height / 2
        fetchPhotoFeeds()
    }
    
    func fetchPhotoFeeds() -> Void {
        indicatorView.startAnimating()
        LLBDataFetcher.dataFetcher.fetchPicsForTag("ifoundawesome", success: { [weak self] (group: [LLBPhotoFeed]!) in
            self?.feedGroup = group
            self!.setupViews()
        }) { (error: NSError!) in
            print(error.debugDescription)
        }
    }

    // MARK: - Setups
    
    func setupViews() {
        indicatorView.stopAnimating()
        if feedGroup?.count > 0 {
            self.view.backgroundColor = .blackColor()
            self.currentPhotoFeedView = getCurrentView()
            self.view.addSubview(currentPhotoFeedView!)
            let pan = UIPanGestureRecognizer(target: self, action: #selector(LLBTagsImageViewController.didPanViewWithGesture(_:)))
            self.view.addGestureRecognizer(pan)
        } else {
            noPhotoLabel.alpha = 1
            reloadButton.alpha = 1
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapReloadButton(sender: UIButton) {
        noPhotoLabel.alpha = 0
        reloadButton.alpha = 0
        fetchPhotoFeeds()
    }

    func didPanViewWithGesture(gesture:UIPanGestureRecognizer){
        var p = gesture.translationInView(self.view)
        p.y = -p.y
        //p.y > 0 -> up panning, p.y < 0 -> down panning
        if p.y < 0 && getPreviousView() == nil || p.y > 0 && getNextView() == nil {
            return
        }
        
        if gesture.state == .Began {
            if let prev = getPreviousView() {
                self.previousPhotoFeedView = prev
                self.view.addSubview(prev)
                prev.frame = CGRect(origin: CGPoint(x: 0, y: -self.view.bounds.height), size: self.view.frame.size)
            }
            
            if let next = getNextView() {
                self.nextPhotoFeedView = next
                self.view.addSubview(next)
                next.frame = self.view.frame
                next.center = CGPointMake(self.view.bounds.width/2, self.view.bounds.height/2)
                self.view.sendSubviewToBack(nextPhotoFeedView!)
            }
        } else if gesture.state == .Changed {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                if p.y > 0 { // right
                    self.currentPhotoFeedView!.center.y = self.view.bounds.height/2 - p.y
                    let ratio = (p.y / CGRectGetHeight(self.view.bounds))
                    let lightRatio = 0.9 + (ratio/10)
                    
                    if let next = self.nextPhotoFeedView {
                        next.hidden = false
                        next.center.y = self.view.bounds.height/2
                        self.applyTransform(next, ratio: lightRatio)
                    }
                } else if p.y < 0 {
                    if let prev = self.previousPhotoFeedView {
                        prev.hidden = false
                        let prevPosY = -self.view.bounds.height/2 - p.y
                        if prevPosY < self.view.bounds.height/2 {
                            prev.center.y = prevPosY
                        } else {
                            prev.center.y = self.view.bounds.height/2
                        }
                    }
                    
                    if let next = self.nextPhotoFeedView {
                        next.hidden = true
                    }
                    
                    let ratio = p.y / CGRectGetHeight(self.view.bounds)
                    let lightRatio = 1 + (ratio / 10)
                    
                    self.currentPhotoFeedView!.layer.transform = CATransform3DMakeScale(lightRatio, lightRatio, lightRatio)
                }
            })
            
        } else if gesture.state == .Ended {
            UIView.animateWithDuration(0.5, delay: 0,
                                       options: [.CurveEaseOut], animations: { () -> Void in
                                        if p.y < 0 && p.y < -self.screenSizeHalfHeight && self.previousPhotoFeedView != nil { // dragged down + > middle -> show prev
                                            self.previousPhotoFeedView?.center.y = self.view.bounds.height/2
                                            self.applyTransform(self.currentPhotoFeedView!, ratio: 0.9)
                                        } else if p.y > 0 && p.y < self.screenSizeHalfHeight { // dragged up but left below middle -> show current
                                            self.currentPhotoFeedView!.center.y = self.view.bounds.height/2
                                        } else if p.y > self.screenSizeHalfHeight && self.nextPhotoFeedView != nil { // dragged up + > middle -> show next
                                            self.currentPhotoFeedView!.center.y = -self.view.bounds.height/2
                                            self.applyTransform(self.nextPhotoFeedView!, ratio: 1)
                                        } else if p.y < 0 && p.y > -self.screenSizeHalfHeight { // dragged down, less than half -> show curr
                                            self.previousPhotoFeedView?.center.y = -self.view.bounds.height/2
                                            self.currentPhotoFeedView!.center.y = self.view.bounds.height/2
                                            self.applyTransform(self.currentPhotoFeedView!, ratio: 1)
                                        }
                }, completion: { (_) -> Void in
                    if p.y < 0 && p.y < -self.screenSizeHalfHeight && self.previousPhotoFeedView != nil { // dragged down + > middle -> show prev
                        self.currentPhotoFeedView = self.getPreviousView()
                        self.currentIndex = (self.currentIndex > 0) ? self.currentIndex - 1 : self.currentIndex;
                    } else if p.y > self.screenSizeHalfHeight && self.nextPhotoFeedView != nil { // dragged up + > middle -> show next
                        self.currentPhotoFeedView = self.getNextView()
                        self.currentIndex = (self.currentIndex == self.feedGroup!.count - 1) ? self.currentIndex : self.currentIndex + 1;
                    }
                    
                    for view in self.view.subviews {
                        view.removeFromSuperview()
                    }
                    
                    self.previousPhotoFeedView = nil
                    self.nextPhotoFeedView = nil
                    
                    self.view.addSubview(self.currentPhotoFeedView!)
                    self.currentPhotoFeedView!.center = CGPointMake(self.view.bounds.width/2, self.view.bounds.height/2)
                    self.view.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Helpers
    
    func getCurrentView() -> LLBPhotoFeedView? {
        let current = LLBPhotoFeedView.loadFromNib() as? LLBPhotoFeedView
        current?.backgroundColor = .whiteColor()
        current?.frame = CGRectMake(1, 1, screenSize.width - 2, screenSize.height - 2)
        current?.configureViewWithPhotoFeed(feedGroup![currentIndex])
        current?.layer.masksToBounds = true
        current?.layer.cornerRadius = 3
        
        return current
    }
    
    func getNextView() -> LLBPhotoFeedView? {
        if currentIndex >= feedGroup!.count - 1 {
            return nil
        }
        
        let next = LLBPhotoFeedView.loadFromNib() as? LLBPhotoFeedView
        next?.backgroundColor = .whiteColor()
        next?.frame = CGRectMake(1, 1, screenSize.width - 2, screenSize.height - 2)
        next?.configureViewWithPhotoFeed(feedGroup![currentIndex + 1])
        next?.layer.masksToBounds = true
        next?.layer.cornerRadius = 3

        return next
    }
    
    func getPreviousView() -> LLBPhotoFeedView? {
        if currentIndex <= 0 {
            return nil
        }
        let prev = LLBPhotoFeedView.loadFromNib() as? LLBPhotoFeedView
        prev?.backgroundColor = .whiteColor()
        prev?.frame = CGRectMake(1, 1, screenSize.width - 2, screenSize.height - 2)
        prev?.configureViewWithPhotoFeed(feedGroup![currentIndex - 1])
        prev?.layer.masksToBounds = true
        prev?.layer.cornerRadius = 3

        return prev
    }
    
    // MARK: Animation
    
    func applyTransform(view: UIView, ratio: CGFloat) {
        print("ratio \(ratio)")
        view.layer.transform = CATransform3DMakeScale(ratio, ratio, ratio)
        view.alpha = 1 - ((1 - ratio) * 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
