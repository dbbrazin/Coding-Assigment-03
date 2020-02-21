# CIS-444
## Lecture 11 / HW-03 (Pt1)

## Build the Basic UI

It’s time to build a basic interface of your Caption App. You’ll start by working on a user interface for the scene that lets you add a Captioned View to your caption making app, CaptionThat.


### Part 1 Goals: 
* Edit the attributes of UI elements in a storyboard using the Attributes inspector
* View and rearrange UI elements using the outline view
* Preview a storyboard UI using the Assistant editor’s Preview mode
Use Auto Layout to lay out a UI that automatically adapts to the user’s device size


### To add a text field to your `CaptionedViewController` scene

1. Choose Editor > Canvas, and make sure Show Bounds Rectangles is selected.
This setting causes Interface Builder to draw a blue bounding box around all the views in the canvas. Many views and controls have transparent backgrounds, making it difficult to see their actual size. Layout bugs occur when the system resizes a view so that it’s either larger or smaller than you anticipate. Enabling this setting helps you understand exactly what’s going on in your view hierarchy.

2. Open the Object library.

   The Object library appears at the bottom of the utility area on the right side of Xcode. If you don’t see the Object library, click its button, which is the third button from the left in the library selector bar. (Alternatively, choose View > Utilities > Show Object Library.)

![inline 50%][Show Object Library]
  
 A list appears showing each object’s name, description, and visual representation

[Show Object Library]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/object_library_2x.png
"Show Object Library"

3. In the Object library, type `text field` in the filter field to find the Text Field object quickly
4. Drag a Text Field object from the Object library to your scene

![inline 50%][Drag a Text Field]

[Drag a Text Field]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_textfield_drag_2x.png
"Drag a Text Field"

> If necessary, zoom in by choosing Editor > Canvas > Zoom.

5. Drag the text field so that it’s positioned in the top half of the scene and aligned with the left margin in the scene.
Stop dragging the text field when it snaps to the left margin.

![inline 50%][Snaps]

[Snaps]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_textfield_place_2x.png
"snaps to the left margin"


6. If necessary, click the text field to reveal the [resize handles](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW60).
You resize a user interface element by dragging its resize handles, which are small white squares that appear on the element’s borders. You reveal an element’s resize handles by selecting it. In this case, the text field should already be selected because you just stopped dragging it. If your text field looks like the one below, you’re ready to resize it; if it doesn’t, select it on the canvas.

![inline 50%][Resize]

[Resize]: hhttps://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_textfield_resizehandles_2x.png


7. Resize the left and right edges of the text field until you see three vertical layout guides: the left margin alignment, the horizontal center alignment, and the right margin alignment.

![inline 50%][Margin Align]

[Margin Align]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_textfield_finalsize_2x.png

   Although you have the text field in your scene, there’s no instruction to the user about what to enter in the field. Use the text field’s placeholder text to prompt the user to enter a caption.


### To configure the text field’s placeholder text

1. With the text field selected, open the Attributes inspector in the utility area.  
   The [Attributes inspector](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW19) appears when you click the fourth button from the left in the inspector selector bar. It lets you edit the properties of an object in your storyboard.
  
  ![inline][Placeholder]
  
