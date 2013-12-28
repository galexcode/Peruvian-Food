#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PreparationCell : UITableViewCell
{

    IBOutlet UIView *view;
    
    IBOutlet UILabel *step;
    IBOutlet UITextView *direction;
}
@property (nonatomic, strong) UILabel *step;
@property (nonatomic, strong) UITextView *direction;


@end
