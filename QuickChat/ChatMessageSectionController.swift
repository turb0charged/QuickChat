//
//  ChatMessageSectionController.swift
//  QuickChat
//
//  Created by Hector Castillo on 8/10/17.
//  Copyright © 2017 Hector Castillo. All rights reserved.
//

import UIKit
import IGListKit

final class ChatMessageSectionController : ListBindingSectionController<ListDiffable> {
    private var message : ChatMessage!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    // MARK: IGListSectionController Overrides
    override func numberOfItems() -> Int {
        return 1
    }
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width
        var size = TextSize.size(message.messageText!, font: UIFont.systemFont(ofSize: 20), width: width-50).size
        size.height+=30
        return size
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let text = message.messageText
        let cell: UICollectionViewCell
        switch message.messageType {
        case .UserMessage:
            guard let manualCell = collectionContext?.dequeueReusableCell(of: ChatMessageCell.self, for: self, at: index) as? ChatMessageCell else {
                fatalError()
            }
            manualCell.text = text
            manualCell.setSentMessageCell()
            if(message.isNew){
                manualCell.animate(completion: {self.message.isNew = false})
            }
            
            cell = manualCell
            
        case .ResponseMessage:
            guard let manualCell = collectionContext?.dequeueReusableCell(of: ReceivedMessageCell.self, for: self, at: index) as? ReceivedMessageCell else {
                fatalError()
            }
            manualCell.text = text
            manualCell.setReceivedMessageCell()
            if(message.isNew){
                manualCell.animate(completion: {self.message.isNew = false})
            }
            cell = manualCell
        }
        return cell
        
    }
    override func didUpdate(to object: Any) {
        self.message = (object as? ChatMessage)!
    }
    
}
