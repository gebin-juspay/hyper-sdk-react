//
//  HSBCPaymentsUtils.h
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSBCPaymentsUtils : NSObject

+ (NSDictionary *)updateServiceNameInPayload:(NSDictionary *)payload tenantServiceName:(NSString *)tenantServiceName isResponse:(BOOL)isResponse;

@end

NS_ASSUME_NONNULL_END
