#import <Kiwi.h>
#import <RXPromise/RXPromise.h>

#define expectPromise(promise) [KWFutureObject futureObjectWithBlock:^id{ return promise.isPending ? nil : promise; }]
#define promiseResult(promise) [KWPromiseMatcher getValue:promise]

@interface KWPromiseMatcher : KWMatcher

+ (id)getValue:(RXPromise *)promise;

- (void)beResolved;
- (void)beRejected;
- (void)beFulfilled;
- (void)beCancelled;

@end
