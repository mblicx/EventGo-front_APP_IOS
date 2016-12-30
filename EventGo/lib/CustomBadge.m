/*
 CustomBadge.m
 
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


#import "CustomBadge.h"

@interface CustomBadge()
- (void) drawRoundedRectWithContext:(CGContextRef)context withRect:(CGRect)rect;
- (void) drawFrameWithContext:(CGContextRef)context withRect:(CGRect)rect;
@end

@implementation CustomBadge

@synthesize badgeText;
@synthesize badgeTextColor;
@synthesize badgeInsetColor;
@synthesize badgeFrameColor;
@synthesize badgeFrame;
@synthesize badgeCornerRoundness;
@synthesize badgeScaleFactor;
@synthesize badgeShining;


+ (CustomBadge *) badgesButton : (int) number on:(UIView*) myView withoffset: (float) offset andColor : (UIColor*) color andTag:(int)tag {
    CustomBadge *customBadge = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d",number]
                                                  withStringColor:[UIColor whiteColor]
                                                   withInsetColor:color
                                                   withBadgeFrame:YES
                                              withBadgeFrameColor:[UIColor whiteColor]
                                                        withScale:1.0
                                                      withShining:YES];
    [customBadge setFrame:CGRectMake(myView.frame.size.width-customBadge.frame.size.width+offset,
                                     3,customBadge.frame.size.width,customBadge.frame.size.height)];
    customBadge.tag = tag;
    [myView addSubview:customBadge];
    return customBadge;
}

+ (CustomBadge *) badgesButton : (int) number on:(UIView*) myView withxoffset: (float) xoffset andyoffset:(float) yoffset andColor : (UIColor*) color andTag:(int)tag {
    CustomBadge *customBadge = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d",number]
                                                  withStringColor:[UIColor whiteColor]
                                                   withInsetColor:color
                                                   withBadgeFrame:YES
                                              withBadgeFrameColor:[UIColor whiteColor]
                                                        withScale:1.0
                                                      withShining:NO];
    [customBadge setFrame:CGRectMake(myView.frame.size.width-customBadge.frame.size.width+xoffset,
                                     yoffset,customBadge.frame.size.width,customBadge.frame.size.height)];
    customBadge.tag = tag;
    [myView addSubview:customBadge];
    return customBadge;
}



+(CustomBadge *) badgePriority:(int) number on:(UIView*) myView withoffset: (float) offset {
    
    UIColor * InsetColor;
    switch (number) {
        case 0:
            InsetColor = [UIColor colorWithRed:kPrio0red/255.0f green:kPrio0green/255.0f blue:kPrio0blue/255.0f alpha:1.0];
            break;
        case 1:
            InsetColor = [UIColor colorWithRed:kPrio1red/255.0f green:kPrio1green/255.0f blue:kPrio1blue/255.0f alpha:1.0];
            break;
        case 2:
            InsetColor = [UIColor colorWithRed:kPrio2red/255.0f green:kPrio2green/255.0f blue:kPrio2blue/255.0f alpha:1.0];
            break;
        case 3:
            InsetColor = [UIColor colorWithRed:kPrio3red/255.0f green:kPrio3green/255.0f blue:kPrio3blue/255.0f alpha:1.0];
            break;
        default:
            InsetColor = [UIColor colorWithRed:kPrio4red/255.0f green:kPrio4green/255.0f blue:kPrio4blue/255.0f alpha:1.0];
            break;
    }
    
    CustomBadge *customBadge = [CustomBadge customBadgeWithString:@""
                                                  withStringColor:[UIColor whiteColor]
                                                   withInsetColor:InsetColor
                                                   withBadgeFrame:YES
                                              withBadgeFrameColor:[UIColor whiteColor]
                                                        withScale:1.0
                                                      withShining:YES];
    [customBadge setFrame:CGRectMake(0+offset,
                                     3,customBadge.frame.size.width,customBadge.frame.size.height)];
    customBadge.tag = 45;
    [myView addSubview:customBadge];
    return customBadge;
}

+(CustomBadge *) badgePriority:(int) number on:(UIView*) myView withxpos:(float) xpos andyPos:(float) ypos {
    
    UIColor * InsetColor;
    switch (number) {
        case 0:
            InsetColor = [UIColor colorWithRed:kPrio0red/255.0f green:kPrio0green/255.0f blue:kPrio0blue/255.0f alpha:1.0];
            break;
        case 1:
            InsetColor = [UIColor colorWithRed:kPrio1red/255.0f green:kPrio1green/255.0f blue:kPrio1blue/255.0f alpha:1.0];
            break;
        case 2:
            InsetColor = [UIColor colorWithRed:kPrio2red/255.0f green:kPrio2green/255.0f blue:kPrio2blue/255.0f alpha:1.0];
            break;
        case 3:
            InsetColor = [UIColor colorWithRed:kPrio3red/255.0f green:kPrio3green/255.0f blue:kPrio3blue/255.0f alpha:1.0];
            break;
        default:
            InsetColor = [UIColor colorWithRed:kPrio4red/255.0f green:kPrio4green/255.0f blue:kPrio4blue/255.0f alpha:1.0];
            break;
    }
    
    CustomBadge *customBadge = [CustomBadge customBadgeWithString:@""
                                                  withStringColor:[UIColor whiteColor]
                                                   withInsetColor:InsetColor
                                                   withBadgeFrame:YES
                                              withBadgeFrameColor:[UIColor whiteColor]
                                                        withScale:1.0
                                                      withShining:YES];
    [customBadge setFrame:CGRectMake(xpos,
                                     ypos,customBadge.frame.size.width,customBadge.frame.size.height)];
    customBadge.tag = 45;
    [myView addSubview:customBadge];
    return customBadge;
}

+(CustomBadge *) addBadgeOn:(UIView*) onView withPriority:(int) number below:(UIView*) belowView withxpos:(float) xpos andyPos:(float) ypos {
    
    UIColor * InsetColor;
    switch (number) {
        case 0:
            InsetColor = [UIColor colorWithRed:kPrio0red/255.0f green:kPrio0green/255.0f blue:kPrio0blue/255.0f alpha:1.0];
            break;
        case 1:
            InsetColor = [UIColor colorWithRed:kPrio1red/255.0f green:kPrio1green/255.0f blue:kPrio1blue/255.0f alpha:1.0];
            break;
        case 2:
            InsetColor = [UIColor colorWithRed:kPrio2red/255.0f green:kPrio2green/255.0f blue:kPrio2blue/255.0f alpha:1.0];
            break;
        case 3:
            InsetColor = [UIColor colorWithRed:kPrio3red/255.0f green:kPrio3green/255.0f blue:kPrio3blue/255.0f alpha:1.0];
            break;
        default:
            InsetColor = [UIColor colorWithRed:kPrio4red/255.0f green:kPrio4green/255.0f blue:kPrio4blue/255.0f alpha:1.0];
            break;
    }
    
    CustomBadge *customBadge = [CustomBadge customBadgeWithString:@""
                                                  withStringColor:[UIColor whiteColor]
                                                   withInsetColor:InsetColor
                                                   withBadgeFrame:YES
                                              withBadgeFrameColor:[UIColor whiteColor]
                                                        withScale:1.0
                                                      withShining:YES];
    [customBadge setFrame:CGRectMake(xpos,ypos,customBadge.frame.size.width,customBadge.frame.size.height)];
    customBadge.tag = 45;
    [ onView insertSubview:customBadge belowSubview:belowView];
    return customBadge;
}


+(NSString *) rechercheCategorie:(NSString*) num_affect {
    
    NSString * categorieRet = @"";
    
    
    for (NSDictionary* myDictio in [[NSUserDefaults standardUserDefaults] objectForKey:@"arrayOfCategories"]) {
        
        if ([[myDictio objectForKey:@"prochaine_vue"] isEqualToString:@"notes"]) {
            NSArray* myArray = [num_affect componentsSeparatedByString:@"_"];
            if ([[myArray lastObject] isEqualToString:[myDictio objectForKey:@"type"]]){
                categorieRet = [myArray lastObject];
                break;
            }
        }
        else {
            NSString * categorie = [myDictio objectForKey:@"type"];
            for (NSDictionary * myInterlocuteur in [myDictio objectForKey:@"interlocuteurs"]){
                if ([[myInterlocuteur objectForKey:@"num_affectation"] isEqualToString:num_affect]){
                    categorieRet = categorie;
                    break;
                }
            }
        }
    }
    return categorieRet;
}


// I recommend to use the allocator customBadgeWithString
- (id) initWithString:(NSString *)badgeString withScale:(CGFloat)scale withShining:(BOOL)shining
{
	self = [super initWithFrame:CGRectMake(0, 0, 25, 25)];
	if(self!=nil) {
		self.contentScaleFactor = [[UIScreen mainScreen] scale];
		self.backgroundColor = [UIColor clearColor];
		self.badgeText = badgeString;
		self.badgeTextColor = [UIColor whiteColor];
		self.badgeFrame = YES;
		self.badgeFrameColor = [UIColor whiteColor];
		self.badgeInsetColor = [UIColor redColor];
		self.badgeCornerRoundness = 0.4;
		self.badgeScaleFactor = scale;
		self.badgeShining = shining;
		[self autoBadgeSizeWithString:badgeString];		
	}
	return self;
}

// I recommend to use the allocator customBadgeWithString
- (id) initWithString:(NSString *)badgeString withStringColor:(UIColor*)stringColor withInsetColor:(UIColor*)insetColor withBadgeFrame:(BOOL)badgeFrameYesNo withBadgeFrameColor:(UIColor*)frameColor withScale:(CGFloat)scale withShining:(BOOL)shining 
{
	self = [super initWithFrame:CGRectMake(0, 0, 25, 25)];
	if(self!=nil) {
		self.contentScaleFactor = [[UIScreen mainScreen] scale];
		self.backgroundColor = [UIColor clearColor];
		self.badgeText = badgeString;
		self.badgeTextColor = stringColor;
		self.badgeFrame = badgeFrameYesNo;
		self.badgeFrameColor = frameColor;
		self.badgeInsetColor = insetColor;
		self.badgeCornerRoundness = 0.40;	
		self.badgeScaleFactor = scale;
		self.badgeShining = shining;
		[self autoBadgeSizeWithString:badgeString];
	}
	return self;
}


// Use this method if you want to change the badge text after the first rendering 
- (void) autoBadgeSizeWithString:(NSString *)badgeString
{
	CGSize retValue;
	CGFloat rectWidth, rectHeight;
    CGSize stringSize = [badgeString sizeWithAttributes:
                         @{NSFontAttributeName: [UIFont systemFontOfSize:12]}];
   // sizeWithFont:[UIFont boldSystemFontOfSize:12]
	CGFloat flexSpace;
	if ([badgeString length]>=2) {
		flexSpace = [badgeString length];
		rectWidth = 25 + (stringSize.width + flexSpace); rectHeight = 25;
		retValue = CGSizeMake(rectWidth*badgeScaleFactor, rectHeight*badgeScaleFactor);
	} else {
		retValue = CGSizeMake(25*badgeScaleFactor, 25*badgeScaleFactor);
	}
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, retValue.width, retValue.height);
	self.badgeText = badgeString;
	[self setNeedsDisplay];
}


// Creates a Badge with a given Text 
+ (CustomBadge*) customBadgeWithString:(NSString *)badgeString
{
	return [[self alloc] initWithString:badgeString withScale:1.0 withShining:YES];
}


// Creates a Badge with a given Text, Text Color, Inset Color, Frame (YES/NO) and Frame Color 
+ (CustomBadge*) customBadgeWithString:(NSString *)badgeString withStringColor:(UIColor*)stringColor withInsetColor:(UIColor*)insetColor withBadgeFrame:(BOOL)badgeFrameYesNo withBadgeFrameColor:(UIColor*)frameColor withScale:(CGFloat)scale withShining:(BOOL)shining
{
	return [[self alloc] initWithString:badgeString withStringColor:stringColor withInsetColor:insetColor withBadgeFrame:badgeFrameYesNo withBadgeFrameColor:frameColor withScale:scale withShining:shining];
}



 

// Draws the Badge with Quartz
-(void) drawRoundedRectWithContext:(CGContextRef)context withRect:(CGRect)rect
{
	CGContextSaveGState(context);
	
	CGFloat radius = CGRectGetMaxY(rect)*self.badgeCornerRoundness;
	CGFloat puffer = CGRectGetMaxY(rect)*0.10;
	CGFloat maxX = CGRectGetMaxX(rect) - puffer;
	CGFloat maxY = CGRectGetMaxY(rect) - puffer;
	CGFloat minX = CGRectGetMinX(rect) + puffer;
	CGFloat minY = CGRectGetMinY(rect) + puffer;
		
    CGContextBeginPath(context);
	CGContextSetFillColorWithColor(context, [self.badgeInsetColor CGColor]);
	CGContextAddArc(context, maxX-radius, minY+radius, radius, M_PI+(M_PI/2), 0, 0);
	CGContextAddArc(context, maxX-radius, maxY-radius, radius, 0, M_PI/2, 0);
	CGContextAddArc(context, minX+radius, maxY-radius, radius, M_PI/2, M_PI, 0);
	CGContextAddArc(context, minX+radius, minY+radius, radius, M_PI, M_PI+M_PI/2, 0);
	CGContextSetShadowWithColor(context, CGSizeMake(0.0,0.0), 0, [[UIColor blackColor] CGColor]);
    CGContextFillPath(context);

	CGContextRestoreGState(context);

}

// Draws the Badge Shine with Quartz
-(void) drawShineWithContext:(CGContextRef)context withRect:(CGRect)rect
{
	CGContextSaveGState(context);
 
	CGFloat radius = CGRectGetMaxY(rect)*self.badgeCornerRoundness;
	CGFloat puffer = CGRectGetMaxY(rect)*0.10;
	CGFloat maxX = CGRectGetMaxX(rect) - puffer;
	CGFloat maxY = CGRectGetMaxY(rect) - puffer;
	CGFloat minX = CGRectGetMinX(rect) + puffer;
	CGFloat minY = CGRectGetMinY(rect) + puffer;
	CGContextBeginPath(context);
	CGContextAddArc(context, maxX-radius, minY+radius, radius, M_PI+(M_PI/2), 0, 0);
	CGContextAddArc(context, maxX-radius, maxY-radius, radius, 0, M_PI/2, 0);
	CGContextAddArc(context, minX+radius, maxY-radius, radius, M_PI/2, M_PI, 0);
	CGContextAddArc(context, minX+radius, minY+radius, radius, M_PI, M_PI+M_PI/2, 0);
	CGContextClip(context);
	
	
	size_t num_locations = 2;
	CGFloat locations[2] = { 0.0, 0.4 };
	CGFloat components[8] = {  0.92, 0.92, 0.92, 1.0, 0.82, 0.82, 0.82, 0.4 };

	CGColorSpaceRef cspace;
	CGGradientRef gradient;
	cspace = CGColorSpaceCreateDeviceRGB();
	gradient = CGGradientCreateWithColorComponents (cspace, components, locations, num_locations);
	
	CGPoint sPoint, ePoint;
	sPoint.x = 0;
	sPoint.y = 0;
	ePoint.x = 0;
	ePoint.y = maxY;
	CGContextDrawLinearGradient (context, gradient, sPoint, ePoint, 0);
	
	CGColorSpaceRelease(cspace);
	CGGradientRelease(gradient);
	
	CGContextRestoreGState(context);	
}


// Draws the Badge Frame with Quartz
-(void) drawFrameWithContext:(CGContextRef)context withRect:(CGRect)rect
{
	CGFloat radius = CGRectGetMaxY(rect)*self.badgeCornerRoundness;
	CGFloat puffer = CGRectGetMaxY(rect)*0.10;
	
	CGFloat maxX = CGRectGetMaxX(rect) - puffer;
	CGFloat maxY = CGRectGetMaxY(rect) - puffer;
	CGFloat minX = CGRectGetMinX(rect) + puffer;
	CGFloat minY = CGRectGetMinY(rect) + puffer;
	
	
    CGContextBeginPath(context);
	CGFloat lineSize = 2;
	if(self.badgeScaleFactor>1) {
		lineSize += self.badgeScaleFactor*0.25;
	}
	CGContextSetLineWidth(context, lineSize);
	CGContextSetStrokeColorWithColor(context, [self.badgeFrameColor CGColor]);
	CGContextAddArc(context, maxX-radius, minY+radius, radius, M_PI+(M_PI/2), 0, 0);
	CGContextAddArc(context, maxX-radius, maxY-radius, radius, 0, M_PI/2, 0);
	CGContextAddArc(context, minX+radius, maxY-radius, radius, M_PI/2, M_PI, 0);
	CGContextAddArc(context, minX+radius, minY+radius, radius, M_PI, M_PI+M_PI/2, 0);
	CGContextClosePath(context);
	CGContextStrokePath(context);
}


- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self drawRoundedRectWithContext:context withRect:rect];
	
	if(self.badgeShining) {
		[self drawShineWithContext:context withRect:rect];
	}
	
	if (self.badgeFrame)  {
		[self drawFrameWithContext:context withRect:rect];
	}
	
	if ([self.badgeText length]>0) {
		[badgeTextColor set];
		CGFloat sizeOfFont = 13.5*badgeScaleFactor;
		if ([self.badgeText length]<2) {
			sizeOfFont += sizeOfFont*0.20;
		}
		UIFont *textFont = [UIFont boldSystemFontOfSize:sizeOfFont];
		CGSize textSize = [self.badgeText sizeWithFont:textFont];
		[self.badgeText drawAtPoint:CGPointMake((rect.size.width/2-textSize.width/2), (rect.size.height/2-textSize.height/2)) withFont:textFont];
	}
	
}

- (void)dealloc {
}


@end
