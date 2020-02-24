
## CIS-444: Coding Assignment 03
### Due End of Day Friday. 2/28

## Learning Objectives

At the end of the lesson, you’ll be able to:

* Understand the view controller life cycle methods (for example, viewDidLoad, `viewWillAppear` and `viewDidAppear`) 
* Use view controller life methods to configure your view controller’s content
* A more detailed understanding of UIImagePicker
* Dismiss a view controller
* Use gesture recognizers to generate events
* Anticipate object behavior based on the UIView/UIControl class hierarchy
* Use the asset catalog to add image assets to a project


## Understand the View Controller Lifecycle

So far, the CaptionThat app has multiple scene, whose user interface is managed by a navigation  controller. As you build more complex apps, you’ll create more scenes, and will need to manage loading and unloading views as they’re moved on and off the screen.

An object of the `UIViewController` class (and its subclasses) comes with a set of methods that manage its view hierarchy. iOS automatically calls these methods at appropriate times when a view controller transitions between states. When you create a view controller subclass (like the `CaptionedViewController` class you’ve been working with), it inherits the methods defined in UIViewController and lets you add your own custom behavior for each method. It’s important to understand when the system calls these methods, so you can set up or tear down the views you’re displaying at the appropriate step in the process—something you’ll need to do later in the lessons.

![inline][VCLifeCycle]

[VCLifeCycle]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/WWVC_vclife_2x.png

iOS calls the `UIViewController` methods as follows:

* `viewDidLoad()` - Called when the view controller’s content view (the top of its view hierarchy) is created and loaded from a storyboard. The view controller’s outlets are guaranteed to have valid values by the time this method is called. Use this method to perform any additional setup required by your view controller.
* Typically, iOS calls `viewDidLoad()` only once, when its content view is first created; however, the content view is not necessarily created when the controller is first instantiated. Instead, it is lazily created the first time the system or any code accesses the controller’s view property.

* `viewWillAppear()` — Called just before the view controller’s content view is added to the app’s view hierarchy. Use this method to trigger any operations that need to occur before the content view is presented onscreen. Despite the name, just because the system calls this method, it does not guarantee that the content view will become visible. The view may be obscured by other views or hidden. This method simply indicates that the content view is about to be added to the app’s view hierarchy.

* `viewDidAppear()` — Called just after the view controller’s content view has been added to the app’s view hierarchy. Use this method to trigger any operations that need to occur as soon as the view is presented onscreen, such as fetching data or showing an animation. Despite the name, just because the system calls this method, it does not guarantee that the content view is visible. The view may be obscured by other views or hidden. This method simply indicates that the content view has been added to the app’s view hierarchy.

* `viewWillDisappear()` — Called just before the view controller’s content view is removed from the app’s view hierarchy. Use this method to perform cleanup tasks like committing changes or resigning the first responder status. Despite the name, the system does not call this method just because the content view will be hidden or obscured. This method is only called when the content view is about to be removed from the app’s view hierarchy.

* `viewDidDisappear()` — Called just after the view controller’s content view has been removed from the app’s view hierarchy. Use this method to perform additional teardown activities. Despite the name, the system does not call this method just because the content view has become hidden or obscured. This method is only called when the content view has been removed from the app’s view hierarchy.

You’ll be using some of these methods in the CaptionThat app to load and display your data. In fact, if you recall, you’ve already written some code in the viewDidLoad() method of `CaptionedViewController`:


```swift
override func viewDidLoad() {
super.viewDidLoad()

// Handle the text field’s user input through delegate callbacks.
captionTextField.delegate = self

}
```

This style of app design where view controllers serve as the communication pipeline between your views and your data model is known as [MVC (Model-View-Controller)](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW52). In this pattern, models keep track of your app’s data, views display your user interface and make up the content of an app, and controllers manage your views. By responding to user actions and populating views with content from the data model, controllers serve as a gateway for communication between the model and views. MVC is central to a good design for any iOS app, and so far, the `CaptionThat` app has been built along MVC principles.

