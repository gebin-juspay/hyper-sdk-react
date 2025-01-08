//
//  GlobalJuspayPaymentsServices.h
//

#import <Foundation/Foundation.h>
#import <HyperSDK/Hyper.h>

NS_ASSUME_NONNULL_BEGIN

typedef HyperSDKCallback GlobalJuspayPaymentsCallback;

typedef HyperEventsCallback GlobalJuspayPaymentsEventsCallback;

@protocol GlobalJuspayPaymentsDelegate <HyperDelegate>

@end

@interface GlobalJuspayPaymentsServices : HyperServices

@property (nonatomic, weak) id <GlobalJuspayPaymentsDelegate> _Nullable delegate;

+ (void)preFetch:(NSDictionary *)data __unavailable;

- (instancetype _Nonnull)initWithClientId:(NSString * _Nonnull)clientId;

- (void)initiate:(UIViewController * _Nonnull)viewController payload:(NSDictionary * _Nonnull)initiationPayload callback:(GlobalJuspayPaymentsCallback _Nonnull)callback;

- (GlobalJuspayPaymentsEventsCallback _Nullable)merchantEvent;

@end

NS_ASSUME_NONNULL_END
