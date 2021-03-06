//
//  DMLUser.h
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLModel.h"
#import "DMLObjectStore.h"

@import CoreLocation;

@interface DMLUser : NSObject <DMLModel, DMLPersistentObject>

@property (nonatomic, readonly, assign) NSInteger identifier;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, assign) CLLocationCoordinate2D locationCoordinate;

+(instancetype)userWithAttributes:(NSDictionary *)attributes;

@end

#pragma mark - Me
@interface DMLUser ()

@property (nonatomic, readonly, strong) NSString *authenticationToken;

-(void)updateLocationWithLongitude:(CGFloat)longitude latitude:(CGFloat)latitude completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;
-(void)updatePushToken:(NSString *)pushToken completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;

+(void)createUserWithName:(NSString *)name completionBlock:(void (^)(void))completionBlock failedBlock:(void (^)(NSError *error))failedBlock;

+(instancetype)me;
-(BOOL)isMe;

@end
