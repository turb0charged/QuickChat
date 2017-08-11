//
//  ReceivedMessageCell.swift
//  QuickChat
//
//  Created by Hector Castillo on 8/11/17.
//  Copyright © 2017 Hector Castillo. All rights reserved.
//

import UIKit

class ReceivedMessageCell: UICollectionViewCell {
    fileprivate static let font = UIFont.systemFont(ofSize: 17)
    
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = ReceivedMessageCell.font
        label.textColor = UIColor(red: 121/255, green: 127/255, blue: 144/255, alpha: 1)
        return label
    }()
    
    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        
        contentView.backgroundColor = UIColor.white

        NSLayoutConstraint(item: label,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .top,
                           multiplier: 1,
                           constant: 15).isActive = true
        NSLayoutConstraint(item: label,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 15).isActive = true
        NSLayoutConstraint(item: contentView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: label,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 15).isActive = true
        NSLayoutConstraint(item: contentView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: label,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = ceil(size.width)
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
    
    func setReceivedMessageCell()  {
        
        let path = UIBezierPath(roundedRect: self.contentView.frame, byRoundingCorners: [.topLeft, .topRight,.bottomRight], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor(red: 91/255, green: 111/255, blue: 163/255, alpha: 0.3).cgColor
        maskLayer.lineWidth = 2.0
        self.label.layer.mask = maskLayer
        self.contentView.layer.addSublayer(maskLayer)
    }
    
    func animate(completion: (() -> Void)?) {
        
        let resizeAnimation = CABasicAnimation(keyPath: "transform.scale")
        let oldFrame = self.frame
        contentView.layer.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        contentView.frame = oldFrame
        resizeAnimation.fromValue = 0.0
        resizeAnimation.toValue = 1.0
        resizeAnimation.duration = 0.4
        resizeAnimation.beginTime = CACurrentMediaTime()
        resizeAnimation.fillMode = kCAFillModeBackwards
        label.layer.add(resizeAnimation, forKey: "scale")
        contentView.layer.add(resizeAnimation, forKey: "scale")
//        self.layer.add(resizeAnimation, forKey: "scale")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            completion?()
        }
    }
    
}
