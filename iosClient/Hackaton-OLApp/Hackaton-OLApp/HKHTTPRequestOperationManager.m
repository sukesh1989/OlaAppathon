//
//

#import "HKHTTPRequestOperationManager.h"

#define TIMEOUT_LOGIN 60
#define URL_BASE @"https://olaapi.herokuapp.com"
#define Test_url @"tests.json"
@implementation HKHTTPRequestOperationManager
static HKHTTPRequestOperationManager* _instance;

+(HKHTTPRequestOperationManager*) sharedInstance
{
    static dispatch_once_t requestOperationManager;
    dispatch_once(&requestOperationManager, ^{
        _instance = [[HKHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE]];
    });
    return _instance;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self)
    {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        self.requestSerializer.timeoutInterval = TIMEOUT_LOGIN;
        //[self.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        [self.securityPolicy setAllowInvalidCertificates:YES];
    }
    return self;
}

-(void) getData
{
   // NSDictionary *dictRequest = [[NSDictionary alloc] init];
    [self GET:Test_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([self.delegate respondsToSelector:@selector(HKHTTPRequestOperationManager: didReceiveResponse:)])
        {
            [self.delegate HKHTTPRequestOperationManager:self didReceiveResponse:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if([self.delegate respondsToSelector:@selector(HKHTTPRequestOperationManager: didFailWithError:)])
        {
            [self.delegate HKHTTPRequestOperationManager:self didFailWithError:error];
            NSLog(@"Error: %@", [error debugDescription]);
        }
    }];
    
   // [self POST:<#(NSString *)#> parameters:<#(id)#> constructingBodyWithBlock:<#^(id<AFMultipartFormData> formData)block#> success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>]
}

@end
