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

module.exports.parse = function (name, schema) {

         name = cleanfilename(name);
         console.log('parseObjectType: ', name);
         var _outfile = cleanfilename('ocpp-' + name + '.ads');
         console.log('parseObjectType: _outfile: ', _outfile);
         var _buffer ="pragma SPARK_mode (on); \n\n";
         
         _buffer += ('with Ada.Strings.Fixed; use Ada.Strings.Fixed;\n')
         _buffer += ('with NonSparkTypes; use NonSparkTypes.action_t; \n')
         _buffer += ('with ocpp; use ocpp;\n')
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
            console.log("schema.properties[property]:", schema.properties[property] );
            console.log("Object.keys(schema.properties[property]):", Object.keys(schema.properties[property] ));
            console.log('Object.keys(schema.properties[property]["type"]):', schema.properties[property]["type"]);
            var _type = utils.parseType(schema.properties[property]) 
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
         _buffer += '               ),\n'
         _buffer += '    post => (if valid = true then\n'
         _buffer += '               (self.messagetypeid = ' + (name.endsWith('Request') ? '2' : '3') + ') and\n'
         _buffer += '               (NonSparkTypes.messageid_t.Length(self.messageid) > 0)';
         if (name.endsWith('Request') ) {
            _buffer += ' and\n';
            _buffer += '               (self.action = action) -- prove that the original packet contains the corresponding "action"\n'

         }
         _buffer += '            );\n\n'
         _buffer += '   procedure To_Bounded_String(Self: in T;\n'
         _buffer += '                               retval: out NonSparkTypes.packet.Bounded_String);\n'
         _buffer += 'end ocpp.' + name + ';';
         console.log('\n\n\nbuffer:\n', _buffer, '\n\n');
         var outfile = 'ocpp-' + clean(name).toLowerCase() + '.ads';
         fs.writeFile((outfile), _buffer, function (err, file) {
            if (err) throw err;
            console.log('Saved %s', outfile);
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

         /*
         for (var property in schema.properties) {
            if (property === 'customData') {
               continue;
            }
            _buffer += '      str' + property + ' : ' + schema.properties[property]["javaType"] + 'Type.string_t.Bounded_string;\n';
         }*/

         _buffer += '      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");\n';
         _buffer += '      dummyInt: integer;\n';


         _buffer += '   begin\n';
         _buffer += '      checkValid(msg, msgindex, self, ' + (name.endsWith('Request') ? 'action, ' : '') + 'valid);\n'
         _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n\n'

         // parse each property
         for (var property in schema.properties) {
            if (property === 'customData') {
               continue;
            }

            var type = schema.properties[property]["type"];   // int, string
                  //findquotedstring_packet(msg, msgindex, retval, dummybounded);

            switch (type) {
               case 'integer':
                  _buffer += '      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "' + property + '", dummyInt);\n';
                  _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n'
                  _buffer += '      self.' + property + ' := dummyInt;\n';
                  break;
               default:
                  _buffer += '      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "' + property + '", dummybounded);\n';
                  _buffer += '      if (valid = false) then NonSparkTypes.put_line("Invalid ' + schema + '"); return; end if;\n\n'
                  _buffer += '      ' + utils.parseType(schema.properties[property]) + 'Type.FromString(NonSparkTypes.packet.To_String(dummybounded), self.' + property + ', valid);\n';
                  break;
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
         if (name.endsWith('Request') ) {
            _buffer += '                                                      & "[2," & ASCII.LF\n';
         }
         else {
            _buffer += '                                                      & "[3," & ASCII.LF\n';
         }
         
         _buffer +=    '                                                      & \'"\'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & \'"\' & "," & ASCII.LF\n';
         if (name.endsWith('Request') ) {
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
         
      
      
         _buffer += 'end ocpp.' + schema + ';\n';
         outfile = 'ocpp-' + clean(name).toLowerCase() + '.adb';
         fs.writeFile((outfile), _buffer, function (err, file) {
            if (err) throw err;
            console.log('Saved %s', outfile);
         });
         console.log('\n\n\nbuffer:\n', _buffer, '\n\n');
      
      
      
      
      
      
      
      








}
}());
                        
