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
-(void) getData;

@end

@protocol HKHTTPRequestOperationManagerDelegate <NSObject>

@optional
-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didReceiveResponse:(id)response;
-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didFailWithError:(NSError *)error;

@end
