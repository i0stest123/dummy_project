//
//  QuickstartConversationsManager.swift
//  ConversationsQuickstart
//
//  Created by Jeffrey Linwood on 9/12/20.
//  Copyright © 2020 Twilio, Inc. All rights reserved.
//

/*import UIKit

import TwilioConversationsClient

/*
 * Delegate - usually implemented on the parent view controller. Send updates
 * that would require a user interface refresh
 */
protocol QuickstartConversationsManagerDelegate: AnyObject {
    func reloadMessages()
    func receivedNewMessage()
    func displayStatusMessage(_ statusMessage:String)
    func displayErrorMessage(_ errorMessage:String)
}

class QuickstartConversationsManager: NSObject, TwilioConversationsClientDelegate {

    // the unique name of the conversation you create
    private var uniqueConversationName = ""

    // For the quickstart, this will be the view controller
    weak var delegate: QuickstartConversationsManagerDelegate?

    // MARK: Conversations variables
    private var client: TwilioConversationsClient?
    private var conversation: TCHConversation?
    private(set) var messages: [TCHMessage] = []
    
    func conversationsClient(_ client: TwilioConversationsClient, synchronizationStatusUpdated status: TCHClientSynchronizationStatus) {
        guard status == .completed else {
            return
        }
        checkConversationCreation{ (_, channel) in
            if let channel = channel {
                self.joinConversation(channel)
            }
        }
    }


    // Called whenever a conversation we've joined receives a new message
    func conversationsClient(_ client: TwilioConversationsClient, conversation: TCHConversation,
                    messageAdded message: TCHMessage) {
        messages.append(message)

        // Changes to the delegate should occur on the UI thread
        DispatchQueue.main.async {
            if let delegate = self.delegate {
                delegate.reloadMessages()
                delegate.receivedNewMessage()
            }
        }
    }
    

    func sendMessage(_ messageText: String,
                     completion: @escaping (TCHResult, TCHMessage?) -> Void) {
        
        let messageOptions = TCHMessageOptions().withBody(messageText)
        conversation?.sendMessage(with: messageOptions, completion: { (result, message) in
            completion(result, message)
        })
    
    }
    
    func loginWithAccessToken(_ token: String,_ sid: String,completion: @escaping(_ mResult:Bool) -> Void) {
        self.uniqueConversationName = sid
        // Set up Twilio Conversations client
        TwilioConversationsClient.conversationsClient(withToken: token,
         properties: nil,
         delegate: self) { (result, client) in
            print("is logged in \(result) and the client is \(client)")
           self.client = client
            completion(self.client != nil)
        }
    }

    func shutdown() {
        if let client = client {
            client.delegate = nil
            client.shutdown()
            self.client = nil
        }
    }


    private func checkConversationCreation(_ completion: @escaping(TCHResult?, TCHConversation?) -> Void) {
        guard let client = client else {
            return
        }
        client.conversation(withSidOrUniqueName: uniqueConversationName) { (result, conversation) in
            completion(result, conversation)
        }
    }

    private func joinConversation(_ conversation: TCHConversation) {
        self.conversation = conversation
        if conversation.status == .joined {
            print("Current user already exists in conversation")
            self.loadPreviousMessages(conversation)
        } else {
            conversation.join(completion: { result in
                print("Result of conversation join: \(result.resultText ?? "No Result")")
                if result.isSuccessful {
                    self.loadPreviousMessages(conversation)
                }
            })
        }
    }
    
    private func loadPreviousMessages(_ conversation: TCHConversation) {
        conversation.getLastMessages(withCount: 100) { (result, messages) in
            if let messages = messages {
                self.messages = messages
                DispatchQueue.main.async {
                    self.delegate?.reloadMessages()
                }
            }
        }
    }
    
}
*/