As you keep the MVC pattern in mind for rest of the app’s design, it’s time to take your basic user interface to the next level, and display an image in the Captioned scene

# Add a Photo to caption

The next step in finishing the captioned scene is adding a way to display a photo a user may want to caption. For this, you’ll use an image view (UIImageView), a user interface element that displays a picture.

## To add an image view to your scene

1.  Open your [storyboard](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW8), `Main.storyboard`.

2. Open the [Object library](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW54) in the [utility area](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW72). (Alternatively, choose View > Utilities > Show Object Library.)

3. In the Object library, type image view in the filter field to find the Image View object quickly.

4. Drag an Image View object from the Object library to your scene so that it’s in the stack view below the button.

5. With the image view selected, open the Size inspector in the utility area

Recall that the [Size inspector](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW82) appears when you select the fifth (or sixth depending on Xcode version) button from the left in the inspector selector bar. It lets you edit the size and position of an object in your storyboard.

![inline][SizeInspector]

[SizeInspector]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/WWVC_inspector_size_2x.png

6. In the Intrinsic Size field, select Placeholder. (This field is at the bottom of the Size inspector, so you’ll need to scroll down to it.)

7. Type `320` in both the Width and Height fields. Press Return.

![inline][InstrinsicSize]

[InstrinsicSize]: https://i.imgur.com/vyau2S4.png

A view’s [intrinsic content size](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW110) is the preferred size for the view based on its content. An empty image view doesn’t have an intrinsic content size. As soon as you add an image to a view, its intrinsic content size is set to the image’s size. Providing a placeholder size gives the image a temporary intrinsic content size that you can use while designing your user interface. This value is only used while designing your interface in Interface Builder; at runtime, the layout engine uses the view’s actual intrinsic content size instead.

![inline][InstrinsicSize2]

[InstrinsicSize2]:https://i.imgur.com/n95M54n.png


8. On the bottom right of the canvas, open the Pin menu.

![inline][PinMenu]


[PinMenu]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/AL_pinmenu_2x.png

9. Select the checkbox next to Aspect Ratio.


10. 

![inline][AddNewConstraints_]

[AddNewConstraints_]:https://i.imgur.com/dvPMX0i.png


11. In the Pin menu, click the Add 1 Constraints button.
Your image view now has a 1:1 aspect ratio, so it will always be a square.


![inline][Square]


[Square]:https://i.imgur.com/jXI5Ggw.png


12. With the image view selected, open the Attributes inspector image:

![inline][AttributesInspector]

[AttributesInspector]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/inspector_attributes_2x.png

Recall that the [Attributes inspector](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW19) appears when you select the fourth button from the left in the inspector selector bar. It lets you edit the properties of an object in your storyboard.


13. In the Attributes inspector, find the Interaction field and select the User Interaction Enabled checkbox.
You’ll need this feature later to let users interact with the image view.

![inline][UserInteractionEnabled]

[UserInteractionEnabled]:https://i.imgur.com/1CeyMnt.png


## Display a Default Photo

Add a placeholder image to let users know that they can interact with the image view to select a photo. (Use the one below or use one of your own. Drag it to your desktop)

![inline][NoPhotoSelected]

[NoPhotoSelected]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/defaultphoto_2x.png


### To add an image to your project

1. In the [project navigator](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW57), select Assets.xcassets to view the asset catalog.  
The [asset catalog](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW69) is a place to store and organize your image assets for an app.

2. In the bottom left corner, click the plus (+) button and select New Image Set from the pop-up menu.

![inline][NewImageAsset]

[NewImageAsset]: https://i.imgur.com/XZVUle5.png

3. Double-click the image set name and rename it to `defaultPhoto`.

4. On your computer, select the image you want to add.

5. Drag and drop the image into the 2x slot in the image set.

![inline][AddDefaultPhoto]

