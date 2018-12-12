//
//  LejiaProjectManager.h
//  LeJiaScreenProject
//
//  Created by sos1a2a3a on 2018/11/8.
//  Copyright © 2018 lijiarui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@protocol LejiaProjectManagerDelegate <NSObject>
@optional
/**
 *  连接成功回调
 */
-(void)onConnected;
/**
 *  连接失败回调
 *
 *  连接失败会自动重新连接,直到连接成功为止
 */
-(void)onDisconnected:(NSError *)error;
@end


@interface LejiaProjectManager : NSObject

/**
 投屏是否连接成功
 */
@property(nonatomic,assign)BOOL isConnectTcp;

/**
 hud信息是否连接成功  比如：亮度 升级 unit
 */
@property(nonatomic,assign)BOOL isConnectTcpInfo;


+ (LejiaProjectManager *)sharedManager;

@property(nonatomic,weak)id<LejiaProjectManagerDelegate> delegate;

/**
 开启投屏

 @param customView  default:keyWindow   customView retain+1
 */
- (void)start:(nullable UIView *)customView;
/**
 *  关闭投屏
 *
 */
-(void)stop;
/**
 *  重启投屏
 *
 */
-(void)reset;


/**
 release customView -1
 */
-(void)releaseCustomView;


/**
 获取hud亮度
 
 @param brightLevelBlock block
 */
-(void)getBrightLevel:(void(^)(NSString *))brightLevelBlock;

/**
 设置hud亮度
 
 @param level  1-6
 @param brightLevelBlock block
 */
-(void)setBrightLevel:(NSInteger)level brightLevelBlock:(void(^)(NSString *))brightLevelBlock;



/**
 获取hudunit
 
 @param speedUnitBlock block
 */
-(void)getSpeedunitStr:(void(^)(NSString *))speedUnitBlock;
/**
 设置hudunit
 
 @param spustr mph  or kmh
 @param speedUnitBlock block
 */
-(void)setSpeedunitStr:(NSString *)spustr speedUnitBlock:(void(^)(NSString *)) speedUnitBlock;


/**
 升级hud rom
 
 */
-(void)sendUpgradeFile:(NSString *) filePath fileName:(NSString *)fileName statusBlock:(void(^)(NSDictionary *)) statusBlock errorBlock:(void(^)(NSError *))errorBlock;
@end

NS_ASSUME_NONNULL_END
