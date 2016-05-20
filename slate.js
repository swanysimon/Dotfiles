// slate.js
// Simon Swanson

/*
 * current screen and window size functions
 */

function screenOriginX() {
    return slate.window().screen().visibleRect().x;
}

function screenOriginY() {
    return slate.window().screen().visibleRect().y;
}

function screenWidth() {
    return slate.window().screen().visibleRect().width;
}

function screenHeight() {
    return slate.window().screen().visibleRect().height;
}

function fullScreenOriginX() {
    return slate.window().screen().rect().x;
}

function fullScreenOriginY() {
    return slate.window().screen().rect().y;
}

function fullScreenWidth() {
    return slate.window().screen().rect().width;
}

function fullScreenHeight() {
    return slate.window().screen().rect().height;
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

function isOSXFullScreen() {
    return 
        screenOriginX() == fullScreenOriginX() &&
        screenOriginY() == fullScreenOriginY() &&
        screenWidth()   == fullScreenWidth()   &&
        screenHeight()  == fullScreenHeight();
}


/*
 * window snapping operation variables
 */

var fullscreen = slate.operation("move", {
    "x"     : screenOriginX(),
    "y"     : screenOriginY(),
    "width" : screenWidth(),
    "height": screenHeight()
});

var center = slate.operation("move", {
    "x"     : screenOriginX() + (screenWidth() - windowWidth()) / 2,
    "y"     : screenOriginY() + (screenHeight() - windowHeight()) / 2,
    "width" : windowWidth(),
    "height": windowHeight()
});

var centerResize = slate.operation("move", {
    "x"     : screenOriginX() + screenWidth() / 8,
    "y"     : screenOriginY() + screenHeight() / 8,
    "width" : screenWidth() * 3 / 4,
    "height": screenHeight() * 3 / 4
});

var lefthalf = slate.operation("move", {
    "x"     : screenOriginX(),
    "y"     : screenOriginY(),
    "width" : screenWidth() / 2,
    "height": screenHeight()
});

var righthalf = slate.operation("move", {
    "x"     : screenOriginX() + screenWidth() / 2,
    "y"     : screenOriginY(),
    "width" : screenWidth() / 2,
    "height": screenHeight()
});


/*
 * bindings
 */

slate.bind("c:alt", function(window) {
    if (window.isMovable()) {
        window.doOperation(center);
    }
    return;
});

slate.bind("c:alt,shift", function(window) {
    if (window.isMovable()) {
        window.doOperation(centerResize);
    }
    return;
});

slate.bind("f:alt", function(window) {
    if (window.isMovable()) {
        window.doOperation(fullscreen);
    }
    return;
});

slate.bind("j:alt", function(window) {
    if (window.isMovable()) {
        window.doOperation(lefthalf);
    }
    return;
});

slate.bind("l:alt", function(window) {
    if (window.isMovable()) {
        window.doOperation(righthalf);
    }
    return;
});

