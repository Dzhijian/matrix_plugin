#import "MatrixPlugin.h"
#import <MatrixSDK/MatrixSDK.h>
#import <MJExtension/MJExtension.h>

@interface MatrixPlugin()
/// mxRestClient
@property(nonatomic,strong)  MXRestClient *mxRestClient;
@end

@implementation MatrixPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"matrix_plugin"
            binaryMessenger:[registrar messenger]];
  MatrixPlugin* instance = [[MatrixPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *param = call.arguments;
    NSLog(@"param >>> %@",param);
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
        
    } else if ([@"supportedMatrixVersions" isEqualToString:call.method]) {
        /// 获取服务器支持的规范的版本。
        [self.mxRestClient supportedMatrixVersions:^(MXMatrixVersions *matrixVersions) {
            NSLog(@"supportedMatrixVersions : %@", matrixVersions.mj_JSONObject);
            result(matrixVersions.mj_JSONObject);
        } failure:^(NSError *error) {
            NSLog(@"supportedMatrixVersions Error : %@",error.description);
            result(@{@"error":@"supportedMatrixVersions Error"});
        }];
        
    } else if ([@"initWithHomeServer" isEqualToString:call.method]) {
        /// 初始化
        MXRestClient *mxRestClient = [[MXRestClient alloc] initWithHomeServer:param[@"homeServer"] andOnUnrecognizedCertificateBlock:nil];
        self.mxRestClient = mxRestClient;
        NSLog(@"initWithHomeServer are: %@",self.mxRestClient.credentials.mj_JSONString);
        result(self.mxRestClient.credentials.mj_JSONObject);
    } else if ([@"loginWithTypeUsernamePwd" isEqualToString:call.method]) {
        /// 登录
        [self.mxRestClient loginWithLoginType:kMXLoginFlowTypePassword username:param[@"username"] password:param[@"password"] success:^(MXCredentials *credentials) {
            NSLog(@"loginWithLoginType are: %@", credentials.mj_JSONObject);
            result(credentials.mj_JSONObject);
        } failure:^(NSError *error) {
            NSLog(@"loginWithLoginType Error : %@",error.description);
            result(@{@"error":@"Login Error"});
        }];
    } else if ([@"registerWithLoginTypeUsernamePwd" isEqualToString:call.method]) {
        /// register 注册
        [self.mxRestClient registerWithLoginType:kMXLoginFlowTypePassword username:param[@"username"] password:param[@"password"] success:^(MXCredentials *credentials) {
            NSLog(@"registerWithLoginTypeUsernamePwd : %@", credentials.mj_JSONObject);
            result(credentials.mj_JSONObject);
        } failure:^(NSError *error) {
            NSLog(@"loginWithLoginType Error : %@",error.description);
            result(@{@"error":@"register Error"});
        }];
        
    } else if ([@"testUserRegistration" isEqualToString:call.method]) {
        [self.mxRestClient testUserRegistration:param[@"username"] callback:^(MXError *mxError) {
            NSLog(@"testUserRegistration : %@", mxError.mj_JSONObject);
            result(mxError.mj_JSONObject);
        }];
    }else if ([@"isUsernameAvailable" isEqualToString:call.method]) {
        [self.mxRestClient isUsernameAvailable:param[@"username"] success:^(MXUsernameAvailability *availability) {
            NSLog(@"isUsernameAvailable : %@", availability.mj_JSONObject);
            result(availability.mj_JSONObject);
        } failure:^(NSError *error) {
            NSLog(@"isUsernameAvailable Error : %@",error.description);
            result(@{@"error":@"isUsernameAvailable Error"});
        }];
    }else if ([@"getRegisterSession" isEqualToString:call.method]) {
        [self.mxRestClient getRegisterSession:^(MXAuthenticationSession *authSession) {
            NSLog(@"getRegisterSession : %@", authSession.mj_JSONObject);
            result(authSession.mj_JSONObject);
        } failure:^(NSError *error) {
            NSLog(@"getRegisterSession Error : %@",error.description);
            result(@{@"error":@"getRegisterSession Error"});
        }];
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

@end
