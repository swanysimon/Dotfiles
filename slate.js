// slate.js
// Simon Swanson

/*
 * current screen and window size functions
 */

function screenOriginX() {
    return slate.screen().visibleRect().x;
}

function screenOriginY() {
    return slate.screen().visibleRect().y;
}

function screenWidth() {
    return slate.screen().visibleRect().width;
}

function screenHeight() {
    return slate.screen().visibleRect().height;
}

function windowOriginX() {
    return slate.window().rect().x;
}

function windowOriginY() {
    return slate.window().rect().y;
}

function windowWidth() {
    return slate.window().rect().width;
}

function windowHeight() {
    return slate.window().rect().height;
}

/*
 * window snapping operations
 */

function fullscreen(window) {
    window.doOperation(__centerOperation(screenWidth(), screenHeight()));
}

function __centerOperation(requestedWidth, requestedHeight) {
    var newWidth = __newSize("width", requestedWidth);
    var newHeight = __newSize("height", requestedHeight);
    return slate.operation("move", {
        "x": __newCenteredOrigin("x", newWidth),
        "y": __newCenteredOrigin("y", newHeight),
        "width": newWidth,
        "height": newHeight
    });
}

function __newSize(widthOrHeight, requestedSize) {
    if (widthOrHeight === "width") {
        return slate.window().isResizable() ? requestedSize : windowWidth();
    } else {
        return slate.window().isResizable() ? requestedSize : windowHeight();
    }
}

function __newCenteredOrigin(xOrY, desiredSize) {
    if (xOrY === "x") {
        return screenOriginX() + (screenWidth() - desiredSize) / 2;
    } else {
        return screenOriginY() + (screenHeight() - desiredSize) / 2;
    }
}

function center(window) {
    window.doOperation(__centerOperation(windowWidth(), windowHeight()));
}

function moveLeft(window) {
    window.doOperation(__resizeToEdgeOperation(__ratioOfScreenX(1/2), screenHeight(), "left"));
}

function __ratioOfScreenX(screenSizeRatio) {
    return screenWidth() * screenSizeRatio;
}

function __resizeToEdgeOperation(desiredWidth, desiredHeight, desiredDirection) {
    var centerResize = __centerOperation(desiredWidth, desiredHeight);
    var pushToEdge = slate.operation("push", {
        "direction": desiredDirection,
    });
    return slate.operation("sequence", {
        "operations": [[ centerResize, pushToEdge ]]
    });
}

function moveDown(window) {
    window.doOperation(__resizeToEdgeOperation(screenWidth(), __ratioOfScreenY(1/2), "down"));
}

function __ratioOfScreenY(screenSizeRatio) {
    return screenHeight() * screenSizeRatio;
}

function moveUp(window) {
    window.doOperation(__resizeToEdgeOperation(screenWidth(), __ratioOfScreenY(1/2), "up"));
}

function moveRight(window) {
    window.doOperation(__resizeToEdgeOperation(__ratioOfScreenX(1/2), screenHeight(), "right"));
}

/*
 * bindings
 */

slate.bind("f:cmd,ctrl", fullscreen);
slate.bind("f:alt", fullscreen);
slate.bind("c:alt", center);
slate.bind("h:alt", moveLeft);
slate.bind("j:alt", moveDown);
slate.bind("k:alt", moveUp);
slate.bind("l:alt", moveRight);

