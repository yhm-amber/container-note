[src/gh]: https://github.com/barry-jay-personal/tree-calculus.git "(MIT) (Languages: Coq 81.1%, Makefile 16.4%, Rust 2.5%) Proofs in Coq for the book Reflective Programs in Tree Calculus // 用 Coq 为《Reflective Programs in Tree Calculus》一书提供的证明"
[site/us]: https://treecalcul.us/
[play/site]: https://treecalcul.us/live/

[impl/site]: https://treecalcul.us/implementation/
[impl.js]: https://runjs.app/play/#Ly8gVEMgICAgICAgfCAgSlMKLy8gLS0tLS0tLS0tKy0tLS0tLS0tLS0tCi8vIHQgICAgICAgIHwgIFtdCi8vIHQgYSAgICAgIHwgIFthXQovLyB0IGEgYiAgICB8ICBbYiwgYV0KLy8gdCBhIGIgYyAgfCAgW2MsIGIsIGFdCgpjb25zdCBhcHBseSA9IChhLCBiKSA9PiB7CiAgY29uc3QgZXhwcmVzc2lvbiA9IFtiLCAuLi5hXQogIGNvbnN0IHRvZG8gPSBbZXhwcmVzc2lvbl07CiAgd2hpbGUgKHRvZG8ubGVuZ3RoKSB7CiAgICBjb25zdCBmID0gdG9kby5wb3AoKTsKICAgIGlmIChmLmxlbmd0aCA8IDMpIGNvbnRpbnVlOwogICAgdG9kby5wdXNoKGYpOwogICAgY29uc3QgYSA9IGYucG9wKCksIGIgPSBmLnBvcCgpLCBjID0gZi5wb3AoKTsKICAgIGlmIChhLmxlbmd0aCA9PT0gMCkgZi5wdXNoKC4uLmIpOwogICAgZWxzZSBpZiAoYS5sZW5ndGggPT09IDEpIHsKICAgICAgY29uc3QgbmV3UG90UmVkZXggPSBbYywgLi4uYl07CiAgICAgIGYucHVzaChuZXdQb3RSZWRleCwgYywgLi4uYVswXSk7CiAgICAgIHRvZG8ucHVzaChuZXdQb3RSZWRleCk7CiAgICB9CiAgICBlbHNlIGlmIChhLmxlbmd0aCA9PT0gMikKICAgICAgaWYgKGMubGVuZ3RoID09PSAwKSBmLnB1c2goLi4uYVsxXSk7CiAgICAgIGVsc2UgaWYgKGMubGVuZ3RoID09PSAxKSBmLnB1c2goY1swXSwgLi4uYVswXSk7CiAgICAgIGVsc2UgaWYgKGMubGVuZ3RoID09PSAyKSBmLnB1c2goY1swXSwgY1sxXSwgLi4uYik7CiAgfQogIHJldHVybiBleHByZXNzaW9uOwp9OwoKLy8gRXhhbXBsZTogTmVnYXRpbmcgYm9vbGVhbnMKY29uc3QgX2ZhbHNlID0gW107CmNvbnN0IF90cnVlID0gW1tdXTsKY29uc3QgX25vdCA9IFtbXSxbW19mYWxzZSxbXV0sX3RydWVdXTsKYXBwbHkoX25vdCwgX2ZhbHNlKTsgLy8gW1tdXSA9IF90cnVlCmFwcGx5KF9ub3QsIF90cnVlKTsgIC8vIFtdICAgPSBfZmFsc2U=
[impl.ml]: https://try.ocamlpro.com/#file/bf16a2 "#code/(*'TC'''''''$5''OCaml!'*'---------+-------------!'*'t''''''''$5''Leaf!'*'t'a''''''$5''Stem'a!'*'t'a'b''''$5''Fork'(a,'b)!*)!!type't'=!$5'Leaf!$5'Stem'of't!$5'Fork'of't'*'t!!let'rec'apply'a'b'=!match'a'with!$5'Leaf'-$.'Stem'b!$5'Stem'a'-$.'Fork'(a,'b)!$5'Fork'(Leaf,'a)'-$.'a!$5'Fork'(Stem'a1,'a2)'-$.'apply'(apply'a1'b)'(apply'a2'b)!$5'Fork'(Fork'(a1,'a2),'a3)'-$.!match'b'with!$5'Leaf'-$.'a1!$5'Stem'u'-$.'apply'a2'u!$5'Fork'(u,'v)'-$.'apply'(apply'a3'u)'v!!(*'Example:'Negating'booleans'*)!let'_false'='Leaf!let'_true'='Stem'Leaf!let'_not'='Fork'(Fork'(_true,'Fork'(Leaf,'_false)),'Leaf)';;!!apply'_not'_false'(*'Stem'Leaf'='_true''*)';;!apply'_not'_true''(*'Leaf''''''='_false'*)';;"

[spec/site]: https://treecalcul.us/specification/

[about/site]: https://treecalcul.us/about/

[knows-by]: https://mp.weixin.qq.com/s/7eboJcnIpsM7Un5u5OUztA "Tree Calculus：一门简洁而强大的计算型语言"
