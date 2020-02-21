# CIS-444
## Lecture 11: Part 2 / Homework-03 (Pt2)

In this section, you’ll connect the basic user interface (UI) of the CaptionThat app to code and define some actions a user can perform in that UI.

IMPORTANT: 
Before you begin: Due to a [bug in the iOS Simualator](https://forums.developer.apple.com/thread/122972), please do the following:
1. Run the CaptionApp in a simulator.
2. "Simulator -> Edit -> Automatically Sync Pasteboard" cancel selected.
3. "Hardware -> Restart"

## Learning Objectives

At the end of the lesson, you’ll be able to:

* (Review) Explain the relationship between a scene in a storyboard and the underlying view controller
* (Review) Create outlet and action connections between UI elements in a storyboard and source code
* Process user input from a text field and display the result in the UI
* Make a class conform to a protocol
* Understand the delegation pattern
* Follow the target-action pattern when designing app architecture

## Connect the UI to Source Code
### This is review from concepts you already know but a more detailed explanation step-by-step guide

Elements in a [storyboard](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW8) are linked to source code. It’s important to understand the relationship that a storyboard has to the code you write.  

In a storyboard, a [scene](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW62) represents one screen of content and typically one view controller. [View controllers](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW7) implement your app’s behavior. A view controller manages a single content view with its hierarchy of subviews. View controllers coordinate the flow of information between the app’s [data model](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW35), which encapsulates the app’s data, and the views that display that data, manage the life cycle of their content views, handle orientation changes when the device is rotated, define the navigation within your app, and implement the behavior to respond to user input. All view controller objects in iOS are of type UIViewController or one of its subclasses.  

You define the behavior of your view controllers in code by creating and implementing custom view controller [subclasses](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW14). You can then create a connection between those classes and scenes in your storyboard to get the behavior you defined in code and the user interface you defined in your storyboard.

In your first coding assignment, you created such classes, `LandingViewController.swift` and `CaptionedViewController.swift`, and connected them to the scenes you’re working on in your storyboard right now. You added these scenes by making the connections yourself in the Identity inspector. The Identity inspector let you edit properties of an object in your storyboard related to that object’s identity, such as what class the object belongs to.

![inline][IDInspector]

[IDInspector]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/CUIC_inspector_identity_2x.png


At runtime, your storyboard creates an instance of ViewController, your custom view controller subclass. The scene from your storyboard appears on the device’s screen, and the user interface’s behavior is defined in `LandingViewController.swift` and `CaptionedViewController.swift`

As you know, the scene connection is not the only connection that needs to be made. To define interaction in your app, your view controller source code needs to be able to communicate with the views in your storyboard. You do this by defining additional connections—called outlets and actions—between the views in the storyboard and the view controller source code files.

## Create Outlets for UI Elements

[Outlets](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW55) provide a way to reference interface objects—the objects you added to your storyboard—from source code files. To create an outlet, Control-drag from a particular object in your storyboard to a view controller file. This operation creates a [property](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW58) for the object in your view controller file, which lets you access and manipulate that object from code at runtime.

You’ll need to create outlets for the text field and label in your user interface to be able to reference them.

## To connect the text field to the `CaptionedViewController.swift` code

1. Open your storyboard, `Main.storyboard`.

2. Open the [assistant editor](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW76)

![inline][AsstEditor]

[AsstEditor]: https://i.imgur.com/OU2JHXA.png

3. If you want more space to work, collapse the [project navigator](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW57) and [utility area](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW72) by clicking the Navigator and Utilities buttons in the Xcode toolbar.

![inline][CollapseSides]

[CollapseSides]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/navigator_utilities_toggle_on_2x.png

4. In the outline view, select `CaptionedViewControllerScene`

5. In the editor selector bar, which appears at the top of the assistant editor, change the assistant editor from Preview to Automatic > `CaptionedViewController.swift`

![inline][PreviewCaptioned]

[PreviewCaptioned]: https://i.imgur.com/b0E82lu.png
   
   `CaptionedViewController.swift` displays in the editor on the right.


6. In  `CaptionedViewController.swift`, find the class line, which should look like this:


```swift
   class CaptionedViewController: UIViewController {
```

7. Below the `class` line, add the following:

```swift
   //MARK: Properties
```

   You just added a [comment](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW31) to your source code. Recall that a comment is a piece of text in a source code file that doesn’t get compiled as part of the program but provides context or useful information about individual pieces of code.
A comment that begins with the characters //MARK: is a special type of comment that’s used to organize your code and to help you (and anybody else who reads your code) navigate through it. You’ll see this in action later. Specifically, the comment you added indicates that this is the section of your code that lists properties.

   A comment that begins with the characters `//MARK:` is a special type of comment that’s used to organize your code and to help you (and anybody else who reads your code) navigate through it. You’ll see this in action later. Specifically, the comment you added indicates that this is the section of your code that lists properties.

8. In your storyboard, select the text field.

9. Control-drag from the text field on your canvas to the code display in the editor on the right, stopping the drag at the line below the comment you just added in `CaptionedViewController.swift`.

![inline][TextfieldOutlet]

[TextfieldOutlet]: https://media.giphy.com/media/jtLSkngLhrkOx5vpvA/giphy.gif

10. In the dialog that appears, for Name, type `captionTextField`. Leave the rest of the options as they are.

![inline][CaptionTextField]

[CaptionTextField]: https://i.imgur.com/ee8ke3R.png

11. Click Connect.
   Xcode adds the necessary code to `CaptionedViewController.swift` to store a reference to the text field and configures the storyboard to set up that connection.
   
   ```swift
       @IBOutlet weak var captionTextField: UITextField!
   ```

Take a minute to understand what’s happening in this line of code.

The `IBOutlet` attribute tells Xcode that you can connect to the captionTextField property from Interface Builder (which is why the attribute has the `IB` prefix). The `weak` keyword indicates that the reference does not prevent the system from deallocating the referenced object. Weak references help prevent reference cycles; however, to keep the object alive and in memory you need to make sure some other part of your app has a strong reference to the object. In this case, it’s the text field’s superview. A superview maintains a strong reference to all of its subviews. As long as the superview remains alive and in memory, all of the subviews remain alive as well. Similarly, the view controller has a strong reference to its content view—keeping the entire view hierarchy alive and in memory.  
captionTextField

The rest of the declaration defines an [implicitly unwrapped optional](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW50) variable of type UITextField named `captionTextField`. Pay careful attention to the exclamation point at the end of the type declaration. This exclamation point indicates that the type is an implicitly unwrapped optional, which is an optional type that will always have a value after it is first set. When you access an implicitly unwrapped optional, the system assumes it has a valid value and automatically unwraps it for you. Note that this causes the app to terminate if the variable’s value has not yet been set.

When a view controller is loaded from a storyboard, the system instantiates the view hierarchy and assigns the appropriate values to all the view controller’s outlets. By the time the view controller’s `viewDidLoad()` method is called, the system has assigned valid values to all of the controller’s outlets, and you can safely access their contents.

Now, connect the label to your code in the same way you connected the text field.

## To connect the label to the `CaptionedViewController.swift` code

1. In your storyboard, select the label.
2. Control-drag from the label on your canvas to the code display in the editor on the right, stopping the drag at the line just below your `captionTextField` property in CaptionedViewController.swift.

![inline]{CaptionLabelOutlet]

[CaptionLabelOutlet]: https://i.imgur.com/NGzNIVy.png

3. In the dialog that appears, for Name, type `captionValueLabel`. Leave the rest of the options as they are.

4. Click Connect.

![inline][CaptionLabelOutletResult]

[CaptionLabelOutletResult]: https://i.imgur.com/iKsAfsZ.png

  Again, Xcode adds the necessary code to `CaptionedViewController.swift` to store a reference to the label and configures the storyboard to set up that connection. This outlet is similar to the text field, except for its name and its type (which is `UILabel`, to match the type of object that’s in the storyboard).

```swift
    @IBOutlet weak var captionValueLabel: UILabel!
```

  You only need an outlet to an interface object if you plan to either access a value from the interface object or modify the interface object in your code. In this case, you need to set the text field’s delegate property and set the label’s text property. You won’t be modifying the button, so there’s no reason to create an outlet for it.

  Outlets let you refer to your interface elements in code, but you still need a way to respond whenever the user interacts with the elements. That’s where actions come in.

## Define an Action to Perform

iOS apps are based on [event-driven programming](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW38). That is, the flow of the app is determined by events: system events and user actions. The user performs actions in the interface that trigger events in the app. These events result in the execution of the app’s logic and manipulation of its data. The app’s response to user action is then reflected back in the user interface. Because the user, rather than the developer, is in control of when certain pieces of the app code get executed, you want to identify exactly which actions a user can perform and what happens in response to those actions.

An [action](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW23) (or an action method) is a piece of code that’s linked to an event that can occur in your app. When that event takes place, the system execute’s the action’s code. You can define an action method to accomplish anything from manipulating a piece of data to updating the user interface. You use actions to drive the flow of your app in response to user or system events.

You create an action the same way you create an outlet: Control-drag from a particular object in your storyboard to a view controller file. This operation creates a method in your view controller file that gets triggered when a user interacts with the object that the action method is attached to.

Start by creating a simple action that sets the label to Default Text whenever the user taps the Set Default Text button. (The code to set the label to the text in the text field is a bit more involved, so you’ll write that in the Process User Input section.)


## To create a setDefaultLabelText action in the CaptionedViewController.swift code

1. in `CaptionedViewController.swift`, just above the last curly brace (}), add the following:

