//
//  PNMacros.h
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 14/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#ifndef PNMacros_h
#define PNMacros_h

#define PNWeakObject(object,weakObject)    __weak __typeof__(object) weakObject = object;
#define PNWeakSelf(weakSelf)    PNWeakObject(self,weakSelf);

// UIColor
#define UIColorFromHex(hexValue) \
[UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((hexValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#endif /* PNMacros_h */
