var page = require('webpage').create(),
    system = require('system'),
    address, output, size;

address = system.args[1];
output = system.args[2];
page.viewportSize = { width: 600, height: 600 };

size = system.args[3].split('*');
pageWidth = parseInt(size[0], 10);
pageHeight = parseInt(size[1], 10);
page.viewportSize = { width: pageWidth, height: pageHeight };
page.clipRect = { top: 0, left: 0, width: pageWidth, height: pageHeight };

page.open(address, function (status) {
    if (status !== 'success') {
        console.log('Unable to load the address!');
        phantom.exit(1);
    } else {
        page.render(output);
        phantom.exit();
    }
});
