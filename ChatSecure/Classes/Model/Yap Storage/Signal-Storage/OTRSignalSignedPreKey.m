//
//  OTRSignalSignedPreKey.m
//  ChatSecure
//
//  Created by David Chiles on 7/26/16.
//  Copyright © 2016 Chris Ballinger. All rights reserved.
//

#import "OTRSignalSignedPreKey.h"
#import "OTRAccount.h"
#import <ChatSecureCore/ChatSecureCore-Swift.h>

@implementation OTRSignalSignedPreKey

- (instancetype) initWithAccountKey:(NSString *)accountKey keyId:(uint32_t)keyId keyData:(NSData *)keyData
{
    NSString *uniqueId = [[self class] uniqueIdForAccountKey:accountKey keyId:keyId];
    if (self = [super initWithUniqueId:uniqueId]) {
        self.accountKey = accountKey;
        self.keyId = keyId;
        self.keyData = keyData;
    }
    return self;
}


- (nullable NSArray<YapDatabaseRelationshipEdge *> *)yapDatabaseRelationshipEdges
{
    NSString *edgeName = [YapDatabaseConstants edgeName:RelationshipEdgeNameSignalSignedPreKey];
    YapDatabaseRelationshipEdge *edge = [YapDatabaseRelationshipEdge edgeWithName:edgeName destinationKey:self.accountKey collection:[OTRAccount collection] nodeDeleteRules:YDB_DeleteSourceIfDestinationDeleted];
    if (edge) {
        return @[edge];
    }
    return nil;
}

/** This value is used for the uniqueId property and can be used for fetchObjectWithUniqueId */
+ (NSString*) uniqueIdForAccountKey:(NSString*)accountKey keyId:(uint32_t)keyId {
    NSString *uniqueId = [NSString stringWithFormat:@"%@-%d", accountKey, keyId];
    return uniqueId;
}

@end
