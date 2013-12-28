#import "HomepwnerItemCell.h"
#import "Possession.h"

@implementation HomepwnerItemCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Create a subview - don't need to specify its position/size
        valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        // Put it on the content view of the cell
        [[self contentView] addSubview:valueLabel];
        
        // It is being retained by its superview
        [valueLabel release];
        
        // Same thing with the name 
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:nameLabel];
        [nameLabel release];
        
        // Same thing with the image view
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:imageView];
        
        // Tell the imageview to center its image inside its frame
        [imageView setContentMode:UIViewContentModeCenter];
        [imageView release];      
    }
    
    return self;
}

- (void)layoutSubviews
{
    // We always call this, the table view cell needs to do its own work first
    [super layoutSubviews];
    
    // We'll use this to add spacing between borders 
    float inset = 5.0;
    
    // How much space do we have to work with?
    CGRect bounds = [[self contentView] bounds];
    
    // Let's pull out of the height and width 
    // into easier-to-type variable names
    float h = bounds.size.height;
    float w = bounds.size.width;
    
    // This will be a constant value for the valueField's width 
    float valueWidth = 40.0;
    CGSize thumbnailSize = [Possession thumbnailSize];
    float imageSpace = h - thumbnailSize.height;
    CGRect imageFrame = CGRectMake(inset, imageSpace / 2.0, 
                                   thumbnailSize.width, 
                                   thumbnailSize.height);
    [imageView setFrame:imageFrame];
    
    // Create a rectangle in the middle for the name
    CGRect nameFrame = CGRectMake(imageFrame.size.width + imageFrame.origin.x + inset,
                                  inset, 
                                  w - (h + valueWidth + inset * 4.0), 
                                  h - inset * 2.0);
    [nameLabel setFrame:nameFrame];
    
    // Create a rectangle on the right side of the cell for the value
    CGRect valueFrame = CGRectMake(nameFrame.size.width + nameFrame.origin.x + inset, 
                                   inset, 
                                   valueWidth, 
                                   h - inset * 2.0);
    [valueLabel setFrame:valueFrame];
}

- (void)setPossession:(Possession *)possession
{
    // Using a Possession instance, we can set the values of the subviews
    [valueLabel setText:
     [NSString stringWithFormat:@"$%d", [possession valueInDollars]]];
    [nameLabel setText:[possession possessionName]];
    [imageView setImage:[possession thumbnail]];
}

@end
