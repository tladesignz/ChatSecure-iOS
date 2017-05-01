//
//  OTRSignalIdentity.m
//  ChatSecure
//
//  Created by David Chiles on 7/21/16.
//  Copyright © 2016 Chris Ballinger. All rights reserved.
//

#import "OTRAccountSignalIdentity.h"
#import "OTRSignalSignedPreKey.h"

@implementation OTRAccountSignalIdentity

- (nullable instancetype)initWithAccountKey:(NSString *)accountKey identityKeyPair:(SignalIdentityKeyPair *)identityKeyPair registrationId:(uint32_t)registrationId signedPreKeyUniqueId:(NSString*)signedPreKeyUniqueId {
    if (self = [super initWithUniqueId:accountKey]) {
        self.accountKey = accountKey;
        self.identityKeyPair = identityKeyPair;
        self.registrationId = registrationId;
        self.signedPreKeyUniqueId = signedPreKeyUniqueId;
    }
    return self;
}

- (nullable OTRSignalSignedPreKey*) signedPreKeyWithTransaction:(YapDatabaseReadTransaction*)transaction {
    NSParameterAssert(transaction);
    if (!transaction) { return nil; }
    NSString *key = self.signedPreKeyUniqueId;
    if (!key) {
        key = self.accountKey; // legacy fallback
    }
    OTRSignalSignedPreKey *signedPreKey = [transaction objectForKey:self.signedPreKeyUniqueId inCollection:[OTRSignalSignedPreKey collection]];
    return signedPreKey;
}

@end
