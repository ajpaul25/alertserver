'use strict';

var normalizedPath = require("path").join(__dirname);

require("fs").readdirSync(normalizedPath).forEach(function(file) {
  var filetok = file.split('.');
  if( filetok[1] == 'js' )
    module.exports[filetok[0]] = require("./" + file);
});

