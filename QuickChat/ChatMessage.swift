//
//  ChatMessage.swift
//  QuickChat
//
//  Created by Hector Castillo on 8/10/17.
//  Copyright © 2017 Hector Castillo. All rights reserved.
//

import Foundation

struct ChatMessage {
    var messageText : String?
    var messageType: MessageType
    var messageTimeStamp: Date
    
    init(messageType: MessageType,messageText: String?, messageTimeStamp: Date) {
        self.messageType = messageType
        self.messageText = messageText
        self.messageTimeStamp = messageTimeStamp
    }
}

enum MessageType: String {
    case UserMessage
    case ResponseMessage
}
