//
//  Quickly
//

open class QPlaceholderImageTitleValueIconComposable : QComposable {
    
    public var image: QImageViewStyleSheet
    public var imageWidth: CGFloat
    public var imageSpacing: CGFloat
    
    public var title: QPlaceholderViewStyleSheet
    public var titleHeight: CGFloat
    public var titleSpacing: CGFloat
    
    public var value: QPlaceholderViewStyleSheet
    public var valueHeight: CGFloat
    
    public var icon: QImageViewStyleSheet
    public var iconWidth: CGFloat
    public var iconSpacing: CGFloat
    
    public init(
        edgeInsets: UIEdgeInsets = QComposable.defaultEdgeInsets,
        image: QImageViewStyleSheet,
        imageWidth: CGFloat = 96,
        imageSpacing: CGFloat = 4,
        title: QPlaceholderViewStyleSheet,
        titleHeight: CGFloat,
        titleSpacing: CGFloat = 4,
        value: QPlaceholderViewStyleSheet,
        valueHeight: CGFloat,
        icon: QImageViewStyleSheet,
        iconWidth: CGFloat = 16,
        iconSpacing: CGFloat = 4
    ) {
        self.image = image
        self.imageWidth = imageWidth
        self.imageSpacing = imageSpacing
        self.title = title
        self.titleHeight = titleHeight
        self.titleSpacing = titleSpacing
        self.value = value
        self.valueHeight = valueHeight
        self.icon = icon
        self.iconWidth = iconWidth
        self.iconSpacing = iconSpacing
        super.init(edgeInsets: edgeInsets)
    }
    
}

open class QPlaceholderImageTitleValueIconComposition< Composable: QPlaceholderImageTitleValueIconComposable >: QComposition< Composable > {
    
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
    lazy private var valueLabel: QPlaceholderView = {
        let view = QPlaceholderView(frame: self.contentView.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        return view
    }()
    lazy private var iconView: QImageView = {
        let view = QImageView(frame: self.contentView.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        return view
    }()
    
    private var currentEdgeInsets: UIEdgeInsets?
    private var currentImageWidth: CGFloat?
    private var currentImageSpacing: CGFloat?
    private var currentTitleHeight: CGFloat?
    private var currentTitleSpacing: CGFloat?
    private var currentValueHeight: CGFloat?
    private var currentIconWidth: CGFloat?
    private var currentIconSpacing: CGFloat?
    
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
    private var valueConstraints: [NSLayoutConstraint] = [] {
        willSet { self.valueLabel.removeConstraints(self.valueConstraints) }
        didSet { self.valueLabel.addConstraints(self.valueConstraints) }
    }
    private var iconConstraints: [NSLayoutConstraint] = [] {
        willSet { self.iconView.removeConstraints(self.iconConstraints) }
        didSet { self.iconView.addConstraints(self.iconConstraints) }
    }
    
    open override class func size(composable: Composable, spec: IQContainerSpec) -> CGSize {
        let availableWidth = spec.containerAvailableSize.width - (composable.edgeInsets.left + composable.edgeInsets.right)
        let imageSize = composable.image.source.size(CGSize(width: composable.imageWidth, height: availableWidth))
        let iconSize = composable.icon.source.size(CGSize(width: composable.iconWidth, height: availableWidth))
        return CGSize(
            width: spec.containerSize.width,
            height: composable.edgeInsets.top + max(imageSize.height, composable.titleHeight, composable.valueHeight, iconSize.height) + composable.edgeInsets.bottom
        )
    }
    
    open override func preLayout(composable: Composable, spec: IQContainerSpec) {
        let edgeInsets = UIEdgeInsets(
            top: composable.edgeInsets.top,
            left: spec.containerLeftInset + composable.edgeInsets.left,
            bottom: composable.edgeInsets.bottom,
            right: spec.containerRightInset + composable.edgeInsets.right
        )
        if self.currentEdgeInsets != edgeInsets || self.currentImageSpacing != composable.imageSpacing || self.currentTitleSpacing != composable.titleSpacing || self.currentIconSpacing != composable.iconSpacing {
            self.currentEdgeInsets = edgeInsets
            self.currentImageSpacing = composable.imageSpacing
            self.currentTitleSpacing = composable.titleSpacing
            self.currentIconSpacing = composable.iconSpacing
            self.selfConstraints = [
                self.imageView.topLayout == self.contentView.topLayout + edgeInsets.top,
                self.imageView.leadingLayout == self.contentView.leadingLayout + edgeInsets.left,
                self.imageView.trailingLayout == self.titleLabel.leadingLayout - composable.imageSpacing,
                self.imageView.bottomLayout == self.contentView.bottomLayout - edgeInsets.bottom,
                self.titleLabel.topLayout == self.contentView.topLayout + edgeInsets.top,
                self.titleLabel.trailingLayout == self.valueLabel.leadingLayout - composable.titleSpacing,
                self.titleLabel.bottomLayout == self.contentView.bottomLayout - edgeInsets.bottom,
                self.valueLabel.topLayout == self.contentView.topLayout + edgeInsets.top,
                self.valueLabel.trailingLayout == self.iconView.leadingLayout - composable.iconSpacing,
                self.valueLabel.bottomLayout == self.contentView.bottomLayout - edgeInsets.bottom,
                self.iconView.topLayout == self.contentView.topLayout + edgeInsets.top,
                self.iconView.trailingLayout == self.contentView.trailingLayout - edgeInsets.right,
                self.iconView.bottomLayout == self.contentView.bottomLayout - edgeInsets.bottom
            ]
        }
        if self.currentImageWidth != composable.imageWidth {
            self.currentImageWidth = composable.imageWidth
            self.imageConstraints = [
                self.imageView.widthLayout == composable.imageWidth
            ]
        }
        if self.currentTitleHeight != composable.titleHeight {
            self.currentTitleHeight = composable.titleHeight
            self.titleConstraints = [
                self.titleLabel.heightLayout == composable.titleHeight
            ]
        }
        if self.currentValueHeight != composable.valueHeight {
            self.currentValueHeight = composable.valueHeight
            self.valueConstraints = [
                self.valueLabel.heightLayout == composable.valueHeight
            ]
        }
        if self.currentIconWidth != composable.iconWidth {
            self.currentIconWidth = composable.iconWidth
            self.iconConstraints = [
                self.iconView.widthLayout == composable.iconWidth
            ]
        }
    }
    
    open override func apply(composable: Composable, spec: IQContainerSpec) {
        composable.image.apply(self.imageView)
        composable.title.apply(self.titleLabel)
        composable.value.apply(self.valueLabel)
        composable.icon.apply(self.iconView)
    }
    
}