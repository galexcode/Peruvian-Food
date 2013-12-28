#import "PreparationCell.h"


@implementation PreparationCell
@synthesize direction,step;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"PreparationCell" owner:self options:nil];
        self.backgroundView = view;
    }
    return self;
}




@end
