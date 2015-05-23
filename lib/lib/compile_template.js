var jade = require('jade');
var fs = require('fs');

var template = fs.readFileSync(process.argv[2], 'utf8');
var rawJson = fs.readFileSync(process.argv[3], 'utf8');
var json = JSON.parse(rawJson);
var compiledHtml = jade.compile(template, {pretty: true})(json);

fs.writeFile(process.argv[4], compiledHtml, function(error) {
  if (error) console.log("Unable to write to " + process.argv[4]);
});