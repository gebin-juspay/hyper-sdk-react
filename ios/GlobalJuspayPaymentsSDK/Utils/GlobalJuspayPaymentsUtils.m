//
//  GlobalJuspayPaymentsUtils.m
//

#import "GlobalJuspayPaymentsUtils.h"
#import "GlobalJuspayPaymentsConstants.h"

@implementation GlobalJuspayPaymentsUtils

+ (NSDictionary *)updateServiceNameInPayload:(NSDictionary *)payload tenantServiceName:(NSString *)tenantServiceName isResponse:(BOOL)isResponse {
    NSString *serviceName = payload[@"service"];
    if (serviceName) {
        BOOL serviceNameChanged = false;
        if (isResponse && ![tenantServiceName containsString:JP_GLOBAL_HYPER_SERVICE_PREFIX]) {
            serviceName = [serviceName stringByReplacingOccurrencesOfString:JP_GLOBAL_HYPER_SERVICE_PREFIX withString:@""];
            serviceNameChanged = true;
        } else if (![serviceName containsString:JP_GLOBAL_HYPER_SERVICE_PREFIX]) {
            serviceName = [NSString stringWithFormat:@"%@%@", JP_GLOBAL_HYPER_SERVICE_PREFIX, serviceName];
            serviceNameChanged = true;
        }
        
        if (!serviceNameChanged) {
            return payload;
        }
        
        NSMutableDictionary *updatedPayload = [NSMutableDictionary dictionaryWithDictionary:payload];
        updatedPayload[@"service"] = serviceName;
        
        return updatedPayload;
    }
    return payload;
}

@end
