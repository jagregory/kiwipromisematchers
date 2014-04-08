//
// Created by James Gregory on 4/04/2014.
// Copyright (c) 2014 James Gregory. All rights reserved.
//

#import "KWPromiseMatcher.h"

@implementation KWPromiseMatcher {
    BOOL resolved;
    BOOL rejected;
    BOOL fulfilled;
    BOOL cancelled;
}

+ (id)getValue:(RXPromise *)promise {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    __block id result = nil;

    promise.then(^id(id r) {
        result = r;
        dispatch_semaphore_signal(sema);
        return nil;
    }, ^id(id error) {
        result = error;
        dispatch_semaphore_signal(sema);
        return nil;
    });

    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }

    return result;
}

+ (NSArray *)matcherStrings {
    return @[@"beResolved", @"beRejected", @"beFulfilled", @"beCancelled"];
}

- (BOOL)evaluate {
    if (![self.subject isKindOfClass:[RXPromise class]]) {
         return NO;
    }

    RXPromise *promise = (RXPromise *)self.subject;

    return (resolved && !promise.isPending) ||
            (rejected && promise.isRejected) ||
            (fulfilled && promise.isFulfilled) ||
            (cancelled && promise.isCancelled);
}

- (NSString *)failureMessageForShould {
    if (resolved) {
        return @"expected promise to be resolved";
    }

    if (rejected) {
        return @"expected promise to be rejected";
    }

    if (fulfilled) {
        return @"expected promise to be fulfilled";
    }

    if (cancelled) {
        return @"expected promise to be cancelled";
    }

    return @"I don't know what I expected the promise to be";
}

- (NSString *)failureMessageForShouldNot {
    if (resolved) {
        return @"expected promise to not be resolved";
    }

    if (rejected) {
        return @"expected promise to not be rejected";
    }

    if (fulfilled) {
        return @"expected promise to not be fulfilled";
    }

    if (cancelled) {
        return @"expected promise to not be cancelled";
    }

    return @"I don't know what I expected the promise to not be";
}

- (void)beResolved {
    resolved = YES;
}

- (void)beRejected {
    rejected = YES;
}

- (void)beFulfilled {
    fulfilled = YES;
}

- (void)beCancelled {
    cancelled = YES;
}

@end
