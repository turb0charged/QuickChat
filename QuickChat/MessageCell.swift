//
//  MessageCell.swift
//  QuickChat
//
//  Created by Hector Castillo on 8/10/17.
//  Copyright © 2017 Hector Castillo. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
    fileprivate static let font = UIFont.systemFont(ofSize: 17)
    
    static var singleLineHeight: CGFloat {
        return font.lineHeight + insets.top + insets.bottom
    }
    
    static func textHeight(_ text: String, width: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: width - insets.left - insets.right, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [ NSFontAttributeName: font ]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height) + insets.top + insets.bottom
    }
    
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    func animateReceived(completion: (() -> Void)?) {
        
        let resizeAnimation = CABasicAnimation(keyPath: "transform.scale")
        let oldFrame = self.frame
        contentView.layer.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        contentView.frame = oldFrame
        resizeAnimation.fromValue = 0.0
        resizeAnimation.toValue = 1.0
        resizeAnimation.duration = 3.4
        resizeAnimation.beginTime = CACurrentMediaTime()
        resizeAnimation.fillMode = kCAFillModeBackwards
        label.layer.add(resizeAnimation, forKey: "scale")
        contentView.layer.add(resizeAnimation, forKey: "scale")
        //        self.layer.add(resizeAnimation, forKey: "scale")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            completion?()
        }
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
    func animateSent(completion: (() -> Void)?) {
        
        let resizeAnimation = CABasicAnimation(keyPath: "transform.scale")
        var oldFrame = self.frame
        contentView.layer.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        contentView.frame = oldFrame
        resizeAnimation.fromValue = 0.0
        resizeAnimation.toValue = 1.0
        resizeAnimation.duration = 3.4
        resizeAnimation.beginTime = CACurrentMediaTime()
        resizeAnimation.fillMode = kCAFillModeBackwards
        label.layer.add(resizeAnimation, forKey: "scale")
        contentView.layer.add(resizeAnimation, forKey: "scale")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            completion?()
        }
    }

    

}
