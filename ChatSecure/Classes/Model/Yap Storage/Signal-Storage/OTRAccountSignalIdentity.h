//
//  OTRSignalIdentity.h
//  ChatSecure
//
//  Created by David Chiles on 7/21/16.
//  Copyright © 2016 Chris Ballinger. All rights reserved.
//

#import "OTRSignalObject.h"
@import YapDatabase;
@class SignalIdentityKeyPair;
@class OTRSignalSignedPreKey;

NS_ASSUME_NONNULL_BEGIN

/** There should only be one OTRSignalIdentity in the database for an account */
@interface OTRAccountSignalIdentity : OTRSignalObject

@property (nonatomic, strong) SignalIdentityKeyPair *identityKeyPair;
@property (nonatomic) uint32_t registrationId;
/** The currently used signedPreKey's uniqueId as calculated by uniqueIdForAccountKey:keyId:. All of them are stored in the db elsewhere in OTRSignalSignedPreKey.collection. May be nil for legacy serialized objects. */
@property (nonatomic, nullable) NSString* signedPreKeyUniqueId;

- (nullable instancetype)initWithAccountKey:(NSString *)accountKey identityKeyPair:(SignalIdentityKeyPair *)identityKeyPair registrationId:(uint32_t)registrationId signedPreKeyUniqueId:(nullable NSString*)signedPreKeyUniqueId;

- (nullable OTRSignalSignedPreKey*) signedPreKeyWithTransaction:(YapDatabaseReadTransaction*)transaction;

@end
NS_ASSUME_NONNULL_END
