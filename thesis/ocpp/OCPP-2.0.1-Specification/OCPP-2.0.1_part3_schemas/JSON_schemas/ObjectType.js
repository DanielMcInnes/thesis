(function() {

var fs = require('fs');
var utils = require('./utils.js');
function clean(f) {
   // Some of the names in the json files are invalid SPARK. replace them with something that isn't.
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
   const regex_json = /_json/g;
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
   retval = retval.replace(regex_json, '');
   return retval;
}

function cleanfilename(f) {
   const regex15118 = /15118/g;
   const regex_json = /_json/g;
   var retval = f.replace(regex15118, 'a15118');
   retval = retval.replace(regex_json, '');
   return retval;
}

module.exports.parse = function (_filename) {
   var _datafile = require(_filename);
   const $RefParser = require("@apidevtools/json-schema-ref-parser");
   $RefParser.dereference(_datafile, (err, schema) => {
      if (err) {
         console.error(err);
         return;
      }
      else {
         // `schema` is just a normal JavaScript object that contains your entire JSON Schema,
         // including referenced files, combined into a single object


         var _package = clean(_filename);
         console.log('parseObjectType: ', _filename);
         var _outfile = cleanfilename('ocpp-' + _package + '.ads');
         console.log('parseObjectType: _outfile: ', _outfile);
         var _buffer ="pragma SPARK_mode (on); \n\n";
         
         _buffer += ('with Ada.Strings.Fixed; use Ada.Strings.Fixed;\n')
         _buffer += ('with NonSparkTypes; use NonSparkTypes.action_t; \n')
         _buffer += ('with ocpp; use ocpp;\n')
         _buffer += utils.parseIncludes(schema);
         _buffer += '\n';
      
         _buffer += 'package ocpp.' + _package + ' is\n';
         if (_package.includes('Request') ) {
            _buffer += '   action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("' + utils.parseAction(_package) + '"); \n';
            _buffer += '   type T is new call with record\n';
         }
         else {
            _buffer += '   type T is new callresult with record\n';
         }

         for (var property in schema.properties) {
            if (property === 'customData') {
               continue;
            }
            console.log("schema.properties[property]:", schema.properties[property] );
            console.log("Object.keys(schema.properties[property]):", Object.keys(schema.properties[property] ));
            console.log('Object.keys(schema.properties[property]["type"]):', schema.properties[property]["type"]);
            var _type = schema.properties[property]["javaType"]
            if (!! _type) {
               _type += 'Type.T';
            } else {
               _type = schema.properties[property]["type"]
            }
            _buffer += '      ' + property + ' : ' + _type + ';\n';
         }
         _buffer += '   end record;';
      
         _buffer += '\n';
         _buffer += '   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;\n'
         _buffer += '                msgindex: in Integer;\n'
         _buffer += '                packet: in ocpp.' + _package + '.T;\n'
         _buffer += '                valid: out Boolean\n'
         _buffer += '               )\n'
         _buffer += '   with\n'
         _buffer += '    Global => null,\n'
         _buffer += '    Depends => (\n'
         _buffer += '                valid => (msg, msgindex, packet)\n'
         _buffer += '               ),\n'
         _buffer += '    post => (if valid = true then\n'
         _buffer += '               (packet.messagetypeid = 2) and\n'
         _buffer += '               (NonSparkTypes.messageid_t.Length(packet.messageid) > 0) and\n'
         _buffer += '               (packet.action = action) -- prove that the original packet contains the corresponding "action"\n'
         _buffer += '            );\n\n'
         _buffer += '   procedure To_Bounded_String(Self: in T;\n'
         _buffer += '                               retval: out NonSparkTypes.packet.Bounded_String);\n'
         _buffer += 'end ocpp.' + _package + ';';
         console.log('\n\n\nbuffer:\n', _buffer, '\n\n');
         var outfile = 'ocpp-' + clean(_package).toLowerCase() + '.ads';
         fs.writeFile((outfile), _buffer, function (err, file) {
            if (err) throw err;
            console.log('Saved %s', outfile);
         });
      
         // source file
         _buffer = "pragma SPARK_mode (on); \n\n";
         _buffer += 'with ocpp.' + _package + ';\n';
         _buffer += 'with Ada.Strings; use Ada.Strings;\n\n';
         _buffer += 'package body ocpp.' + _package + ' is \n';
         _buffer += '   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;\n';
         _buffer += '                   msgindex: in Integer;\n';
         _buffer += '                   packet: in ocpp.' + _package + '.T;\n';
         _buffer += '                   valid: out Boolean\n';
         _buffer += '                  )\n';
         _buffer += '   is\n';

         /*
         // parse each property
         for (var property in schema.properties) {
            if (property === 'customData') {
               continue;
            }

            var type = schema.properties[property]["type"];   // int, string
            if (!!type && type === "string") {
               _buffer += '      str' + property + ' : ' + schema.properties[property]["javaType"] + 'Type.string_t.Bounded_string;\n';
            }
            switch (type) {
               case 'integer':
                  //_buffer += '      packet.' + property + ' := '
                  break;
               default:
                  break;
            }
            _buffer += '\n';

         }
         */
         _buffer += '   begin\n';
         _buffer += '      checkValid(msg, msgindex, packet, action, valid);\n'

         // parse each property
         for (var property in schema.properties) {
            if (property === 'customData') {
               continue;
            }

            var type = schema.properties[property]["type"];   // int, string
            if (!!type && type === "string") {
               //_buffer += '      str' + property + ' : ' + schema.properties[property]["javaType"] + 'Type.string_t.Bounded_string;\n';
            }
            switch (type) {
               case 'integer':
                  //_buffer += '      packet.' + property + ' := '
                  break;
               default:
                  break;
            }
            _buffer += '\n';

         }
         _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + _package + '"); return; end if;\n'



         _buffer += '      valid := true;\n'
         _buffer += '   end parse;\n\n';
         _buffer += '   procedure To_Bounded_String(Self: in T;\n';
         _buffer += '                               retval: out NonSparkTypes.packet.Bounded_String)\n';
         _buffer += '   is\n';

         // for every string type member variable, add a string buffer
         for (var property in schema.properties) {
            if (property === 'customData') {
               continue;
            }
            var type = schema.properties[property]["type"];   // int, string
            if (!!type && type === "string") {
               _buffer += '      str' + property + ' : ' + schema.properties[property]["javaType"] + 'Type.string_t.Bounded_string;\n';
            }
         }

         _buffer += '   begin\n';

         // for every enum type member variable, convert to string
         for (var property in schema.properties) {
            if (property === 'customData') {
               continue;
            }
            var type = schema.properties[property]["type"];   // int, string
            if (!!type && type === "string") {
               _buffer += '      ' + schema.properties[property]["javaType"] + 'Type.ToString(Self.' + property + ', str' + property + ');\n';
            }
         }

         _buffer +=    '      retval := NonSparkTypes.packet.To_Bounded_String(""\n';
         if (_package.includes('Request') ) {
            _buffer += '                                                      & "[2," & ASCII.LF\n';
         }
         else {
            _buffer += '                                                      & "[3," & ASCII.LF\n';
         }
         
         _buffer +=    '                                                      & \'"\'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & \'"\' & "," & ASCII.LF\n';
         if (_package.includes('Request') ) {
            _buffer += '                                                      & \'"\' & NonSparkTypes.action_t.To_String(Self.action) & \'"\' & "," & ASCII.LF\n';
            
         }
         _buffer +=    '                                                      & "{" & ASCII.LF\n';

         console.log("schema.properties:", schema.properties, Object.keys(schema.properties).length);
         var propertyCounter = 0
         for (var property in schema.properties) {
            propertyCounter++
            if (property === 'customData') {
               continue;
            }
            var type = schema.properties[property]["javaType"];   // int, string
            if (!!type) {
               type += 'Type';
            } else {
               type = schema.properties[property]["type"];   // int, string
            }
            switch (type) {
               case 'integer':
                  _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ": "' +
                                                                                       ' & ' + 'Self.' + property + '\'Image' +
                                                                                       ((propertyCounter === (Object.keys(schema.properties).length)) ? '' : ' & ","') + // append a comma to all but the last property
                                                                                       ' & ASCII.LF\n';
                  break;
               default:
                  _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ": "' + 
                                                                                       ' & \'"\' & ' + schema.properties[property]["javaType"] + 'Type.string_t.To_String(str' + property + ') & \'"\'' +
                                                                                       ((propertyCounter === (Object.keys(schema.properties).length)) ? '' : ' & ","') + // append a comma to all but the last property
                                                                                       ' & ASCII.LF\n'; 
                  // & "    " & ReportBaseEnumType.string_t.To_String(strreportBase) & ASCII.LF
                  break;
            }

         }
      
         _buffer +=    '                                                      & "}" & ASCII.LF\n';
      
      
         _buffer += '                                                      & "]", Drop => Right);\n';
      
      
         _buffer += '   end To_Bounded_String;\n';
         
      
      
         _buffer += 'end ocpp.' + _package + ';\n';
         outfile = 'ocpp-' + clean(_package).toLowerCase() + '.adb';
         fs.writeFile((outfile), _buffer, function (err, file) {
            if (err) throw err;
            console.log('Saved %s', outfile);
         });
         console.log('\n\n\nbuffer:\n', _buffer, '\n\n');
      
      
      
      
      
      
      
      
      }
   })
}
}());
                        
