//
//  HSBCPaymentsServices.h
//

#import <Foundation/Foundation.h>
#import <HyperSDK/Hyper.h>

NS_ASSUME_NONNULL_BEGIN

typedef HyperSDKCallback HSBCPaymentsCallback;

typedef HyperEventsCallback HSBCPaymentsEventsCallback;

@protocol HSBCPaymentsDelegate <HyperDelegate>

@end

@interface HSBCPaymentsServices : HyperServices

@property (nonatomic, weak) id <HSBCPaymentsDelegate> _Nullable delegate;

+ (void)preFetch:(NSDictionary *)data __unavailable;

- (instancetype _Nonnull)initWithClientId:(NSString * _Nonnull)clientId;

- (void)initiate:(UIViewController * _Nonnull)viewController payload:(NSDictionary * _Nonnull)initiationPayload callback:(HSBCPaymentsCallback _Nonnull)callback;

- (HSBCPaymentsEventsCallback _Nullable)merchantEvent;

@end

NS_ASSUME_NONNULL_END
