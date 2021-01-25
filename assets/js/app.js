// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css"
import 'alpinejs'

import Tagify from '@yaireo/tagify'
import "@yaireo/tagify/dist/tagify.css"

import "phoenix_html"
import { Socket } from "phoenix"
import NProgress from "nprogress"
import { LiveSocket } from "phoenix_live_view"
import Gallery from './gallery';

let Hooks = { Gallery: Gallery }

let called_inputs = [];
Hooks.tag = {
  mounted() {
    // children[1] is the first input, which gets cannabilized by tagify. A second, hidden input with an identical id is added, which we then change the value of to send data to and from liveview while maintaining valid form_for support
    const form_id = this.el.children[1].id
    called_inputs = called_inputs.concat(form_id)
    const input = document.getElementById(form_id);
    console.log(form_id.search("-form_"))
    const input2 = document.getElementById(form_id.slice(form_id.search("-form_") + 6) + "-datalist");
    const tagify = new Tagify(input, {
      originalInputValueFormat: valuesArr => valuesArr.map(item => item.value).join(','),
      whitelist: input2.dataset.list.split(','),
      dropdown: {
        classname: "color-blue",
        enabled: 0,              // show the dropdown immediately on focus
        maxItems: 5,
        position: "text",         // place the dropdown near the typed text
        closeOnSelect: false,          // keep the dropdown open after selecting a suggestion
        highlightFirst: true
      }
    })
    input.addEventListener('change', onChange)
    function onChange(e) {
      // outputs a String, so eval it cause its super safe prolly /s
      // also it's a different docment from above, though they have the same id
      let arrayinput = document.getElementById(form_id);
    }
  }

}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks, params: { _csrf_token: csrfToken }, dom: {
    onBeforeElUpdated(from, to) {
      if (from.__x) { window.Alpine.clone(from.__x, to) }
    }
  }
})

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

