//
//  Quickly
//

open class QPlaceholderImageTitleComposable : QComposable {

    public var direction: QViewDirection
    
    public var image: QImageViewStyleSheet
    public var imageSize: CGSize
    public var imageSpacing: CGFloat

    public var title: QPlaceholderViewStyleSheet
    public var titleHeight: CGFloat

    public init(
        edgeInsets: UIEdgeInsets = QComposable.defaultEdgeInsets,
        image: QImageViewStyleSheet,
        imageWidth: CGFloat = 96,
        imageSpacing: CGFloat = 4,
        title: QPlaceholderViewStyleSheet,
        titleHeight: CGFloat
    ) {
        self.direction = .horizontal
        self.image = image
        self.imageSize = CGSize(width: imageWidth, height: imageWidth)
        self.imageSpacing = imageSpacing
        self.title = title
        self.titleHeight = titleHeight
        super.init(edgeInsets: edgeInsets)
    }
    
    public init(
        edgeInsets: UIEdgeInsets = QComposable.defaultEdgeInsets,
        image: QImageViewStyleSheet,
        imageHeight: CGFloat = 96,
        imageSpacing: CGFloat = 8,
        title: QPlaceholderViewStyleSheet,
        titleHeight: CGFloat
    ) {
        self.direction = .vertical
        self.image = image
        self.imageSize = CGSize(width: imageHeight, height: imageHeight)
        self.imageSpacing = imageSpacing
        self.title = title
        self.titleHeight = titleHeight
        super.init(edgeInsets: edgeInsets)
    }

}

open class QPlaceholderImageTitleComposition< Composable: QPlaceholderImageTitleComposable > : QComposition< Composable > {

    lazy private var imageView: QImageView = {
        let view = QImageView(frame: self.contentView.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        return view
    }()
    lazy private var titleLabel: QPlaceholderView = {
        let view = QPlaceholderView(frame: self.contentView.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        return view
    }()

    private var currentDirection: QViewDirection?
    private var currentEdgeInsets: UIEdgeInsets?
    private var currentImageSpacing: CGFloat?
    private var currentImageSize: CGSize?
    private var currentTitleHeight: CGFloat?

    private var selfConstraints: [NSLayoutConstraint] = [] {
        willSet { self.contentView.removeConstraints(self.selfConstraints) }
        didSet { self.contentView.addConstraints(self.selfConstraints) }
    }
    private var imageConstraints: [NSLayoutConstraint] = [] {
        willSet { self.imageView.removeConstraints(self.imageConstraints) }
        didSet { self.imageView.addConstraints(self.imageConstraints) }
    }
    private var titleConstraints: [NSLayoutConstraint] = [] {
        willSet { self.titleLabel.removeConstraints(self.titleConstraints) }
        didSet { self.titleLabel.addConstraints(self.titleConstraints) }
    }

    open override class func size(composable: Composable, spec: IQContainerSpec) -> CGSize {
        switch composable.direction {
        case .horizontal:
            return CGSize(
                width: spec.containerSize.width,
                height: composable.edgeInsets.top + max(composable.imageSize.height, composable.titleHeight) + composable.edgeInsets.bottom
            )
        case .vertical:
            return CGSize(
                width: composable.edgeInsets.left + composable.imageSize.width + composable.edgeInsets.right,
                height: composable.edgeInsets.top + composable.imageSize.height + composable.imageSpacing + composable.titleHeight + composable.edgeInsets.bottom
            )
        }
    }
    
    open override func preLayout(composable: Composable, spec: IQContainerSpec) {
        let changedDirection = self.currentDirection != composable.direction
        self.currentDirection = composable.direction
        
        let edgeInsets = UIEdgeInsets(
            top: composable.edgeInsets.top,
            left: spec.containerLeftInset + composable.edgeInsets.left,
            bottom: composable.edgeInsets.bottom,
            right: spec.containerRightInset + composable.edgeInsets.right
        )
        let changedEdgeInsets = self.currentEdgeInsets != edgeInsets
        self.currentEdgeInsets = edgeInsets
        
        let changedImageSpacing = self.currentImageSpacing != composable.imageSpacing
        self.currentImageSpacing = composable.imageSpacing
        
        let changedImageSize = self.currentImageSize != composable.imageSize
        self.currentImageSize = composable.imageSize
        
        let changedTitleHeight = self.currentTitleHeight != composable.titleHeight
        self.currentTitleHeight = composable.titleHeight
        
        if changedDirection == true || changedEdgeInsets == true || changedImageSpacing == true {
            switch composable.direction {
            case .horizontal:
                self.selfConstraints = [
                    self.imageView.topLayout == self.contentView.topLayout + edgeInsets.top,
                    self.imageView.leadingLayout == self.contentView.leadingLayout + edgeInsets.left,
                    self.imageView.trailingLayout == self.titleLabel.leadingLayout - composable.imageSpacing,
                    self.imageView.bottomLayout == self.contentView.bottomLayout - edgeInsets.bottom,
                    self.titleLabel.topLayout == self.contentView.topLayout + edgeInsets.top,
                    self.titleLabel.trailingLayout == self.contentView.trailingLayout - edgeInsets.right,
                    self.titleLabel.bottomLayout == self.contentView.bottomLayout - edgeInsets.bottom
                ]
            case .vertical:
                self.selfConstraints = [
                    self.imageView.topLayout == self.contentView.topLayout + edgeInsets.top,
                    self.imageView.leadingLayout == self.contentView.leadingLayout + edgeInsets.left,
                    self.imageView.trailingLayout == self.contentView.trailingLayout - edgeInsets.right,
                    self.imageView.bottomLayout == self.titleLabel.topLayout - edgeInsets.bottom,
                    self.titleLabel.leadingLayout == self.contentView.leadingLayout + edgeInsets.left,
                    self.titleLabel.trailingLayout == self.contentView.trailingLayout - edgeInsets.right,
                    self.titleLabel.bottomLayout == self.contentView.bottomLayout - edgeInsets.bottom
                ]
            }
        }
        if changedDirection == true || changedImageSize == true {
            switch composable.direction {
            case .horizontal:
                self.imageConstraints = [
                    self.imageView.widthLayout == composable.imageSize.width
                ]
            case .vertical:
                self.imageConstraints = [
                    self.imageView.widthLayout == composable.imageSize.width,
                    self.imageView.heightLayout == composable.imageSize.height
                ]
            }
        }
        if changedDirection == true || changedTitleHeight == true {
            self.titleConstraints = [
                self.titleLabel.heightLayout == composable.titleHeight
            ]
        }
    }
    
    open override func apply(composable: Composable, spec: IQContainerSpec) {
        composable.image.apply(self.imageView)
        composable.title.apply(self.titleLabel)
    }

}