[AddDefaultPhoto]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/WWVC_defaultphoto_drag_2x.png

`2x` is the display resolution for the iPhone 7 [Simulator](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW128) that you’re using in these lessons, so the image will look best at this resolution.

With the default placeholder image added to your project, set the image view to display it.


### To display a default image in the image view

1. Open your storyboard.
2. In your storyboard, select the image view.
3. With the image view selected, open the Attributes inspector in the utility area.
4. In the Attributes inspector, find the field labeled Image and select `defaultPhoto`.

**Checkpoint**: Preview your view in the storyboard (if you dont remember, go back to instructions in Pt 1 & 2 on previewing in storyboards)


**Checkpoint**: Run your app. The default image displays in the image view.

![inline][CP]

[CP]: https://i.imgur.com/5cZ8dXg.png

### Connect the Image View to Code

Now, you need to implement the functionality to change the image in this image view at runtime. First, you need to connect the image view to the code in `CaptionedViewController.swift`.

#### To connect the image view to the `CaptionedViewController.swift` code

1. Click the Assistant button in the Xcode toolbar near the top right corner of Xcode to open the assistant editor.

![inline][AssistantEditor2]

[AssistantEditor2]:https://i.imgur.com/yxmnwLk.png


2. If you want more space to work, collapse the project navigator and utility area by clicking the Navigator and Utilities buttons in the Xcode toolbar.

![inline][NavigatorToggle]

[NavigatorToggle]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/navigator_utilities_toggle_on_2x.png

3. You can also collapse the outline view.

4. In your storyboard, select the image view.

5. Control-drag from the image view on your canvas to the code display in the editor on the right, stopping the drag at the line just below the existing outlets in `CaptionedViewController.swift`.


6. In the dialog that appears, for Name, type `photoImageView`. Leave the rest of the options as they are.

7. 

![inline](PhotoImageViewOutlet)

[PhotoImageViewOutlet]:https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L11%20Animations/gifs/PhotoImageView-gif.gif


8. Click Connect.
Xcode adds the necessary code to ViewController.swift to store a reference to the image view and configures the storyboard to set up that connection.

```swift
@IBOutlet weak var photoImageView: UIImageView!
```
You can now access the image view from code to change its image, but how do you know when to change the image? You need to give users a way to indicate that they want to change the image—for example, by tapping the image view. Then, you’ll define an [action][Action-Documentation] method to change the image when a tap occurs.

There’s a nuanced distinction between [views][Views-Documention] and controls[Controls-Documentation], which are specialized versions of views that respond to user actions in a specific way. A view displays content, whereas a control is used to modify the content in some way. A control (`UIControl`) is a subclass of `UIView`. In fact, you’ve already worked with both views (labels, image views) and controls (text fields, buttons) in your interface.


## Create a Gesture Recognizer

An image view isn’t a control, so it’s not designed to respond to input in the same way that button or a slider might. For example, you can’t simply create an action method that’s triggered when a user taps on an image view. (If you try to Control-drag from the image view to your code, you’ll notice that you can’t select Action in the Connection field.)

Fortunately, it’s quite easy to give a view the same capabilities as a control by adding a gesture recognizer to it. [Gesture recognizers][Gestures-Documentation] are objects that you attach to a view that allow the view to respond to the user the way a control does. Gesture recognizers interpret touches to determine whether they correspond to a specific gesture, such as a swipe, pinch, or rotation. You can write an action method that is called when a gesture recognizer recognizes its assigned gesture, which is exactly what you need to do for the image view.

Attach a tap gesture recognizer (`UITapGestureRecognizer`) to the image view, which will recognize when a user has tapped the image view. You can do this easily in your storyboard.

### To add a tap gesture recognizer to your image view

1. Open the Object library (Choose View > Utilities > Show Object Library).

2. In the Object library, type `tap gesture` in the filter field to find the Tap Gesture Recognizer object quickly.

3. Drag a Tap Gesture Recognizer object from the Object library to your scene, and place it on top of the image view.

