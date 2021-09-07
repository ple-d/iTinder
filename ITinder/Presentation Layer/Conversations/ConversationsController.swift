import UIKit
import SwiftUI

class ConversationsController: UIViewController {
    var theContainer: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let messagesView = MessagesView()
        let viewControl = UIHostingController(rootView: messagesView)
        addChild(viewControl)
        viewControl.view.frame = theContainer?.bounds ?? .zero
        theContainer?.addSubview(viewControl.view)
        viewControl.didMove(toParent: self)
    }

}

