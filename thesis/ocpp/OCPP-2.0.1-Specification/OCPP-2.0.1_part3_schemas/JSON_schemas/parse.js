var fs = require('fs');
var EnumType = require('./EnumType');
var ObjectType = require('./ObjectType');
/*
function error(err) {
  if (err) throw err;
  console.log('Saved!');
}
*/
function clean(f) {
   const regex = / /g;
   const regexdotslash = /\.\//g;
   const regexbody = /body/gi;
   const regexperiod = /\./gi;
   const regexhyphen = /-/g;
   const regex15118 = /15118/g;
   const regexdelta = /delta/gi;
   const regexstring = /string/gi;
   const regexboolean = /boolean/gi;
   const regexdotjson = /\.json/gi;
   var retval = f.replace(regex, '_');
   retval = retval.replace(regexdotslash, '');
   retval = retval.replace(regexbody, 'ABody');
   retval = retval.replace(regexperiod, '_');
   retval = retval.replace(regexhyphen, '_');
   retval = retval.replace(regex15118, 'a15118');
   retval = retval.replace(regexdelta, 'zzzDelta');
   retval = retval.replace(regexstring, 'zzzstring');
   retval = retval.replace(regexboolean, 'zzzboolean');
   retval = retval.replace(regexdotjson, '');
   return retval;
}

function cleanfilename(f) {
   const regex15118 = /15118/g;
   var retval = f.replace(regex15118, 'a15118');
   return retval;
}

function parseJsonFile(f) {
   var _datafile = require(f);
   var _definitions = _datafile.definitions;

   if (_datafile.type === 'object') {
      ObjectType.parse(f);
   }

   for (var i in _definitions) {
      //console.log(i);
      if (i.endsWith('EnumType')) {
         EnumType.parse(_definitions, i);
      }
      if (i.type === ('object')) {
         ObjectType.parse(f);
      }
   }
}

if (process.argv.length <= 2) {
   console.log("Usage: " + __filename + " path/to/directory");
   process.exit(-1);
}

parseJsonFile('./GetBaseReportRequest.json')
//parseJsonFile('./BootNotificationRequest.json')

var path = process.argv[2];

/*
fs.readdir(path, function(err, items) {
    //console.log(items);
 
   if (!!items.length) {
      for (var i=0; i<items.length; i++) {
         if (items[i].endsWith('json')) {	  
            var filename = "./" + items[i];
            console.log("parsing: ", filename);
            parseJsonFile(filename);
         }
      }
   }
}
);
*/