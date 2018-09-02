HTMLWidgets.widget({

  name: 'trianglify',

  type: 'output',

  factory: function(el, width, height) {

    var pattern,
        options,
        widget,
        parent;

    return {

      renderValue: function(x) {

        widget = document.getElementById(el.id);

        options = x;
        console.log(options);
        options.width = widget.offsetWidth;
        options.height = widget.offsetHeight;
        console.log(options);

      	pattern = Trianglify(options);
      	document.getElementById(el.id).appendChild(pattern.canvas());

      },

      resize: function(width, height) {

        widget = document.getElementById(el.id);
        options.width = widget.offsetWidth;
        options.height = widget.offsetHeight;
        pattern = Trianglify(options);
        parent = document.getElementById(el.id);
        parent.removeChild(parent.childNodes[0]);
        document.getElementById(el.id).appendChild(pattern.canvas());

      }

    };
  }
});
