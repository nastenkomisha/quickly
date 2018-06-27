//
//  Quickly
//

import Quickly

protocol IPageViewControllerRoutePath : IPageContentViewControllerRoutePath {

    func dismiss(viewController: PageViewController)

}

class PageViewController : QPageContainerViewController, IQRoutable {

    weak var routePath: IPageViewControllerRoutePath!
    weak var routeContext: AppRouteContext!

    init(_ routePath: IPageViewControllerRoutePath, _ routeContext: AppRouteContext) {
        self.routePath = routePath
        self.routeContext = routeContext
        super.init()
    }

    override func setup() {
        super.setup()

        let pagebar = QPagebar(cellTypes: [
            QPagebarTitleCell< QPagebarTitleItem >.self
        ])
        pagebar.backgroundColor = UIColor.white
        self.setPagebar(pagebar)

        self.setViewControllers([
            QPageViewController(
                QPagebarTitleItem(
                    title: QLabelStyleSheet(text: QText("Page #1", color: .red)),
                    backgroundColor: UIColor.gray,
                    selectedBackgroundColor: UIColor.darkGray
                ),
                PageContentViewController(self.routePath, self.routeContext)
            ),
            QPageViewController(
                QPagebarTitleItem(
                    title: QLabelStyleSheet(text: QText("Page #2", color: .green)),
                    backgroundColor: UIColor.gray,
                    selectedBackgroundColor: UIColor.darkGray
                ),
                PageContentViewController(self.routePath, self.routeContext)
            ),
            QPageViewController(
                QPagebarTitleItem(
                    title: QLabelStyleSheet(text: QText("Page #3", color: .blue)),
                    backgroundColor: UIColor.gray,
                    selectedBackgroundColor: UIColor.darkGray
                ),
                PageContentViewController(self.routePath, self.routeContext)
            )
        ])
    }

}