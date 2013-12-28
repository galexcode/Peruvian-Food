#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Possession;

@interface HomepwnerItemCell : UITableViewCell
{
    UILabel *valueLabel;
    UILabel *nameLabel;
    UIImageView *imageView;
}

- (void)setPossession:(Possession *)possession;

@end
