var page = require('webpage').create(),
    system = require('system'),
    fs = require('fs');

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
    page.evaluate(function(selector, content, append) {
        var element = document.querySelector(selector);
        if (typeof append !== 'undefined' && append === '-a') {
            element.innerHTML = element.innerHTML + content;
        }
        else {
             element.innerHTML = content;
        }
    }, selector, content, append);
}

file = system.args[1];
selector = system.args[2];
content = system.args[3];
append = system.args[4];

address = 'file://' + fs.absolute(file);

page.open(address, function (status) {
    if (status !== 'success') {
        handleError();
    } else {
        onPageLoad();
    }
});