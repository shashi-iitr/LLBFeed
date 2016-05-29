//
//  LLBGenericExtensions.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation
import UIKit
import Haneke

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(self)
    }
}

extension UIStoryboard {
    func instantiateViewController<T: UIViewController where T: StoryboardIdentifiable>(_: T.Type) -> T {
        let optionalViewController = self.instantiateViewControllerWithIdentifier(T.storyboardIdentifier)
        
        guard let viewController = optionalViewController as? T  else {
            fatalError("Couldn’t instantiate view controller with identifier \(T.storyboardIdentifier)")
        }
        
        return viewController
    }
}

extension UIImage {
    class func likeImage(liked :Bool) -> UIImage {
        return liked ? UIImage(named:"activity_active_like")! : UIImage(named:"activity_like")!
    }
    
    class func profilePlaceholder() -> UIImage {
        return UIImage(named: "ProfilePlaceholder")!
    }
    
    class func itemPlaceholer() -> UIImage {
        return UIImage(named: "Placeholer")!
    }
}

extension UIImageView {
    enum PlaceholderType {
        case None
        case Item
        case Profile
        
        func placeholderImage() -> UIImage? {
            switch self {
            case .None: return nil
            case .Item: return UIImage.itemPlaceholer()
            case .Profile: return UIImage.profilePlaceholder()
            }
        }
    }
    
    func setCachedImageWithURL(url: NSURL, placeholderType: PlaceholderType) {
        hnk_setImageFromURL(url, placeholder: placeholderType.placeholderImage())
    }
    
    func setCachedImageWithURLString(urlString: String?, placeholderType: PlaceholderType) {
        if let photoURLString = urlString, photoURL = NSURL(string: photoURLString) {
            setCachedImageWithURL(photoURL, placeholderType: placeholderType)
        }
    }
}

extension NSObject {
    class func className() -> String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}

extension UIView {
    class func nib() -> UINib {
        return UINib(nibName: className(), bundle: nil)
    }
    
    class func loadFromNib() -> UIView? {
        return nib().instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}

