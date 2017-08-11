//
//  ChatMessage.swift
//  QuickChat
//
//  Created by Hector Castillo on 8/10/17.
//  Copyright © 2017 Hector Castillo. All rights reserved.
//

import UIKit
import IGListKit

final class ChatMessage:  ListDiffable{
    let primaryKey: Int
    let messageText : String?
    let messageType: MessageType
    let messageTimeStamp: Date
    
    init(primaryKey: Int, messageType: MessageType, messageText: String?, messageTimeStamp: Date) {
        self.primaryKey = primaryKey
        self.messageType = messageType
        self.messageText = messageText
        self.messageTimeStamp = messageTimeStamp
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return primaryKey as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? ChatMessage else { return false }
        return messageType == object.messageType
    }
}

enum MessageType: String {
    case UserMessage
    case ResponseMessage
}
