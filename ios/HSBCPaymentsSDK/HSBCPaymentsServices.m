//
//  HSBCPaymentsServices.m
//

#import "HSBCPaymentsServices.h"
#import "HSBCPaymentsUtils.h"
#import "HSBCPaymentsConstants.h"

@interface HSBCPaymentsServices()

@property (nonatomic, strong) NSString *tenantServiceName;

@end

@implementation HSBCPaymentsServices

- (instancetype)init
{
    HyperTenantParams *tenantParams = [[HyperTenantParams alloc] init];
    tenantParams.tenantId = HSBC_HK_HYPER_TENANT_ID;
    tenantParams.releaseConfigURL = HSBC_HK_HYPER_RELEASE_CONFIG_URL;
    
    self = [super initWithTenantParams:tenantParams];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithClientId:(NSString *)clientId {
    HyperTenantParams *tenantParams = [[HyperTenantParams alloc] init];
    tenantParams.clientId = clientId;
    tenantParams.tenantId = HSBC_HK_HYPER_TENANT_ID;
    tenantParams.releaseConfigURL = HSBC_HK_HYPER_RELEASE_CONFIG_URL;
    
    self = [super initWithTenantParams:tenantParams];
    if (self) {
        
    }
    return self;
}

- (void)initiate:(UIViewController *)viewController payload:(NSDictionary *)initiationPayload callback:(HSBCPaymentsCallback)callback {
    self.tenantServiceName = initiationPayload[@"service"];
    NSDictionary *updatedPayload = [HSBCPaymentsUtils updateServiceNameInPayload:initiationPayload tenantServiceName:self.tenantServiceName isResponse:false];
    __weak HSBCPaymentsServices *weakSelf = self;
    [super initiate:viewController payload:updatedPayload callback:^(NSDictionary<NSString *,id> * _Nullable data) {
        NSDictionary *updatedResponse = [HSBCPaymentsUtils updateServiceNameInPayload:data tenantServiceName:weakSelf.tenantServiceName isResponse:true];
        callback(updatedResponse);
    }];
}

- (void)process:(UIViewController *)viewController processPayload:(NSDictionary *)processPayload {
    NSDictionary *updatedPayload = [HSBCPaymentsUtils updateServiceNameInPayload:processPayload tenantServiceName:self.tenantServiceName isResponse:false];
    [super process:viewController processPayload:updatedPayload];
}

- (void)process:(NSDictionary *)processPayload {
    NSDictionary *updatedPayload = [HSBCPaymentsUtils updateServiceNameInPayload:processPayload tenantServiceName:self.tenantServiceName isResponse:false];
    [super process:updatedPayload];
}

- (HSBCPaymentsEventsCallback)merchantEvent {
    return [super merchantEvent];
}

- (void)setDelegate:(id<HSBCPaymentsDelegate>)delegate {
    [super setHyperDelegate:delegate];
    _delegate = delegate;
}

@end
