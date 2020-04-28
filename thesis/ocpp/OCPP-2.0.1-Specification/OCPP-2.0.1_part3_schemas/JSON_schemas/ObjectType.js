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
   const regexdotjson = /\.json/g;
   const regexdotslash = /\.\//g;
   var retval = f.replace(regex15118, 'a15118');
   retval = retval.replace(regex_json, '');
   retval = retval.replace(regexdotjson, '');
   retval = retval.replace(regexdotslash, '');
   return retval;
}

function createArrayType(name, schema) {
   console.log('createArrayType:', name, schema);

   var _outfile = cleanfilename('ocpp-' + name + 'TypeArray.ads').toLowerCase();

   var _buffer ="pragma SPARK_mode (on); \n\n";
   _buffer += ('with NonSparkTypes;\n')
   _buffer += ('with ocpp.' + schema.items.javaType + 'Type;\n\n')

   _buffer += ('package ocpp.' + schema.items.javaType + 'TypeArray is\n');

   _buffer += ('type Index is range 1 .. 100;\n')
   _buffer += ('type array_' + schema.items.javaType + 'Type is array (Index) of ocpp.' + schema.items.javaType + 'Type.T;\n')
   _buffer += ('type T is record\n')
   _buffer += ('   content : array_' + schema.items.javaType + 'Type;\n')
   _buffer += ('end record;\n')

   _buffer += ('procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;\n')
   _buffer += ('                     msgindex: in out Integer;\n')
   _buffer += ('                     self: out T;\n')
   _buffer += ('                     valid: out Boolean);\n\n')

   _buffer += ('procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;\n')
   _buffer += ('                   self: in T);\n\n')

   _buffer += ('end ocpp.' + schema.items.javaType + 'TypeArray;\n')


   console.log('\ncreateArrayType: _buffer:\n', _buffer);
   fs.writeFile((_outfile), _buffer, function (err, file) {
      if (err) throw err;
      //console.log('Saved %s', outfile);
   });




   _outfile = cleanfilename('ocpp-' + name + 'TypeArray.adb').toLowerCase();
   _buffer ="pragma SPARK_mode (on); \n\n";

   _buffer ="with Ada.Strings; use Ada.Strings;\n\n";
   _buffer += ('package body ocpp.' + schema.items.javaType + 'TypeArray is\n');
   _buffer += ('procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;\n')
   _buffer += ('                     msgindex: in out Integer;\n')
   _buffer += ('                     self: out T;\n')
   _buffer += ('                     valid: out Boolean)\n')
   _buffer += ('is\n')
   _buffer += ('begin\n')
   _buffer += ('   NonSparkTypes.put_line("' + schema.items.javaType + 'TypeArray.FromString");\n')
   _buffer += ('end FromString;\n\n')

   _buffer += ('procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;\n')
   _buffer += ('                   self: in T)\n')
   _buffer += ('is\n')
   _buffer += ('   dummybounded: NonSparkTypes.packet.Bounded_String;\n')
   _buffer += ('begin\n')
   _buffer += ('   ' + schema.items.javaType + 'Type.To_Bounded_String(self.content(1), dummybounded);\n')
   _buffer += ('   NonSparkTypes.packet.Append(Source => msg, New_Item => dummybounded,Drop => Right);\n')
   _buffer += ('end To_Bounded_String;\n\n')

   _buffer += ('end ocpp.' + schema.items.javaType + 'TypeArray;\n')


   console.log('\ncreateArrayType: _buffer:\n', _buffer);
   fs.writeFile((_outfile), _buffer, function (err, file) {
      if (err) throw err;
      //console.log('Saved %s', outfile);
   });

}

