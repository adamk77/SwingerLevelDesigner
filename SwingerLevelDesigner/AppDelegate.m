//
//  AppDelegate.m
//  SwingerLevelDesigner
//
//  Created by Min Kwon on 5/24/12.
//  Copyright (c) 2012 GAMEPEONS, LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "StretchView.h"
#import "GameObject.h"
#import "SetCanvasSizeWindowController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize xPosition;
@synthesize yPosition;
@synthesize gameWorldSize;
@synthesize position;
@synthesize swingSpeed;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)showOpenPanel:(id)sender {
    [stretchView unselectAllGameObjects];
    __block NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setAllowedFileTypes:[NSImage imageFileTypes]];
    [panel beginSheetModalForWindow:[stretchView window] 
                  completionHandler:^ (NSInteger result) {
                      
        if (result == NSOKButton) {
            GameObject *image = [[GameObject alloc] initWithContentsOfURL:[panel URL]];
            [stretchView addGameObject:image];
        }
        panel = nil;
     }];
}

- (void) awakeFromNib {
    CGRect frame = [stretchView frame];
    [gameWorldSize setStringValue:[NSString stringWithFormat:@"Game World Size (%.2f, %.2f)", frame.size.width, frame.size.height]]; 
}

- (IBAction)addPole:(id)sender {
    [stretchView unselectAllGameObjects];
    GameObject *image = [[GameObject alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SwingPole1" ofType:@"png"]];
    image.gameObjectType = kGameObjectTypeSwinger;
    [stretchView addGameObject:image];
}

- (void) controlTextDidEndEditing:(NSNotification *)obj {
    NSTextField *textField = (NSTextField*)[obj object];
    

    if (textField == xPosition || textField == yPosition) {
        [stretchView updateSelectedPosition:CGPointMake([xPosition floatValue], [yPosition floatValue])];
    } else if (textField == swingSpeed) {
        [stretchView updateSelectedSwingSpeed:[swingSpeed floatValue]];
    }
}

- (IBAction)resizeCanvas:(id)sender {
    SetCanvasSizeWindowController *w = [[SetCanvasSizeWindowController alloc] initWithWindowNibName:@"SetCanvasSizeWindowController"];
    
    w.width = [stretchView frame].size.width;
    w.height = [stretchView frame].size.height;
    w.deviceScreenWidth = stretchView.deviceScreenWidth;
    w.deviceScreenHeight = stretchView.deviceScreenHeight;

    // Show document sheet
    [NSApp beginSheet:[w window] 
       modalForWindow:[self window] 
        modalDelegate:nil 
       didEndSelector:nil 
          contextInfo:nil];
    
    int acceptedModal = (int)[NSApp runModalForWindow:[w window]];
    
    [NSApp endSheet:[w window]];
    [[w window] close];
    
    
    if (acceptedModal) {
        CGFloat width = [w.widthField floatValue];
        CGFloat height = [w.heightField floatValue];
        CGRect newFrame = CGRectMake(0.f, 0.f, width, height);
        [stretchView setFrame:newFrame];
        
        stretchView.deviceScreenWidth = [w.deviceWidthField floatValue];
        stretchView.deviceScreenHeight = [w.deviceHeightField floatValue];
    }
    
}

@end
