//
//  StretchView.h
//  SwingerLevelDesigner
//
//  Created by Min Kwon on 5/24/12.
//  Copyright (c) 2012 GAMEPEONS, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GameObject.h"

@interface StretchView : NSView<NSTextDelegate, NSTableViewDataSource, NSTableViewDelegate> {
    NSBezierPath *path;
    NSMutableArray *gameObjects;
    NSMutableArray *sortedArray;
    float opacity;
    NSPoint downPoint;
    NSPoint currentPoint;
    CGFloat scale;
    CGFloat deviceScreenHeight;
    CGFloat deviceScreenWidth;
    
    CGRect selectionRect;
    BOOL startSelection;
}


- (void) addGameObject:(GameObject*)gameObject isSelected:(BOOL)selected;
- (GameObject*) getSelectedGameObject;

- (void) unselectAllGameObjects;
- (void) loadLevel:(NSArray*)levelItems;
- (void) clearCanvas;
- (GameObject*) getLastGameObject;
- (NSArray*) levelForSerialization;
- (void) updateSelectedGameObject;
- (void) sortGameObjectsByZOrder;

- (IBAction)zoomIn:(id)sender;
- (IBAction)zoomOut:(id)sender;
- (IBAction)resetZoom:(id)sender;

@property (assign) float opacity;
@property (assign) CGFloat deviceScreenHeight;
@property (assign) CGFloat deviceScreenWidth;
//@property (strong) NSMutableArray *gameObjects;

@end