![inline][AddGesture-Gif]


4. The Tap Gesture Recognizer object appears in the captured [scene dock][Scene-Documentation].

## Connect the Gesture Recognizer to Code

Now, connect that gesture recognizer to an action method in your code.

### To connect the gesture recognizer to the `CaptionedViewController.swift` code

1. Control-drag from the gesture recognizer in the scene dock to the code display in the editor on the right, stopping the drag at the line below the //MARK: Actions [comment][Comments-Documentation] in `CaptionedViewController.swift`

![inline][AddGesture-Gif]


2. In the dialog that appears, for Connection, select Action.

3. For Name, type `selectImageFromPhotoLibrary`.

4. For Type, select `UITapGestureRecognizer`.

![inline][ActionForGesture]

5. Click Connect.

Xcode adds the necessary code to `CaptionedViewController.swift` to set up the action.

```swift
@IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
}
```

## Create an Image Picker to Respond to User Taps

When a user taps the image view, they should be able to choose a photo from a collection of photos, or take one of their own. Fortunately, the `UIImagePickerController` class has this behavior built into it. An image picker controller manages the user interface for taking pictures and for choosing saved images to use in your app. And just as you need a text field [delegate][Delegate-Documentation] when you work with a text field, you need an image picker controller delegate to work with an image picker controller. The name of that delegate protocol is `UIImagePickerControllerDelegate`, and the object that you’ll define as the image picker controller’s delegate is `CaptionedViewController`.

First, The system must ask the user for permission before accessing their photo library. In iOS 10 and later, you must provide a photo library usage description. This description explains why your app wants to access the photo library.

### To add a photo library usage description

1. In the project navigator, select `Info.plist`.   

Xcode displays the property list editor in the editor area. A property list is a structured text file that contains essential configuration information about your app. The root of the property list is a dictionary that holds a set of predefined keys and their values.

![inline][Info-Plist]

>  EXPLORE FURTHER
For more information on possible info.plist keys, see Information [Property List Key Reference][].

2. If the last item in the property list is an array, make sure the array is collapsed. If you add an item to an expanded array, it adds a child item. If you add an item to a collapsed array, it adds a sibling to the array.

3. To add a new item, hover over the last item in the property list, and click on the add button when it appears (or select Editor > Add Item).

![inline][Add-Info-Plist-Item]

4. In the pop-up menu, scroll down and choose `Privacy - Photo Library Usage Description`.

![inline][Plist-Privacy-DropDown]

5. In the new row, make sure the Type is set to String. Then, double-click on the Value section and enter `Allows you to add photos to be captioned`

![inline][Add-Description-String]

6. Press the `Return` key when you are done editing the description string.


_Checkpoint_:  You should be able to click the image view to pull up an image picker. You’ll need to click OK on the alert that asks for permission to give the `CaptionThat` app access to Photos. Then, you can click the Cancel button to dismiss the picker, or open Camera Roll and click an image to select it and set it as the image in the image view. 
> Note: You might not get the permission prompt on the simulator. If you wish to ever run the app on a real device, you will need the  photo library usage permission we added to the `Info.plist` file.



Next, `CaptionedViewController` needs to adopt the `UIImagePickerControllerDelegate` protocol. Because `CaptionedViewController` will be in charge of presenting the image picker controller, it also needs to adopt the `UINavigationControllerDelegate` protocol, which simply lets `CaptionedViewController` take on some basic navigation responsibilities.


### To adopt the UIImagePickerControllerDelegate and UINavigationControllerDelegate protocols

1. In the project navigator, select `CaptionedViewController.swift`.
2. In `CaptionedViewController.swift`, find the class line, which should look like this:

```swift
class CaptionedViewController: UIViewController, UITextFieldDelegate {
```

3. After `UITextFieldDelegate`, add a comma (,) and `UIImagePickerControllerDelegate` to adopt the protocol 