module.exports.parse = function (name, schema) {
   name = cleanfilename(name);
   console.log('parseObjectType: ', name);
   var _outfile
   if (name.endsWith('Request') || name.endsWith('Response')) {
      _outfile = cleanfilename('ocpp-' + name + '.ads');
   } else {
      _outfile = cleanfilename('ocpp-' + name + 'Type.ads');
   }
   //console.log('parseObjectType: _outfile: ', _outfile);
   var _buffer ="pragma SPARK_mode (on); \n\n";
   
   _buffer += ('with Ada.Strings.Fixed; use Ada.Strings.Fixed;\n')
   _buffer += ('with NonSparkTypes; use NonSparkTypes.action_t; \n')
   _buffer += ('with ocpp; use ocpp;\n')


   // include definitions for any types we need
   for (var property in schema.properties) {
      //console.log('property:', property, schema.properties[property]['type']);
      if (property === 'customData') {
         continue;
      }
      
      if (!!schema.properties[property]['type'] && schema.properties[property]['type'] === 'array') {
         createArrayType(property, schema.properties[property]);
         _buffer += ('with ocpp.' + property + 'TypeArray;\n')
      }
   }

   _buffer += utils.parseIncludes(schema);
   _buffer += '\n';

   _buffer += 'package ocpp.' + name + ' is\n';
   if (name.includes('Request') ) {
      _buffer += '   action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("' + utils.parseAction(name) + '"); \n';
      _buffer += '   type T is new call with record\n';
   }
   else if (name.includes('Response') ){
      _buffer += '   type T is new callresult with record\n';
   }
   else {
      _buffer += '   type T is record\n';
   }

   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }

      /*
      console.log("schema.properties[property]:", schema.properties[property] );
      console.log("Object.keys(schema.properties[property]):", Object.keys(schema.properties[property] ));
      console.log('Object.keys(schema.properties[property]["type"]):', schema.properties[property]["type"]);
      */
      var _type = schema.properties[property]['type'] 
      var _javaType = schema.properties[property]['javaType'] 

      switch (_type) {
         case 'array':
            _type = property + 'TypeArray.T';
            break;
         case 'string':
            if (!!_javaType && _javaType.endsWith('Enum') ) {
               _type = _javaType + 'Type.T';
            } else {
               _type = 'NonSparkTypes.' + name + '.str' + property + '_t.Bounded_String';
            }
            break;
         case 'object':
            _type = schema.properties[property]['javaType'] + 'Type.T';
            break;
      }
      _buffer += '      ' + property + ' : ' + _type + ';\n'; 
   }
   _buffer += '   end record;';

   _buffer += '\n';
   _buffer += '   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;\n'
   _buffer += '                msgindex: in out Integer;\n'
   _buffer += '                self: in out ocpp.' + name + '.T;\n'
   _buffer += '                valid: out Boolean\n'
   _buffer += '               )\n'
   _buffer += '   with\n'
   _buffer += '    Global => null,\n'
   _buffer += '    Depends => (\n'
   _buffer += '                valid => (msg, msgindex, self),\n'
   _buffer += '                msgindex => (msg, msgIndex, self),\n'
   _buffer += '                self  => (msg, msgindex, self)\n'
   if (name.endsWith('Request') || name.endsWith('Result')) {
      _buffer += '),\n'
      _buffer += '    post => (if valid = true then\n'
      _buffer += '               (self.messagetypeid = ' + (name.endsWith('Request') ? '2' : '3') + ') and\n'
      _buffer += '               (NonSparkTypes.messageid_t.Length(self.messageid) > 0)';
      if (name.endsWith('Request') ) {
         _buffer += ' and\n';
         _buffer += '               (self.action = action) -- prove that the original packet contains the corresponding "action"\n'
      }
   }
   _buffer += '            );\n\n'
   _buffer += '   procedure To_Bounded_String(Self: in T;\n'
   _buffer += '                               retval: out NonSparkTypes.packet.Bounded_String);\n'
   _buffer += 'end ocpp.' + name + ';';
   //console.log('\n\n\nbuffer:\n', _buffer, '\n\n');
   var outfile = 'ocpp-' + clean(name).toLowerCase() + '.ads';
   fs.writeFile((outfile), _buffer, function (err, file) {
      if (err) throw err;
      //console.log('Saved %s', outfile);
   });

   // source file
   _buffer = "pragma SPARK_mode (on); \n\n";
   _buffer += 'with ocpp;\n';
   _buffer += 'with ocpp.' + name + ';\n';
   _buffer += 'with Ada.Strings; use Ada.Strings;\n\n';
   _buffer += 'package body ocpp.' + name + ' is \n\n';
   _buffer += 'procedure findquotedstring_packet is new findquotedstring(\n'
   _buffer += '                                                             Max => NonSparkTypes.packet.Max_Length, \n'
   _buffer += '                                                             string_t => NonSparkTypes.packet.Bounded_String, \n'
   _buffer += '                                                             length => NonSparkTypes.packet.Length,\n'
   _buffer += '                                                             To_String => NonSparkTypes.packet.to_string,\n'
   _buffer += '                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String\n'
   _buffer += '                                                            );\n\n'
   _buffer += '   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;\n';
   _buffer += '                   msgindex: in out Integer;\n';
   _buffer += '                   self: in out ocpp.' + name + '.T;\n';
   _buffer += '                   valid: out Boolean\n';
   _buffer += '                  )\n';
   _buffer += '   is\n';

   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }
      var type = schema.properties[property]["type"];   // int, string
      var _javaType = schema.properties[property]['javaType'] 

      switch (type) {
         case "array":
            _buffer += '      str' + property + ': NonSparkTypes.packet.Bounded_String;\n';
            break;
         default:
            break;
      }
   }

   _buffer += '      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");\n';
   _buffer += '      dummyInt: integer;\n';


   _buffer += '   begin\n';

   if (name.endsWith('Request') || name.endsWith('Response')) {
      _buffer += '      checkValid(msg, msgindex, self, ' + (name.endsWith('Request') ? 'action, ' : '') + 'valid);\n'
      _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n\n'
   }

   // parse each property
   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }

      var type = schema.properties[property]["type"];   // int, string
      var _javaType = schema.properties[property]['javaType'] 

      switch (type) {
         case 'integer':
            _buffer += '      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "' + property + '", dummyInt);\n';
            _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n'
            _buffer += '      self.' + property + ' := dummyInt;\n';
            break;
         case 'string':
            if (!!_javaType && _javaType.endsWith('Enum')) { // eg: getBaseReportRequest.reportBase : ocpp.ReportBaseEnum
               _buffer += '      ocpp.' + _javaType + 'Type.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.' + property + ', valid);\n';
               _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n'
          } else
            {
               _buffer += '      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "' + property + '", dummybounded);\n';
               _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n'
               _buffer += '      self.' + property + ' := NonSparkTypes.' + name + '.str' + property + '_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);\n';
            }
            
            break;
         case 'array':
            _buffer += '      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "' + property + '", dummybounded);\n';
            _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n\n'
            _buffer += '      ' + schema.properties[property]["items"]["javaType"] + 'TypeArray.FromString(msg, msgindex, self.' + property + ', valid);\n';
            _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n'
            break;
         default:
            switch (_javaType) {
               default: 
                  if (!!_javaType && _javaType.endsWith('Enum')) {
                  } else {
                     _buffer += '      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "' + property + '", dummybounded);\n';
                     _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n\n'
                     _buffer += '      ' + utils.parseType(schema.properties[property]) + 'Type.parse(msg, msgindex, self.' + property + ', valid);\n';
                     _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n'
                  }
                  break;
               }
      }
      _buffer += '\n';

   }
   _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n'



   _buffer += '      valid := true;\n'
   _buffer += '   end parse;\n\n';
   _buffer += '   procedure To_Bounded_String(Self: in T;\n';
   _buffer += '                               retval: out NonSparkTypes.packet.Bounded_String)\n';
   _buffer += '   is\n';
   _buffer += '      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); \n';

   // for every string type member variable, add a string buffer
   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }
      var type = schema.properties[property]["type"];   // int, string
      var _javaType = schema.properties[property]['javaType'] 

      switch (type) {
         case 'integer':
            break;
         case 'string':
            if (!!_javaType && _javaType.endsWith('Enum')) {
               _buffer += '      str' + property + ' : ' + _javaType + 'Type.string_t.Bounded_String;\n';
            }
            break;
         case "array":
            _buffer += '      str' + property + ': NonSparkTypes.packet.Bounded_String;\n';
            break;
         default:
            if (!!type) {
               _buffer += '      str' + property + ' : NonSparkTypes.packet.Bounded_String;\n';
            }
            break;
      }
   }

   _buffer += '   begin\n';
   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }
      var type = schema.properties[property]["type"];   // int, string
      var _javaType = schema.properties[property]['javaType'] 

      switch (type) {
         case 'integer':
            break;
         case 'string':
            if (!!_javaType && _javaType.endsWith('Enum')) {
               _buffer += '      ' + _javaType + 'Type.ToString(Self.' + property + ', str' + property + ');\n';
            }
            break;
         case 'object':
            if (!!_javaType) {
               _buffer += '      ' + _javaType + 'Type.To_Bounded_String(Self.' + property + ', str' + property + ');\n';
            }
            break;
         case "array":
            _buffer += '      ' + schema.properties[property]["items"]["javaType"] + 'TypeArray.To_Bounded_String(str' + property + ', self.' + property + ');\n';
            break;
         default:
            break;
      }
   }

   _buffer +=    '      retval := NonSparkTypes.packet.To_Bounded_String(""\n';
   
   if (name.endsWith('Request') ) {
      _buffer += '                                                      & "[2," & ASCII.LF\n';
      _buffer +=    '                                                      & \'"\'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & \'"\' & "," & ASCII.LF\n';
   }
   else if (name.endsWith('Response')){
      _buffer += '                                                      & "[3," & ASCII.LF\n';
      _buffer +=    '                                                      & \'"\'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & \'"\' & "," & ASCII.LF\n';
   }
   
   if (name.endsWith('Request') ) {
      _buffer += '                                                      & \'"\' & NonSparkTypes.action_t.To_String(Self.action) & \'"\' & "," & ASCII.LF\n';
      
   }
   _buffer +=    '                                                      & "{" & ASCII.LF\n';

   //console.log("schema.properties:", schema.properties, Object.keys(schema.properties).length);
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
                                                                                 ' & ' + 'Self.' + property + '\'Image';
            break;
         case 'object':
            _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ": " & ASCII.LF' 
            break;
         case 'array':
               _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ": " & NonSparkTypes.packet.To_String(str' + property + ') & ": "' 
            break;
         case 'string':
               _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ": " & \'"\' & NonSparkTypes.' + name + '.str' + property + '_t.To_String(Self.' + property + ') & \'"\' & ": "' 
            break;
         default:
            if (type.endsWith('EnumType')) {
               _buffer +=    '                                                      & "       " & \'"\' & "' + property + '" & \'"\' & ":"  & \'"\' & ' + type + '.string_t.To_String(str' + property + ') & \'"\'' 
            } else if (type.endsWith('Type')) {
               _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ":" & NonSparkTypes.packet.To_String(str' + property + ') & ": "\n' 
            } else {
               _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ": "' + 
                                                                                    ' & \'"\' & ' + schema.properties[property]["javaType"] + 'Type.string_t.To_String(str' + property + ') & \'"\'';
            }
            break;
      }
      
      _buffer += ((propertyCounter === (Object.keys(schema.properties).length)) ? '' : ' & ","') + // append a comma to all but the last property
                                                                                 ' & ASCII.LF\n';


   }

   _buffer +=    '                                                      & "}" & ASCII.LF\n';


   if (name.endsWith('Request') || name.endsWith('Response')) {
      _buffer += '                                                      & "]"';
   }

   _buffer += ', Drop => Right);\n'
   _buffer += '   end To_Bounded_String;\n';
   


   _buffer += 'end ocpp.' + name + ';\n';
   outfile = 'ocpp-' + clean(name).toLowerCase() + '.adb';
   fs.writeFile((outfile), _buffer, function (err, file) {
      if (err) throw err;
      //console.log('Saved %s', outfile);
   });
}
}());
                        
