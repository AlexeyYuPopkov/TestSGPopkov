//
//  KF_ImageView.swift
//  
//
//  Created by Alexey Popkov on 8/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import Kingfisher
import UIKit

open class KF_ImageView: UIImageView
{
    public struct VM: Hashable {
        var url: URL?
        let placeholder: UIImage?
        
        let cornerRadius: CGFloat?
        let targetSize: CGSize?
        let completion: (() -> Void)?
        
        public init(url: URL?,
                    placeholder: UIImage?,
                    cornerRadius: CGFloat? = nil,
                    targetSize: CGSize? = nil,
                    completion: (() -> Void)? = nil)
        {
            self.url = url
            self.placeholder = placeholder
            self.cornerRadius = cornerRadius
            self.targetSize = targetSize
            self.completion = completion
        }
        
        public var hashValue: Int {
            return url.hashValue ^ placeholder.hashValue
        }
    }
    
    public var activityIndicator: UIActivityIndicatorView? {
        willSet {
            activityIndicator?.removeFromSuperview()
        }
        didSet {
            if let indicator = activityIndicator {
                addSubview(indicator)
                indicator.hidesWhenStopped = true
            }
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator?.center = self.center
    }
    
    private var _vm: VM? {
        didSet {
            self.setImageWithUrl(url: _vm?.url,
                                 placeholder: _vm?.placeholder,
                                 cornerRadius: _vm?.cornerRadius,
                                 targetSize: _vm?.targetSize,
                                 completion: _vm?.completion)
        }
    }
    
    open var vm: VM? {
        get { return _vm }
        set {
            guard let newValue = newValue else {
                DispatchQueue.main.async {
                    self._vm = nil
                    self.image = nil
                }
                return
            }
            
            if _vm?.hashValue == newValue.hashValue {
                return
            }
            
            _vm = newValue
        }
    }
    
    open func setImageWithUrl(url: URL?,
                              placeholder: UIImage?,
                              cornerRadius: CGFloat? = nil,
                              targetSize: CGSize? = nil,
                              completion: (() -> Void)? = nil)
    {
        activityIndicator?.startAnimating()
        
        var options: KingfisherOptionsInfo = [.transition(.fade(0.2))]
        
        if let cornerRadius = cornerRadius, let targetSize = targetSize {
            options.append(.processor(CroppingImageProcessor(size: targetSize)))
            options.append(.processor(RoundCornerImageProcessor(cornerRadius: cornerRadius, targetSize: targetSize, roundingCorners: RectCorner.all, backgroundColor: nil)))
        } else if let cornerRadius = cornerRadius {
            options.append(.processor(RoundCornerImageProcessor(cornerRadius: cornerRadius)))
        } else if let targetSize = targetSize {
            options.append(.processor(ResizingImageProcessor(referenceSize: targetSize, mode: .aspectFill)))
        }
        
        KingfisherManager.shared.downloader.trustedHosts = NetworkClient.TrustedHosts
        
        self.kf.setImage(with: url,
                         placeholder: placeholder,
                         options: options,
                         progressBlock: nil) { [weak self] _,_,_,_ in
                            self?.activityIndicator?.stopAnimating()
                            completion?()
        }
    }
}

extension KF_ImageView
{
    static func circularScaleCrop(_ image: UIImage, size: CGSize, radius: CGFloat) -> UIImage? {
        return image.kf.image(withRoundRadius: radius, fit: size)
    }
}

// MARK: VM Equatable

public func ==(lhs: KF_ImageView.VM, rhs: KF_ImageView.VM) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