2. In the Attributes inspector, find the field labeled Placeholder and type `Enter caption`. 
> In a production app, any String that can be seen by the user (such as the text field’s placeholder text) should be localized. For more information, see [Build Apps for the World](https://developer.apple.com/internationalization/)

3. Press Return to display the new placeholder text in the text field.

   ![inline][AddText]
   
   While you’re editing the text field’s attributes, you can also edit the attributes of the system keyboard that’s displayed when a user selects the text field.

[Placeholder]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_inspector_attributes_2x.png
[AddText]: https://i.imgur.com/JDLU9dv.png

### To configure the text field’s keyboard

1. Make sure the text field is still selected
2. In the Attributes inspector, find the field labeled Return Key and select Done (scroll down if necessary).

This change will make the default Return key on the keyboard more pronounced to the user by changing it into a Done key.  

3. In the Attributes inspector, select the Auto-enable Return Key checkbox (again, scroll down if necessary).

This change makes it impossible for the user to tap the Done key before typing text into the text field, ensuring that users can never enter an empty string as a caption.

![inline][DoneKey]

[DoneKey]: https://i.imgur.com/yVHKn9v.png

Next, add a label (UILabel) at the top of the scene. A label isn’t interactive; it just displays static text in the user interface. To help you understand how to define interaction between elements in the user interface, you’ll configure this label to display the text the user enters into the text field. It’ll be a good way to test that the text field is taking the user input and processing it appropriately.

### To add a label to your scene 

(Review:) 
1. In the Object library, type label in the filter field to find the Label object quickly.

2. Drag a Label object from the Object library to your scene.

3. Drag the label so that it’s right above the text field and aligned with the left margin in the scene.
   Stop dragging the label when it snaps to the guidelines.

 
![inline][AddLabel]

[AddLabel]: https://i.imgur.com/gEqpi82.png

4. Double-click the label and type Caption

![inline][SetCaptionLabel]

[SetCaptionLabel]: https://i.imgur.com/FRvJDYU.png

5. Press Return to display the new text in the label.
  
   Now, add a button (UIButton) to the scene. A button is interactive, so users can tap it to trigger an action that you define. Later, you’ll create an action to reset the label text to a default value.

### To add a button to your scene

1. In the Object library, type button in the filter field to find the Button object quickly.
2. Drag a Button object from the Object library to your scene.
3. Drag the button so that it’s right below the text field and aligned with the left margin in the scene.
   Stop dragging the button when it snaps to the guidelines.

![inline][AddButton]

[AddButton]: https://media.giphy.com/media/KAvWjYWswGluZyB0ZC/giphy.gif

4. Double-click the button and type Set Default Label Text.
5. Press Return to display the new text in the button.
6. Reposition the button, if necessary.

![inline][SetDefaultText]

[SetDefaultText]: https://i.imgur.com/62zxiFU.png

It’s good to understand how the elements you’ve added are actually arranged in the scene. Look at the outline view to see which user interface elements have been added to your scene.

### To view the outline view

1. In your storyboard, find the outline view toggle.

![inline][OutlineView]

[OutlineView]: https://i.imgur.com/pLOkKND.png


2. If the toggle is collapsed, click the toggle to expand the outline view
   You can use the outline view toggle to collapse and expand the outline view as needed.

   The [outline view](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW56), which appears on the left side of the canvas, provides a hierarchical representation of the objects in    your storyboard. You should be able to see the text field, label, and button you just added listed in the hierarchy. But why are the user interface elements you added nested under View?  
   
   Views not only display themselves onscreen and react to user input, they can serve as containers for other views. Views are arranged in a hierarchical structure called the view hierarchy. The [view hierarchy](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW21) defines the layout of views relative to other views. Within that hierarchy, views enclosed within a view are called [subviews](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW22), and the parent view that encloses a view is called its [superview](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW67). A view can have multiple subviews and only one superview.

![inline][Hierarchy]

[Hierarchy]: https://i.imgur.com/TNitDOO.png

  In general, each scene has its own view hierarchy. At the top of each view hierarchy is a content view. In the current scene, the content view is named View, the top level view inside the View Controller. The text field, label, and button are subviews of the content view. All other views that you place in this scene will be subviews of this content view (although they themselves can have nested subviews).


## Preview Your Interface

Preview your app periodically to check that everything is looking the way you expect. You can preview your app interface using the [assistant editor](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW76), which displays a secondary editor side-by-side with your main one.

### To Preview Your Interface

1. Select CaptionedViewController scene in the Storyboard
2. Click the Assistant button in the Xcode toolbar near the top right corner of Xcode to open the assistant editor.

![inline][PreviewAssistant]

[PreviewAssistant]: https://media.giphy.com/media/M90vJMXrLBN39ARV4n/giphy.gif

    As you see in the assistant editor, the preview looks almost identical to the canvas. However, this does not really tell you anything new. Both the canvas and the preview are showing the same size screen and the same orientation (portrait). If you want to check and see if your interface is adaptive, you need to preview different size screens and different orientations.
    
3. To preview the landscape orientation, select a device the bottom left hand corner of the preview panel and portrait and landscape representation should appear

![inline][LandscapeFail]

[LandscapeFail]: https://media.giphy.com/media/Pllp1rx1pRdnB8UVSq/giphy.gif

Unfortunately, things no longer look quite right. The text field, label, and button keep the same size and position relative to the screen’s upper left corner. This means that the text field no longer fills the screen from margin to margin.

4. To select a smaller device than the default selection like iPhone 4S

![inline][Iphone4S]


   Again, the text field, label, and button keep the same size and position relative to the screen’s upper left corner. This time, however, the text field extends past the screen’s right edge.

[Iphone4S]: https://i.imgur.com/muFFn2H.png

To create an adaptive interface, you’ll need to specify how the interface should adjust to different screen sizes. For example, when the interface is rotated into a landscape orientation, the text field should grow. When the interface is displayed on an iPhone 4S, the text field should shrink. You can specify these kinds of interface rules easily using Auto Layout.


## Autolayout

[Auto Layout](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW77) is a powerful layout engine that helps you design adaptive layouts that dynamically respond to any changes to the scene’s size. You describe your layout using [constraints](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW78)—rules that explain where one element should be located relative to another, or what size the element should be. Auto Layout dynamically calculates the size and position of each element based on these constraints.

One of the easiest ways to define your layout is using a stack view (`UIStackView`). A stack view provides a streamlined interface for laying out a collection of views in either a column or a row. The stack view uses Auto Layout under the hood to calculate the size and position of all the views that it manages. This lets you easily access the full power of Auto Layout, while greatly reducing the complexity of your layout.

To adopt Auto Layout, wrap your existing interface elements in a stack view, and then add the constraints needed to position the stack view in the scene.

### To add Auto Layout constraints to the caption scene

1. Return to the standard editor by clicking the Standard button.

![inline][RegularEditor]

[RegularEditor]: https://i.imgur.com/jt0Scq7.png

2. Expand the project navigator and utility area by clicking the Editor Options and select Document Outline in the dropdown  

3. While pressing the Shift key on your keyboard, select the text field, label, and button. Or select the elements in the Document outline (my preference)

4. On the bottom right of the canvas, click the Embed In Stack button. (Alternatively, choose Editor > Embed In > Stack View.)

![inline][EmbedStack]

[EmbedStack]: https://media.giphy.com/media/fXcVghsuJteIwBMWbM/giphy.gif

   Xcode wraps the user interface elements in a stack view, stacking them together. Xcode analyzes your existing layout to figure out that the items should stack vertically, not horizontally.
   
5. If necessary, open the outline view. Select the Stack View object.

![inline][StackSelection]

[StackSelection]: https://i.imgur.com/1pIwVx4.png

6. In the Attributes inspector, type 10 in the Spacing field. Press Return.
You’ll notice the user interface elements space out vertically, and the stack view grows with them.

7. On the bottom right of the canvas, open the Add New Constraints menu.

![inline][AddConstraints]
[AddConstraints]: https://media.giphy.com/media/kEcpPsHpYxYXuGH9EF/giphy.gif

8. Above “Spacing to nearest neighbor,” click the two horizontal constraints and the top vertical constraint to select them. They become red when they are selected.

![inline][SelectConstraints]

[SelectConstraints]: https://media.giphy.com/media/UQ1qvyNMFcIsMg69VR/giphy.gif

These constraints indicate spacing to the nearest leading, trailing, and top neighbors. In this context, the term nearest neighbor means the boundary of the closest user interface element, which can be the superview, another user interface element, or a margin. Because the “Constrain to margins” checkbox is selected, the stack view in this case will be constrained to the superview’s left and right margins. This provides space between the stack view and the edge of the scene.
On the other hand, the top of the stack is constrained relative to the scene’s top layout guide. The top layout guide is positioned at the bottom of the status bar, if the status bar is visible. If not, it is positioned at the top of the scene. Therefore, you need to add a little space between the stack view and the layout guide.

9. Type 0 in the left and right boxes, and type 20 spacing in the top box.

10. In the pop-up menu next to Update Frames, choose Items of New Constraints. This causes Interface Builder to automatically update the frames of the affected views when you create the constraints.

![inline][AddConstraints]

[AddConstraints]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_AL_stackconstraints_2x.png


11. In the Add New Constraints menu, click the Add 3 Constraints button.

![inline][StackWithConstraints]
      The label, text field, and button are now left aligned and laid out with appropriate spacing, but the text field still isn’t stretching to fill the screen’s width. To fix that, you’ll need to add an additional constraint.


[StackWithConstraints]: https://i.imgur.com/44Fwo9N.png

### To adjust the text field width within the stack

1. In your storyboard, select the text field in the Captioned View Controller scene.
2. On the bottom right of the canvas, open the Add New Constraints menu again.

![inline][AddNewConstraints]

[AddNewConstraints]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/AL_pinmenu_2x.png

3. Above “Spacing to nearest neighbor,” click the right horizontal constraint to select it. It becomes red when it is selected.

4. Type 0 in the right box

![inline][RightHorizontal]

[RightHorizontal]: https://i.imgur.com/lfnIlw1.png

5. In the Add New Constraints menu, click the Add 1 Constraint button.

![inline][UpdatedTextfield]

[UpdatedTextfield]: https://i.imgur.com/yADmjZX.png


_Checkpoint: Run your app in iOS Simulator. Rotate the simulator by choosing Hardware > Rotate Left and Hardware > Rotate Right (or Command-Left Arrow and Command-Right Arrow). Notice how the text field grows and shrinks to the appropriate size depending on the device’s orientation and screen size. Also notice that the status bar disappears in landscape orientation._

Click inside the text field and enter text using the onscreen keyboard (if you’d like, you can use your computer’s keyboard by choosing Hardware > Keyboard > Connect Hardware Keyboard).


## Debugging Auto layout

If you don’t get the behavior you expect, use the Auto Layout debugging features to help you. These features can be accessed using the Update Frames button and Resolve Auto Layout Issues menu.

![inline][ResolveAutoLayout]

[ResolveAutoLayout]: https://i.imgur.com/lXAcIvM.png

If you are getting warnings about misplaced views, use the Update Frames button. This button updates the frames of the selected view and all of its subviews. Select the scene’s view controller to update all the views in the scene. You can also Option-click the Update Frames button to update only the selected view.

If the layout does not behave as you expect, click the Resolve Auto Layout Issues button to bring up a menu of debug commands. All the commands in this menu have two forms. One affects the currently selected view. The other affects all views in the current view controller. If all of the commands are grayed out, select the scene’s view controller or one of the views and open the menu again.

Choose Reset to Suggested Constraints to have Xcode update your interface with a valid set of constraints. Choose Clear Constraints to remove all constraints on the user interface elements, and then try following the previous instructions to set up the constraints again.

![inline][ResetConstraints]

[ResetConstraints]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_AL_resolvemenu_small_2x.png

