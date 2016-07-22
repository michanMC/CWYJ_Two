//
//  homeYJModel.h
//  CWYouJi
//
//  Created by MC on 15/11/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YJUserModel : NSObject
@property(nonatomic,copy)NSString *age;
@property(nonatomic,assign)BOOL hasPayPassword;
@property(nonatomic,copy)NSString *collectionCount;
@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,assign)NSInteger grade;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *introduction;
@property(nonatomic,copy)NSString *isNew;
@property(nonatomic,copy)NSString *lastAccessIp;
@property(nonatomic,copy)NSString *lastAccessTime;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *modifyDate;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *origin;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *raw;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *thumbnail;
@property(nonatomic,copy)NSString *travelCount;
@property(nonatomic,copy)NSString *buyOfShowCount;
@property(nonatomic,copy)NSString *buyOfPickCount;
@property(nonatomic,copy)NSString *buyOfSellCount;

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *gradeimage;
@property(nonatomic,copy)NSString *hid;
@property(nonatomic,copy)NSString *hpass;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString*userno;
@property(nonatomic,copy)NSString *friends;

@property(nonatomic,copy)NSString *travelOfGrade;
@property(nonatomic,copy)NSString *recommendOfGrade;
@property(nonatomic,copy)NSString *pickOfGrade;
@property(nonatomic,copy)NSString *askForBuyOfGrade;

@property(nonatomic,copy)NSString *travelIntro;
@property(nonatomic,copy)NSString *pickIntro;
@property(nonatomic,copy)NSString *recommendIntro;
@property(nonatomic,copy)NSString *askForBuyIntro;


@end

@interface YJphotoModel : NSObject
@property(nonatomic,copy)NSString *createDate;
//@property(nonatomic,copy)NSString *class;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *modifyDate;
@property(nonatomic,assign)NSInteger name;
@property(nonatomic,copy)NSString *raw;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *thumbnail;
@property(nonatomic,copy)NSString *travelId;
@property(nonatomic,copy)NSString *uid;

@end
@interface YJoptsModel : NSObject
@property(nonatomic,copy)NSString *niackname;
//@property(nonatomic,copy)NSString *class;
@property(nonatomic,copy)NSString *opt;


@property(nonatomic,copy)NSString *isAnonymity;

@end




@interface homeYJModel : NSObject
@property(nonatomic,copy)NSString *isAuslese;
@property(nonatomic,assign)NSInteger classify;
@property(nonatomic,copy)NSString *collectCount;
@property(nonatomic,assign)BOOL collection;
@property(nonatomic,copy)NSString *commentCount;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,assign)long long createDate;
@property(nonatomic,copy)NSString *fakeCollectCount;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *isRecommend;
@property(nonatomic,copy)NSString *shareCount;
@property(nonatomic,copy)NSString *spotId;
@property(nonatomic,copy)NSString * spotName;
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *viewCount;
@property(nonatomic,copy)NSString *distance;

@property(nonatomic,strong)NSDictionary *user;
@property(nonatomic,strong)NSArray *photos;
@property(nonatomic,strong)NSMutableArray *YJphotos;

@property(nonatomic,strong)YJUserModel * userModel;
@property(nonatomic,assign)BOOL  isdelete;
@property(nonatomic,strong)NSArray *opts;

@property(nonatomic,strong)NSMutableArray *YJoptsArray;
@property(nonatomic,strong)YJoptsModel * optsModel;
@property(nonatomic,assign)NSInteger trend;

@property(nonatomic,copy)NSString *currentGrade;
@property(nonatomic,copy)NSString *originalGrade;



@property(nonatomic,copy)NSString *pushType;
@property(nonatomic,copy)NSString *value;

@end