```swift
   /// Mark: Actions
```
   This comment indicates that this is the section of your code that lists actions.

2. In your storyboard, select the Set Default Label Text button.
3. Control-drag from the Set Default Label Text button on your canvas to the code display in the editor on the right, stopping the drag at the line below the comment you just added in `CaptionedViewController.swift`.

![inline][AddActionSetDefault]

[AddActionSetDefault]: https://media.giphy.com/media/KAvl4pdWe13DUfYl7E/giphy.gif

4. In the dialog that appears, for Connection select Action.

5. For Name, type `setDefaultLabelText`.

6. For Type, select `UIButton`.

You may have noticed that the value of the Type field defaults to AnyObject. As discussed in previous lectures, In Swift, `AnyObject` is a type used to describe an object that can belong to any class. Specifying the type of this action method to be `UIButton` means that only button objects can connect to this action. Although this isn’t significant for the action you’re creating right now, it’s important to remember for later.

Leave the rest of the options as they are.

![inline][AddActionDetails]

[AddActionDetails]: https://i.imgur.com/PqWoyeN.png


7. Click Connect
   Xcode adds the necessary code to `CaptionedViewController.swift` to set up the action method.
   
   ```swift
   @IBAction func setDefaultLabelText(_ sender: UIButton) {
    }
    ```

