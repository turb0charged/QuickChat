//
//  ChatMessageCell.swift
//  QuickChat
//
//  Created by Hector Castillo on 8/11/17.
//  Copyright © 2017 Hector Castillo. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {
    fileprivate static let font = UIFont.systemFont(ofSize: 17)

    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = ChatMessageCell.font
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
    var animationView: UIView = UIView()
    
    var topConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var leadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var trailingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(label)
        
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
    override func prepareForReuse() {
        for layer in self.contentView.layer.sublayers! {
            if(layer is CAShapeLayer){
                layer.removeFromSuperlayer()
            }
        }
        self.label.layer.mask?.removeFromSuperlayer()
        self.contentView.layer.mask?.removeFromSuperlayer()
    }
    
    func setSentMessageCell() {
        
        self.label.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        self.contentView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        
        let path = UIBezierPath(roundedRect: self.contentView.frame, byRoundingCorners: [.topLeft, .topRight,.bottomLeft], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.contentView.layer.mask = maskLayer
        self.label.textAlignment = NSTextAlignment.right
        
        
        
        
    }
    func animate(completion: (() -> Void)?) {
        
        let resizeAnimation = CABasicAnimation(keyPath: "transform.scale")
        var oldFrame = self.frame
        contentView.layer.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        contentView.frame = oldFrame
        resizeAnimation.fromValue = 0.0
        resizeAnimation.toValue = 1.0
        resizeAnimation.duration = 0.4
        resizeAnimation.beginTime = CACurrentMediaTime()
        resizeAnimation.fillMode = kCAFillModeBackwards
        label.layer.add(resizeAnimation, forKey: "scale")
        contentView.layer.add(resizeAnimation, forKey: "scale")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            completion?()
        }
    }
}
