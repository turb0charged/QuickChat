//
//  ChatFlowLayout.swift
//  QuickChat
//
//  Created by Hector Castillo on 8/11/17.
//  Copyright © 2017 Hector Castillo. All rights reserved.
//

import UIKit

class ChatFlowLayout: UICollectionViewFlowLayout{
    var insertingIndexPaths = [IndexPath]()
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        insertingIndexPaths.removeAll()
        
        for update in updateItems {
            if let indexPath = update.indexPathAfterUpdate,
                update.updateAction == .insert {
                insertingIndexPaths.append(indexPath)
            }
        }
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        
        insertingIndexPaths.removeAll()
    }
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        
//        if insertingIndexPaths.contains(itemIndexPath) {
            if let cell = collectionView?.cellForItem(at: itemIndexPath) as? ChatMessageCell{
                let initialFrame = CGRect(x: cell.frame.maxX, y: cell.frame.maxY, width: 0.1, height: 0.1)
                let originalFrame = cell.animationView.frame
                cell.animationView.frame = initialFrame
                UIView.animate(withDuration: 0.5, animations: {
                    cell.animationView.frame = originalFrame
                })
            }
            else if let cell = collectionView?.cellForItem(at: itemIndexPath) as? ReceivedMessageCell{
                    
            }
        
            
            
//        }
        
        return attributes
    }
}