8. The `sender` parameter refers to the object that was responsible for triggering the action—in this case, a button. The `IBAction` attribute indicates that the method is an action that you can connect to from your storyboard in Interface Builder. The rest of the declaration declares a method by the name of `setDefaultLabelText(_:)`.

Right now, the method declaration is empty. The code to reset the value of the label is quite simple.

## To implement the label reset action in the ViewController code

In `CaptionedViewController.swift`, find the setDefaultLabelText action method you just added.
In the method implementation, between the curly braces ({}), add this line of code:

```swift
captionValueLabel.text = "Default Text"
```

As you might guess, this code sets the label’s text property to string: "Default Text".
Notice that you didn’t have to specify the type of Default Text, because Swift’s [type inference](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW70) can see that you’re assigning to something of type String and can infer the type correctly.

iOS handles all of the redrawing code for you, so this is actually all the code you need to write for now. Your `setDefaultLabelText(_:)` action method should look like this:

```swift
@IBAction func setDefaultLabelText(_ sender: UIButton) {
    captionValueLabel.text = "Default Text"
}
```

Checkpoint: Test your changes by running the simulator. When you click the Set Default Label Text button, your setDefaultLabelText(_:) method is called, and the `captionValueLabel` object’s text value changes from `Caption` (the value set in your storyboard) to Default Text (the value set by the action). You should see the change in your user interface.

![inline][ButtonWorkingProgress]

[ButtonWorkingProgress]: https://media.giphy.com/media/QZ1DqtwWaaviYwQFPu/giphy.gif


