//
//  ImagesCache.m
//  Ulmart
//
//  Created by mihael on 19.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import "ImagesCache.h"

@implementation ImagesCache

-(id)init
{
    imagesReal = [[NSCache alloc] init];
    imagesScaled = [[NSCache alloc] init];
    imagesScaledRetina = [[NSCache alloc] init];
    return self;
}

-(UIImage*)imageWithArticul:(NSString*)articul
                    toIndex:(int)index
{
    NSString *imageName = [NSString stringWithFormat:@"http://fast.ulmart.ru/good_big_pics/%@.jpg", articul];
    NSCache *imagesCache = ([CommonHelper isRetina])?imagesBig2:imagesBig;
    UIImage *image = [imagesCache objectForKey:imageName];
    if (image)
        return image;
    else
    {
        FXImageView *view = (FXImageView*)[_carousel itemViewAtIndex:index];//[imagesTableView viewAtIndex:index];
        if (view)
            view.image = [UIImage imageNamed:@"placeholder.png"];
        // the get the image in the background
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            // get the UIImage
            UIImage *image = [imagesReal objectForKey:imageName];
            CGSize imageSize = ([CommonHelper isRetina])?CGSizeMake(360, 360):CGSizeMake(180, 180);
            if(!image)
                image = [self getImageWithName:[self makeImageNameWithArticul:articul andType:ULItemsImageCacheReal] andExtension:@"jpg"];
            if(!image) // if we not found it, then download it!
                @try {
                    image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]]];
                    [self saveImage:image toFileWithName:[self makeImageNameWithArticul:articul andType:ULItemsImageCacheReal] andExtension:@"jpg"];
                }
            @catch (NSException *exception) {
                NSLog(@"Error download image: %@", imageName);
            }
            if(image) // if we found it, then update UI and add it to cache
            {
                UIImage *scaledImage = [CommonHelper imageWithImage:image scaledToSize:imageSize];
                [imagesReal setObject:image forKey:imageName];
                if(imagesCache)
                    [imagesCache setObject:scaledImage forKey:imageName];
                dispatch_async(dispatch_get_main_queue(), ^{ // if the cell is visible, then set the image
                    @try{
                        FXImageView *view = (FXImageView*)[_carousel itemViewAtIndex:index];//[imagesTableView viewAtIndex:index];
                        if (view)
                            view.image = scaledImage;
                    }
                    @catch (NSException *exception) {
                        NSLog(@"scale image exception: %@", exception);
                    }
                });
            }
        });
    }
    return [UIImage imageNamed:@"placeholder.png"];
}

-(NSString*)makeImageNameWithArticul:(NSString*)articul
                             andType:(NSString*)type
{
    return [NSString stringWithFormat:@"%@_%@", type, articul];
}

-(void)saveImage:(UIImage*)image toFileWithName:(NSString*)name andExtension:(NSString*)extension
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileWithPathAndExtension = [directory stringByAppendingFormat:@"%@.%@", name, extension];
    if([extension isEqualToString:@"png"])
        [UIImagePNGRepresentation(image) writeToFile:fileWithPathAndExtension atomically:YES];
    else
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:fileWithPathAndExtension atomically:YES];
}

- (UIImage*)getImageWithName:(NSString*)name andExtension:(NSString*)extension
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileWithPathAndExtension = [directory stringByAppendingFormat:@"%@.%@", name, extension];
    return [UIImage imageWithContentsOfFile:fileWithPathAndExtension];
}

@end
