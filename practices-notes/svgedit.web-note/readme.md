[src/gh]: https://github.com/SVG-Edit/svgedit.git "Powerful SVG-Editor for your browser"
[react.src/gh]: https://github.com/SVG-Edit/svg-edit-react.git "React based editor based on SVG-edit svgcanvas"

[site]: https://svg-edit.github.io/svgedit "SVGEdit is a fast, web-based, JavaScript-driven SVG drawing editor that works in any modern browser. SVGEdit is based on a powerful SVG canvas @svgedit/svgcanvas"
[app]: https://svgedit.netlify.app/editor/index.html
[npm]: https://unpkg.com/svgedit@latest/dist/editor/index.html

[pic::logo.svg.src]: https://svg-edit.github.io/svgedit/src/editor/images/logo.svg "<repo>./src/editor/images/logo.svg"
[pic::logo.svg]: ./.images/logo.svg

![logo.svg][pic::logo.svg]

[🍥 src][src/gh] | [🍥 react.src][react.src/gh] | [📜 site (doc)][site] | [🎃 app][app] | [🥫 npm][npm]

### 自托管

~~~ sh
: get src and get in
git clone -- https://github.com/SVG-Edit/svgedit.git && cd svgedit

: to install dependencies
npm i

: to build the svgcanvas dependency locally
npm run build --workspace @svgedit/svgcanvas

: start a local server to test -- http://localhost:8000/src/editor/index.html
npm run start

: to build a bundle that you can serve from your own web server
npm run build
~~~

### 集成

~~~ html
<head>
   <!-- You need to include the CSS for SVGEdit somewhere in your application -->
  <link href="./svgedit.css" rel="stylesheet" media="all"></link>
</head>

<body>
  <!-- svgedit container can be positionned anywhere in the DOM
       but it must have a width and a height -->
  <div id="container" style="width:100%;height:100vh"></div>
</body>
<script type="module">
  /* You need to call the Editor and load it in the <div> */
  import Editor from './Editor.js'
  /* for available options see the file `docs/tutorials/ConfigOptions.md` */
  const svgEditor = new Editor(document.getElementById('container'))
  /* initialize the Editor */
  svgEditor.init()
  /* set the configuration */
  svgEditor.setConfig({
          allowInitialUserOverride: true,
          extensions: [],
          noDefaultExtensions: false,
          userExtensions: []
  })
</script>
</html>
~~~