While changing the caption’s value to “Default Text” isn’t particularly useful, it does illustrate an important point. The behavior you just implemented is an example of the [target-action](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW68) pattern in iOS app design. Target-action is a design pattern where one object sends a message to another object when a specific event occurs.

In this case:

* The event is the user tapping the Set Default Text button.
* The action is setDefaultLabelText(_).
* The target is `CaptionedViewController` (where the action method is defined).
* The sender is the Set Default Label Text button.

The system sends the message by calling the action method on the target and passing in the sender object. The sender is usually a control—such as a button, slider, or switch—that can trigger an event in response to user interaction such as a tap, drag, or value change. This pattern is extremely common in iOS app programming, and you’ll be seeing much more of it throughout the lessons.

## Process User Input

At this point, users can reset the caption text to a default value, but you really want to let users enter their own caption values using the text field. To keep things simple, you’ll update the `captionValueLabel` object’s text value whenever the user enters text into the text field and taps Return.

When you work with accepting user input from a text field, you need some help from a text field delegate. A [delegate](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW36) is an object that acts on behalf of, or in coordination with, another object. The delegating object—in this case, the text field—keeps a reference to the other object—the delegate—and at the appropriate time, the delegating object sends a message to the delegate. The message tells the delegate about an event that the delegating object is about to handle or has just handled. The delegate may respond by for example, updating the appearance or state of itself or of other objects in the app, or returning a value that affects how an impending event is handled.

A text field’s delegate communicates with the text field while the user is editing the text, and knows when important events occur—such as when a user starts or stops editing text. The delegate can use this information to save or clear data at the right time, dismiss the keyboard, and so on.

Any object can serve as a delegate for another object as long as it [conforms](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW32) to the appropriate [protocol](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW59). The protocol that defines a text field’s delegate is called `UITextFieldDelegate`. It is very common to make a view controller the delegate for objects that it manages. In this case, you’ll make your `CaptionedViewController` instance the text field’s delegate.

First, `CaptionedViewController` needs to adopt the `UITextFieldDelegate` protocol. You adopt a protocol by listing it as part of the class declaration line.


## To adopt the UITextFieldDelegate protocol

1. If the assistant editor is open, return to the standard editor by clicking the Standard button.

![inline][AsstEditorOnly]

[AsstEditorOnly]: https://i.imgur.com/iroWqSa.png

2. Expand the project navigator and utility area by clicking the Navigator and Utilities buttons in the Xcode toolbar.

3. In the project navigator, select `CaptionedViewController.swift`.

4. In `CaptionedViewController.swift`, find the class line, which should look like this:

```swift
class CaptionedViewController: UIViewController {
```

5. After `UIViewController`, add a comma (,) and `UITextFieldDelegate` to adopt the protocol.

```swift
class CaptionedViewController: UIViewController, UITextFieldDelegate {
```

6. By adopting the  `UITextFieldDelegate` protocol, you tell the compiler that the `CaptionedViewController` class can act as a valid text field delegate. This means you can implement the protocol’s methods to handle text input, and you can assign instances of the `CaptionedViewController` class as the delegate of the text field.

## To set the `CaptionedViewController` object as the delegate of its `captionTextField` property

1. In `CaptionedViewController.swift`, find the viewDidLoad() method, which should look like this:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
}
```
  The template implementation of this method includes a comment. You don’t need this comment in your method implementation, so go ahead and delete it.

2. Below the `super.viewDidLoad()` line, add a blank line and the following:

```
// Handle the text field’s user input through delegate callbacks.
captionTextField.delegate = self
```
   The self refers to the `CaptionedViewController` class, because it’s referenced inside the scope of the `CaptionedViewController` class definition.
   You can add your own comments to help you understand what’s happening in your code.

   Your `viewDidLoad()` method should look like this:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    // Handle the text field’s user input through delegate callbacks.
    captionTextField.delegate = self
}
```
  When a `CaptionedViewController` instance is loaded, it sets itself as the delegate of its `captionTextField` property.

  The `UITextFieldDelegate` protocol defines eight optional methods. Just implement the ones you need to get the behaviors you desire. For now, you’ll need to implement two of these methods:
  
  ```swift
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  func textFieldDidEndEditing(_ textField: UITextField)
```

