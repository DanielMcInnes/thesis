var fs = require('fs');
var utils = require('./utils');
var EnumType = require('./EnumType');
var ObjectType = require('./ObjectType');

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
   const $RefParser = require("@apidevtools/json-schema-ref-parser");
   $RefParser.dereference(_datafile, (err, schema) => {
      if (err) {
         console.error(err);
         return;
      }
      else {
         // `schema` is just a normal JavaScript object that contains your entire JSON Schema,
         // including referenced files, combined into a single object
         if (schema.type === 'object') {
            ObjectType.parse(f, schema);
         }

         for (var i in schema.definitions) {
            //console.log('parseJsonFile: i:', i, 'schema.definitions[i].type:', schema.definitions[i].type)
            if (i.endsWith('EnumType')) {
               EnumType.parse(schema.definitions, i);
            }
            if (schema.definitions[i].type === ('object') && i != 'CustomDataType') {
               //console.log('parseJsonFile: found object.', i )
               ObjectType.parse(i, schema.definitions[i]);
            }
         }
      }
   })
}

if (process.argv.length <= 2) {
   console.log("Usage: " + __filename + " path/to/directory");
   process.exit(-1);
}

parseJsonFile('./BootNotificationRequest.json')
parseJsonFile('./GetBaseReportRequest.json')
parseJsonFile('./GetBaseReportResponse.json')
parseJsonFile('./GetVariablesRequest.json')
parseJsonFile('./GetVariablesResponse.json')
parseJsonFile('./SetVariablesRequest.json')
parseJsonFile('./SetVariablesResponse.json')
parseJsonFile('./StatusNotificationRequest.json')

parseJsonFile('./StatusNotificationResponse.json')

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
