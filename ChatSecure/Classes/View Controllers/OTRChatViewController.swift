//
//  OTRChatViewController.swift
//  ChatSecureCore
//
//  Created by Benjamin Erhart on 13.02.18.
//  Copyright © 2018 Chris Ballinger. All rights reserved.
//

import UIKit
import MessageKit

class OTRChatViewController: MessagesViewController, OTRYapViewHandlerDelegateProtocol {

    private let threadOwner: OTRThreadOwner
    private let senderId: String
    private let roDb: YapDatabaseConnection

    private var viewHandler: OTRYapViewHandler?
    private var shouldAutoFetchUrls = false


    init(_ threadOwner: OTRThreadOwner) {
        self.threadOwner = threadOwner
        senderId = threadOwner.threadAccountIdentifier
        roDb = OTRDatabaseManager.shared.longLivedReadOnlyConnection!

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewHandler = OTRYapViewHandler(databaseConnection: roDb)
        viewHandler?.delegate = self;
        viewHandler?.keyCollectionObserver.observe(threadOwner.threadIdentifier,
                                                   collection: threadOwner.threadCollection)
        viewHandler?.setup(OTRFilteredChatDatabaseViewExtensionName,
                           groups: [threadOwner.threadIdentifier])

        roDb.read() { (transaction) in
            if let account = self.threadOwner.account(with: transaction) {
                self.shouldAutoFetchUrls = !account.disableAutomaticURLFetching
            }
        }
    }
}
