const Elm = require('./Main.elm')
const wasm = require('./main.rs')

const pageLoad = Date.now();

const app = Elm.Main.fullscreen({
  stored: window.localStorage.getItem('elm-content')
})

app.ports.store.subscribe(content => {
  window.localStorage.setItem('elm-content', content)
});

wasm.initialize({noExitRuntime: true}).then(module => {
  console.log('wasm ready', (Date.now() - pageLoad) + 'ms')

  const codegen = module.cwrap('codegen', 'string', ['string'])

  app.ports.codegenrequest.subscribe(input => {
    const output = codegen(input)
    app.ports.codegenresult.send(output)
  })

  app.ports.codegenready.send(null)
})