To understand when these methods get called and what they need to do, it’s important to know how text fields respond to user events. When the user taps a text field, it automatically becomes the first responder. In an app, the [first responder](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW40) is an object that is first on the line for receiving many kinds of app events, including key events, motion events, and action messages, among others. In other words, many of the events generated by the user are initially routed to the first responder.

As a result of the text field becoming the first responder, iOS displays the keyboard and begins an editing session for that text field. What a user types using that keyboard gets inserted into the text field.

When a user wants to finish editing the text field, the text field needs to resign its first-responder status. Because the text field will no longer be the active object in the app, events need to get routed to a more appropriate object.

This is where your implementation of `UITextFieldDelegate` methods comes in. You need to specify that the text field should resign its first-responder status when the user taps a button to end editing in the text field. You do this in the `textFieldShouldReturn(_:)` method, which gets called when the user taps Return (or in this case, Done) on the keyboard.

## To implement the UITextFieldDelegate protocol method textFieldShouldReturn(_:)

1. In `CaptionViewController`.swift, right above the `//MARK: Actions section`, add the following:

```swift
//MARK: UITextFieldDelegate
```

This comment is used to organize your code and to help you (and anybody else who reads your code) navigate through it.

You’ve added several of these comments so far. Xcode lists each of these comments as a section title in the source code file’s Functions menu, which appears if you click the name of the file at the top of the editor area. The [Functions menu](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW41) lets you jump to a section in your code quickly. You’ll notice the sections you denoted by `//MARK:` listed here. You can click on one of the section titles to jump to that section in the file.

![inline][FunctionsMenu]

[FunctionsMenu]: https://i.imgur.com/ck63tTi.png

2. Below the comment, add the following method:

```swift
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
}
```
3. In this method, add the following code to resign the text field’s first-responder status, and a comment to describe what the code does:

```swift
// Hide the keyboard.
textField.resignFirstResponder()
```

Try typing the second line instead of just copying and pasting. You’ll find that [code completion](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW29) is one of the great time-saving features of Xcode. When Xcode brings up the list of potential completions, scroll through the list until you find the one you want and then press Return. Xcode inserts the whole line for you.

![inline][Autocomplete]

[Autocomplete]: https://i.imgur.com/qt9KuRz.png

4. In this method, add the following line of code:

```swift
return true
```
   This method returns a Boolean value that indicates whether the system should process the press of the Return key. In this case, you always want to respond to the user pressing the Return key, so just return `true`.

Your `textFieldShouldReturn(_:)` method should look like this:

```swift 
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Hide the keyboard.
    textField.resignFirstResponder()
    return true
}
```
   The second method that you need to implement, `textFieldDidEndEditing(_:)`, is called after the text field resigns its first-responder status. Because you resign first responder status in `textFieldShouldReturn`, the system calls this method just after calling `textFieldShouldReturn`.
   
   The `textFieldDidEndEditing(_:)` method gives you a chance to read the information entered into the text field and do something with it. In your case, you’ll take the text that’s in the text field and use it to change the value of your label.

## To implement the UITextFieldDelegate protocol method textFieldDidEndEditing(_:)

1. In `CaptionViewController.swift`, after the `textFieldShouldReturn(_:)` method, add the following method:

```swift
func textFieldDidEndEditing(_ textField: UITextField) {
}
```

2. In this method, add the following line of code:

```swift
captionValueLabel.text = textField.text
```
  That’s all you need to do to see the result. Your `textFieldDidEndEditing(_:)` method should look like this:

```swift
func textFieldDidEndEditing(_ textField: UITextField) {
    mealNameLabel.text = textField.text
}
```
_Checkpoint_: Test your changes by running the simulator. You can select the text field and type text into it. When you click the Done button on the keyboard, the keyboard is dismissed and the label text changes to display the text in the text field. When you click the Set Default Label Text button, the label changes from what’s currently displayed in the label to Default Text (the value set by the action you defined earlier).

**NOTE** If you have any issues, please read the first instruction in this document. There is an iOS simulator bug you need to modify in order for the following to work

![inline][TextFieldCheckpoint]

[TextFieldCheckpoint]: https://media.giphy.com/media/Yo7SHgZA1NN5h8lv54/giphy.gif




