```swift
class CaptionedViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate {
```

4. After `UIImagePickerControllerDelegate`, add a comma (,) and `UINavigationControllerDelegate` to adopt the protocol.

```swift
class CaptionedViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
```

At this point, you can go back to the action method you defined, `selectImageFromPhotoLibrary(_:)`, and finish its implementation.


### To implement the selectImageFromPhotoLibrary(_:) action method

1. In `CaptionedViewController.swift,` find the `selectImageFromPhotoLibrary(_:)` action method you added earlier.

It should look like this:

```swift
@IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
}
```
2. In the method implementation, between the curly braces ({}), add this code:

```swift
// Hide the keyboard.
captionTextField.resignFirstResponder()
}
```
This code ensures that if the user taps the image view while typing in the text field, the keyboard is dismissed properly.

3. Add this code to create an image picker controller:

```swift
// UIImagePickerController is a view controller that lets a user pick media from their photo library.
let imagePickerController = UIImagePickerController()
```

4. Add this code:

```swift
// Only allow photos to be picked, not taken.
imagePickerController.sourceType = .photoLibrary
```

This line of code sets the image picker controller’s source, or the place where it gets its images. The `.photoLibrary` option uses the simulator’s camera roll.

The type of `imagePickerController.sourceType` is known to be `UIImagePickerControllerSourceType`, which is an [enumeration][Enum-Documentation]. This means you can write its value as the abbreviated form `.photoLibrary` instead of `UIImagePickerControllerSourceType.photoLibrary`. Recall that you can use the abbreviated form anytime the enumeration value’s type is already known.

5. Add this code to set the image picker controller’s delegate to `CaptionedViewController``:

```swift
// Make sure `CaptionedViewController` is notified when the user picks an image.
imagePickerController.delegate = self
```

6. Below the previous line, add this line of code:

```swift
present(imagePickerController, animated: true, completion: nil)
```

`present(_:animated:completion:)` is a method being called on `CaptionedViewController`. Although it’s not written explicitly, this method is executed on an implicit self object. The method asks `CaptionedViewController` to present the view controller defined by `imagePickerController`. Passing `true` to the animated parameter animates the presentation of the image picker controller. The `completion` parameter refers to a [completion handler][CompletionHandler-Documentation], a piece of code that executes after this method completes. Because you don’t need to do anything else, you indicate that you don’t need to execute a completion handler by passing in [nil][Nil-Documentation].

Your  `selectImageFromPhotoLibrary(_:)` action method should look like this:

```swift
@IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {

// Hide the keyboard.
captionTextField.resignFirstResponder()

// UIImagePickerController is a view controller that lets a user pick media from their photo library.
let imagePickerController = UIImagePickerController()

// Only allow photos to be picked, not taken.
imagePickerController.sourceType = .photoLibrary

// Make sure CaptionedViewController is notified when the user picks an image.
imagePickerController.delegate = self
present(imagePickerController, animated: true, completion: nil)
}
```

After an image picker controller is presented, you interact with it through the delegate methods. To give users the ability to select a picture, you’ll need to implement two of the delegate methods defined in `UIImagePickerControllerDelegate`:

```swift
func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
```

The first of these, `imagePickerControllerDidCancel(_:)`, gets called when a user taps the image picker’s Cancel button. This method gives you a chance to dismiss the UIImagePickerController (and optionally, do any necessary cleanup).


### To implement the imagePickerControllerDidCancel(_:) method

1. In `CaptionedViewController.swift`, right above the `//MARK: Actions` section, add the following:  

```swift
//MARK: UIImagePickerControllerDelegate
```

This is a comment to help you (and anybody else who reads your code) navigate through your code and identify that this section applies to the image picker implementation.

2. Below the comment you just added, add the following method:  

```swift
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
}
```

3. In this method, add the following line of code:  

```swift
// Dismiss the picker if the user canceled.
dismiss(animated: true, completion: nil)
```  
This code animates the dismissal of the image picker controller.

