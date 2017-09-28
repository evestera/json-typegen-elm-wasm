# json_typegen Elm/wasm frontend

Frontend for [json_typegen](https://github.com/evestera/json_typegen) that uses only static files, i.e. does not need a separate backend.

## Building and running

To build this you will need [emscripten](http://emscripten.org/) and [a Rust toolchain](https://www.rustup.rs/) with the wasm-target installed (`rustup target add wasm32-unknown-emscripten`).

The guide I followed for the basic setup: [Get Started with Rust, WebAssembly, and Webpack](https://medium.com/@ianjsikes/get-started-with-rust-webassembly-and-webpack-58d28e219635)

Once these dependencies are installed, you can compile and serve with:

```sh
npm run compile
npm run serve
```

Note: Since the wasm file is fetched, and `fetch(...)` does not work with `file://` paths, you need to serve the files to make it work.

To pre-build Rust/wasm component (for easier debugging of that part):

```sh
cargo build --target=wasm32-unknown-emscripten --release
```
