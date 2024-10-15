[src/gh]: https://github.com/gosub-io/gosub-engine.git "(MIT) (Languages: Rust 82.2%, HTML 12.5%, Python 2.3%, CSS 1.6%, Go 1.3%, Makefile 0.1%) Our main browser engine repository."
[site]: https://gosub.io/

[🤿 src][src/gh] | [🏄🏻‍♀️ site][site]

You can run the following binaries:

| Command                                | Type | Description                                                                                                                                                     |
|----------------------------------------|------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `cargo run -r --bin config-store`      | bin  | A simple test application of the config store for testing purposes                                                                                              |
| `cargo run -r --bin css3-parser`       | bin  | Show the parsed css tree                                                                                                                                        |
| `cargo run -r --bin display-text-tree` | bin  | A simple parser that will try and return a textual presentation of the website                                                                                  |
| `cargo run -r --bin gosub-parser`      | bin  | The actual html5 parser/tokenizer that allows you to convert html5 into a document tree.                                                                        |
| `cargo run -r --bin html5-parser-test` | test | A test suite that tests all html5lib tests for the treebuilding                                                                                                 |
| `cargo run -r --bin parser-test`       | test | A test suite for the parser that tests specific tests. This will be removed as soon as the parser is completely finished as this tool is for developement only. |
| `cargo run -r --bin renderer`          | bin  | Render a html page (WIP)                                                                                                                                        |
| `cargo run -r --bin run-js`            | bin  | Run a JS file (Note: console and event loop are not yet implemented)                                                                                            |