Your `imagePickerControllerDidCancel(_:)` method should look like this:

```swift
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
// Dismiss the picker if the user canceled.
dismiss(animated: true, completion: nil)
}
```

The second `UIImagePickerControllerDelegate` method that you need to implement, `imagePickerController(_:didFinishPickingMediaWithInfo:)`, gets called when a user selects a photo. This method gives you a chance to do something with the image or images that a user selected from the picker. In your case, you’ll take the selected image and display it in your image view.


### To implement the imagePickerController(_:didFinishPickingMediaWithInfo:) method

1. Below the `imagePickerControllerDidCancel(_:)` method, add the following method:

```swift
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
}
```

2. In this method, add the following line of code:

```swift
// The info dictionary may contain multiple representations of the image. You want to use the original.
guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
}
```  

The `info` dictionary always contains the original image that was selected in the picker. It may also contain an edited version of that image, if one exists. To keep things simple, you’ll use the original, unedited image for the caption photo.

This code accesses the original, unedited image from the `info` dictionary. It safely unwraps the optional returned by the dictionary and casts it as a `UIImage` object. The expectation is that the unwrapping and casting operations will never fail. If they do, it represents either a bug in your app that needs to be fixed at design time. The `fatalError()` method logs an error message to the console, including the contents of the `info` dictionary, and then causes the app to terminate—preventing it from continuing in an invalid state.

3. Add this line of code to set the selected image in the image view outlet that you created earlier:

```swift
// Set photoImageView to display the selected image.
photoImageView.image = selectedImage
```
4. Add the following line of code to dismiss the image picker:

```swift
// Dismiss the picker.
dismiss(animated: true, completion: nil)
```

Your `imagePickerController(_:didFinishPickingMediaWithInfo)` method should look like this:

```swift
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
// Dismiss the picker if the user canceled.
dismiss(animated: true, completion: nil)
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

// The info dictionary may contain multiple representations of the image. You want to use the original.
guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
}

// Set photoImageView to display the selected image.
photoImageView.image = selectedImage

// Dismiss the picker.
dismiss(animated: true, completion: nil)
}
```

_Checkpoint_: Run your app. You should be able to click the image view to pull up an image picker. You’ll need to click OK on the alert that asks for permission to give the CaptionThat app access to Photos (this might not happen). Then, you can click the Cancel button to dismiss the picker, or open Camera Roll and click an image to select it and set it as the image in the image view

![inline][Camera-Roll]

Simulator doesn't really have fun photos to use. Add your own images directly into the simulator to test the CaptionThat app with appropriate sample content. 

### To add images to iOS Simulator

1. If necessary, run your app in the simulator.
2. On your computer, select the images you want to add.
3. Drag and drop the images into the simulator.


![inline][AddPhotosToSim-Gif]

[Property List Key Reference]:https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009247

[Nil-Documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW5

[CompletionHandler-Documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW30

[Enum-Documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW88

[Views-Documention]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW16

[Controls-Documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW17

[Action-Documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW23

[Gestures-Documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW42

[Scene-Documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW63

[Comments-Documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW31

[Delegate-Documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW36

[Add-Description-String]:https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L11%20Animations/gifs/AddingDescriptionString.png

[Plist-Privacy-DropDown]:https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L11%20Animations/gifs/Add-Item-To-Plist.png

[Info-Plist]:https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L11%20Animations/gifs/Xcode-Info-plist.png

[Add-Info-Plist-Item]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/WWVC_addInfoPlistItem_2x.png

[AddGesture-Gif]:https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L11%20Animations/gifs/gesture-rec.gif

[ActionForGesture]:https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L11%20Animations/gifs/Tap-Gesture-Params.png

[Camera-Roll]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/WWVC_sim_imagepicker_2x.png

[AddPhotosToSim-Gif]:https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L11%20Animations/gifs/AddPhotosToSimulator.gif
