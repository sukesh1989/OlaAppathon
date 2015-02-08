//
//  EXHTTPRequestOperationManager.h
//
//

#import "AFHTTPRequestOperationManager.h"

@protocol HKHTTPRequestOperationManagerDelegate;

@interface HKHTTPRequestOperationManager : AFHTTPRequestOperationManager

@property (nonatomic, weak) id<HKHTTPRequestOperationManagerDelegate> delegate;

+(HKHTTPRequestOperationManager*) sharedInstance;
- (instancetype)initWithBaseURL:(NSURL *)url;
-(void) getData:(NSDictionary*)dictParameters type:(NSString*)reqType;
-(void) getDataFromCustomServer:(NSDictionary*)dictParameters type:(NSString*)reqType;

@end

@protocol HKHTTPRequestOperationManagerDelegate <NSObject>

@optional
-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didReceiveResponse:(id)response type:(NSString*)strType;
-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didFailWithError:(NSError *)error;

@end
