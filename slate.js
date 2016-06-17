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

function fullScreenOriginX() {
    return slate.screen().rect().x;
}

function fullScreenOriginY() {
    return slate.screen().rect().y;
}

function fullScreenWidth() {
    return slate.screen().rect().width;
}

function fullScreenHeight() {
    return slate.screen().rect().height;
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
    window.doOperation(slate.operation("move", {
        "x"     : screenOriginX(),
        "y"     : screenOriginY(),
        "width" : screenWidth(),
        "height": screenHeight()
    }));
    return;
}

function center(window) {
    window.doOperation(slate.operation("move", {
        "x"     : screenOriginX() + (screenWidth() - windowWidth()) / 2,
        "y"     : screenOriginY() + (screenHeight() - windowHeight()) / 2,
        "width" : windowWidth(),
        "height": windowHeight()
    }));
    return;
}

function centerResize(window) {
    window.doOperation(slate.operation("move", {
        "x"     : screenOriginX() + screenWidth() / 8,
        "y"     : screenOriginY() + screenHeight() / 8,
        "width" : screenWidth() * 3 / 4,
        "height": screenHeight() * 3 / 4
    }));
    return;
}

function lefthalf(window) {
    window.doOperation(slate.operation("move", {
        "x"     : screenOriginX(),
        "y"     : screenOriginY(),
        "width" : screenWidth() / 2,
        "height": screenHeight()
    }));
    return;
}

function righthalf(window) {
    window.doOperation(slate.operation("move", {
        "x"     : screenOriginX() + screenWidth() / 2,
        "y"     : screenOriginY(),
        "width" : screenWidth() / 2,
        "height": screenHeight()
    }));
    return;
}


/*
 * bindings
 */

slate.bind("c:alt", function(window) {
    if (window.isMovable()) {
        centerResize(window);
    }
});

slate.bind("c:alt,shift", function(window) {
    if (window.isMovable()) {
        center(window);
    }
});

slate.bind("f:alt", function(window) {
    if (window.isMovable()) {
        fullscreen(window);
    }
});

slate.bind("j:alt", function(window) {
    if (window.isMovable()) {
        lefthalf(window);
    }
});

slate.bind("l:alt", function(window) {
    if (window.isMovable()) {
        righthalf(window);
    }
});

