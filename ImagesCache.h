//
//  ImagesCache.h
//  Ulmart
//
//  Created by mihael on 19.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagesCache : NSObject
{
    NSCache *imagesReal;
    NSCache *imagesScaled;
    NSCache *imagesScaledRetina;
}

-(id)init;

@end
