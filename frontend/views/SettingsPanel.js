var
  kind = require('enyo/kind'),
  Panel = require('moonstone/Panel'),
  FittableColumns = require('layout/FittableColumns'),
  BodyText = require('moonstone/BodyText'),
  LunaService = require('enyo-webos/LunaService'),
  Divider = require('moonstone/Divider'),
  Scroller = require('moonstone/Scroller'),
  Item = require('moonstone/Item'),
  ToggleItem = require('moonstone/ToggleItem'),
  LabeledTextItem = require('moonstone/LabeledTextItem');
  ExpandablePicker = require('moonstone/ExpandablePicker');
  IconButton = require('moonstone/IconButton');
var serviceName = "org.webosbrew.hyperhdr.loader.service";
var lunaServiceUri = "luna://" + serviceName;
var servicePath = "/media/developer/apps/usr/palm/services/" + serviceName;


module.exports = kind({
  name: 'SettingsPanel',
  kind: Panel,
  title: 'Settings',
  headerType: 'medium',
  components: [
    {kind: FittableColumns, classes: 'enyo-center', fit: true, components: [
      {kind: Scroller, fit: true, components: [
        {classes: 'moon-hspacing', controlClasses: 'moon-12h', components: [
          {components: [
            // {kind: Divider, content: 'Toggle Items'},
            {kind: ExpandablePicker, noneText: 'Nothing selected',
            content: 'Install Lut version', components: [
                {content: 'Compressed zst SDR|HDR|DV [NV12] (@satdx62)', onchange: 'Lut1'},
                {content: 'Uncompressed  SDR|HDR|DV [NV12] (@satdx62)', onchange: 'Lut2'},
                {content: 'Default', onchange: 'Lut'},
            ]}
          ]},
        ]},
      ]},
    ]},
    {components: [
      {kind: Divider, content: 'Result'},
      {kind: BodyText, name: 'result', content: 'Nothing selected...'}
    ]},
    {kind: LunaService, name: 'exec', service: 'luna://org.webosbrew.hbchannel.service', method: 'exec', onResponse: 'onExec', onError: 'onExec'},
    {kind: LunaService, name: 'execSilent', service: 'luna://org.webosbrew.hbchannel.service', method: 'exec'},
  ],

  resultText: 'unknown',


  bindings: [
    {from: "resultText", to: '$.result.content'}
  ],

  exec: function (command) {
    console.info("exec called");
    console.info(command);
    this.set('resultText','Processing...');
    this.$.exec.send({
      command: command,
    });
  },
  onExec: function (sender, evt) {
    console.info("onExec");
    console.info(evt);
    if (evt.returnValue) {
      this.set('resultText','Success!<br />' + evt.stdoutString + evt.stderrString);
    } else {
      this.set('resultText','Failed: ' + evt.errorText + ' ' + evt.stdoutString + evt.stderrString);
    }
  },
  Lut1: function (sender) {

    if (sender.active) {
      this.exec("/media/developer/apps/usr/palm/services/org.webosbrew.hyperhdr.loader.service/lut_compressed.sh");
    }
  },
  Lut2: function (sender) {
    console.info("toggle:", sender);
    
    if (sender.active) {
      this.exec("/media/developer/apps/usr/palm/services/org.webosbrew.hyperhdr.loader.service/lut_uncompressed.sh");
    }
  },
  Lut: function (sender) {
    console.info("toggle:", sender);
    
    if (sender.active) {
      this.exec("/media/developer/apps/usr/palm/services/org.webosbrew.hyperhdr.loader.service/lut_default.sh");
    }
  },

});
