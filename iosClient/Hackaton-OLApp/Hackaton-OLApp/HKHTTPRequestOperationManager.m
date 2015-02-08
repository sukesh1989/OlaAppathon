//
//

#import "HKHTTPRequestOperationManager.h"
#import "Constants.h"

#define TIMEOUT_LOGIN 60

#define URL_BASE_CUSTOMSERVER @"https://olaapi.herokuapp.com"
#define URL_BASE @"https://maps.googleapis.com"

#define GOOGLEAPI @"maps/api/geocode/json"
#define GOOGLEDIRECTIONS @"maps/api/directions/json"

#define AUTHENTICATE @"users.json"
#define GETDRIVER @"booking/getdriver.json"

//http://olaapi.herokuapp.com/booking/getdriver.json?fromlat=12.959172&fromlong=77.697419&tolat=12.955116&tolong=77.687492

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

-(void) getData:(NSDictionary*)dictParameters type:(NSString*)reqType
{
    //[dictRequest setValue:[NSString stringWithFormat:@"G M Palya, Bangalore" ] forKey:@"address"];
    NSString *strGetString = [NSString stringWithFormat:@""];
    if ([REQ_TYPE_GET_LATLNG  isEqualToString: reqType]) {
        strGetString = [NSString stringWithFormat:GOOGLEAPI];
        self.baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",URL_BASE]];
    }
    else if([REQ_TYPE_GET_DIRECTIONS isEqualToString:reqType])
    {
        strGetString = [NSString stringWithFormat:GOOGLEDIRECTIONS];
        self.baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",URL_BASE]];
    }
    else if([REQ_TYPE_AUTHENTICATE isEqualToString:reqType])
    {
        strGetString = [NSString stringWithFormat:AUTHENTICATE];
    }
    else if([REQ_TYPE_GETDRIVER isEqualToString:reqType])
    {
        strGetString = [NSString stringWithFormat:GETDRIVER];
    }
    
    [self GET:strGetString parameters:dictParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([self.delegate respondsToSelector:@selector(HKHTTPRequestOperationManager: didReceiveResponse: type:)])
        {
            [self.delegate HKHTTPRequestOperationManager:self didReceiveResponse:responseObject type:reqType];
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

-(void) getDataFromCustomServer:(NSDictionary*)dictParameters type:(NSString*)reqType
{
    self.baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",URL_BASE_CUSTOMSERVER]];
    [self getData:dictParameters type:reqType];
   // self = [self initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",URL_BASE_CUSTOMSERVER ]]];
    
}

@end
