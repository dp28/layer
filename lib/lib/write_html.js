var page = require('webpage').create(),
    system = require('system'),
    fs = require('fs');

page.onConsoleMessage = function(message) {
    system.stdout.writeLine(message);
};

function handleError() {
    console.log('Unable to load the address!');
    phantom.exit(1);
}

function onPageLoad() {
    addContent();
    fs.write(file, page.content, 'w');
    phantom.exit();
}

function addContent() {
    page.evaluate(function(selector, content, type) {
        var element = document.querySelector(selector);
        switch(type) {
            case '-a':
                element.innerHTML = element.innerHTML + content;
                break;

            case '-w':
                element.innerHTML = content;
                break;

            case '-r':
                console.log(element.innerHTML);
                break;

            default: break;
        };
    }, selector, content, type);
}

file = system.args[1];
selector = system.args[2];
content = system.args[3];
type = system.args[4];

address = 'file://' + fs.absolute(file);

page.open(address, function (status) {
    if (status !== 'success') {
        handleError();
    } else {
        onPageLoad();
    }
});