import UIKit
import SwiftUI

class ConversationsController: UIViewController {
    var theContainer: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let matchView = MatchView()
        let viewControl = UIHostingController(rootView: matchView)
        addChild(viewControl)
        viewControl.view.frame = theContainer.bounds
        theContainer.addSubview(viewControl.view)
        viewControl.didMove(toParent: self)
    }

}

