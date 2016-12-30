/*
 CustomBadge.h
 
 *** Description: ***
 With this class you can draw a typical iOS badge indicator with a custom text on any view.
 Please use the allocator customBadgeWithString to create a new badge.
 In this version you can modfiy the color inside the badge (insetColor),
 the color of the frame (frameColor), the color of the text and you can
 tell the class if you want a frame around the badge.
 
 *** License & Copyright ***
 Created by Sascha Marc Paulus www.spaulus.com on 04/2011. Version 2.0
 This tiny class can be used for free in private and commercial applications.
 Please feel free to modify, extend or distribution this class. 
 If you modify it: Please send me your modified version of the class.
 A commercial distribution of this class is not allowed.
 
 I would appreciate if you could refer to my website www.spaulus.com if you use this class.
 
 If you have any questions please feel free to contact me (open@spaulus.com).
 */


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kPrio0red 176.0f
#define kPrio0green 22.0f
#define kPrio0blue 8.0f

#define kPrio1red 239.0f
#define kPrio1green 146.0f
#define kPrio1blue 60.0f

#define kPrio2red 229.0f
#define kPrio2green 220.0f
#define kPrio2blue .0f

#define kPrio3red 84.0f
#define kPrio3green 146.0f
#define kPrio3blue 60.0f

#define kPrio4red 68.0f
#define kPrio4green 100.0f
#define kPrio4blue 187.0f

@interface CustomBadge : UIView {
	
	NSString *badgeText;
	UIColor *badgeTextColor;
	UIColor *badgeInsetColor;
	UIColor *badgeFrameColor;
	BOOL badgeFrame;
	BOOL badgeShining;
	CGFloat badgeCornerRoundness;
	CGFloat badgeScaleFactor;
}

@property(nonatomic,retain) NSString *badgeText;
@property(nonatomic,retain) UIColor *badgeTextColor;
@property(nonatomic,retain) UIColor *badgeInsetColor;
@property(nonatomic,retain) UIColor *badgeFrameColor;

@property(nonatomic,readwrite) BOOL badgeFrame;
@property(nonatomic,readwrite) BOOL badgeShining;

@property(nonatomic,readwrite) CGFloat badgeCornerRoundness;
@property(nonatomic,readwrite) CGFloat badgeScaleFactor;



+ (CustomBadge*) customBadgeWithString:(NSString *)badgeString;
+ (CustomBadge*) customBadgeWithString:(NSString *)badgeString withStringColor:(UIColor*)stringColor withInsetColor:(UIColor*)insetColor withBadgeFrame:(BOOL)badgeFrameYesNo withBadgeFrameColor:(UIColor*)frameColor withScale:(CGFloat)scale withShining:(BOOL)shining;

- (void) autoBadgeSizeWithString:(NSString *)badgeString;
+ (CustomBadge *) badgesButton : (int) number on:(UIView*) myView withoffset: (float) offset andColor : (UIColor*) color andTag:(int) tag;
+ (CustomBadge *) badgePriority:(int) number on:(UIView*) myView withoffset: (float) offset;
+ (NSString *) rechercheCategorie:(NSString*) num_affect;
+(CustomBadge *) badgePriority:(int) number on:(UIView*) myView withxpos:(float) xpos andyPos:(float) ypos;
+(CustomBadge *) addBadgeOn:(UIView*) onView withPriority:(int) number below:(UIView*) belowView withxpos:(float) xpos andyPos:(float) ypos;
+ (CustomBadge *) badgesButton : (int) number on:(UIView*) myView withxoffset: (float) xoffset andyoffset:(float) yoffset andColor : (UIColor*) color andTag:(int)tag;
@end
