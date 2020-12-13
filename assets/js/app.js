// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css"
import "@yaireo/tagify/dist/tagify.css"
// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import { Socket } from "phoenix"
import NProgress from "nprogress"
import { LiveSocket } from "phoenix_live_view"
import SlimSelect from 'slim-select'
import Tagify from '@yaireo/tagify'

let Hooks = {}
// var inputElm = document.querySelector('input[name=input-custom-dropdown]'),
//     whitelist = ["A# .NET", "A# (Axiom)", "A-0 System", "A+", "A++", "ABAP", "ABC", "ABC ALGOL", "ABSET", "ABSYS", "ACC", "Accent", "Ace DASL", "ACL2", "Avicsoft", "ACT-III", "Action!", "ActionScript", "Ada", "Adenine", "Agda", "Agilent VEE", "Agora", "AIMMS", "Alef", "ALF", "ALGOL 58", "ALGOL 60", "ALGOL 68", "ALGOL W", "Alice", "Alma-0", "AmbientTalk", "Amiga E", "AMOS", "AMPL", "Apex (Salesforce.com)", "APL", "AppleScript", "Arc", "ARexx", "Argus", "AspectJ", "Assembly language", "ATS", "Ateji PX", "AutoHotkey", "Autocoder", "AutoIt", "AutoLISP / Visual LISP", "Averest", "AWK", "Axum", "Active Server Pages", "ASP.NET", "B", "Babbage", "Bash", "BASIC", "bc", "BCPL", "BeanShell", "Batch (Windows/Dos)", "Bertrand", "BETA", "Bigwig", "Bistro", "BitC", "BLISS", "Blockly", "BlooP", "Blue", "Boo", "Boomerang", "Bourne shell (including bash and ksh)", "BREW", "BPEL", "B", "C--", "C++ – ISO/IEC 14882", "C# – ISO/IEC 23270", "C/AL", "Caché ObjectScript", "C Shell", "Caml", "Cayenne", "CDuce", "Cecil", "Cesil", "Céu", "Ceylon", "CFEngine", "CFML", "Cg", "Ch", "Chapel", "Charity", "Charm", "Chef", "CHILL", "CHIP-8", "chomski", "ChucK", "CICS", "Cilk", "Citrine (programming language)", "CL (IBM)", "Claire", "Clarion", "Clean", "Clipper", "CLIPS", "CLIST", "Clojure", "CLU", "CMS-2", "COBOL – ISO/IEC 1989", "CobolScript – COBOL Scripting language", "Cobra", "CODE", "CoffeeScript", "ColdFusion", "COMAL", "Combined Programming Language (CPL)", "COMIT", "Common Intermediate Language (CIL)", "Common Lisp (also known as CL)", "COMPASS", "Component Pascal", "Constraint Handling Rules (CHR)", "COMTRAN", "Converge", "Cool", "Coq", "Coral 66", "Corn", "CorVision", "COWSEL", "CPL", "CPL", "Cryptol", "csh", "Csound", "CSP", "CUDA", "Curl", "Curry", "Cybil", "Cyclone", "Cython", "Java", "Javascript", "M2001", "M4", "M#", "Machine code", "MAD (Michigan Algorithm Decoder)", "MAD/I", "Magik", "Magma", "make", "Maple", "MAPPER now part of BIS", "MARK-IV now VISION:BUILDER", "Mary", "MASM Microsoft Assembly x86", "MATH-MATIC", "Mathematica", "MATLAB", "Maxima (see also Macsyma)", "Max (Max Msp – Graphical Programming Environment)", "Maya (MEL)", "MDL", "Mercury", "Mesa", "Metafont", "Microcode", "MicroScript", "MIIS", "Milk (programming language)", "MIMIC", "Mirah", "Miranda", "MIVA Script", "ML", "Model 204", "Modelica", "Modula", "Modula-2", "Modula-3", "Mohol", "MOO", "Mortran", "Mouse", "MPD", "Mathcad", "MSIL – deprecated name for CIL", "MSL", "MUMPS", "Mystic Programming L"];


// // initialize Tagify on the above input node reference




// // "remove all tags" button event listener
// document.querySelector('.tags--removeAllBtn')
//     .addEventListener('click', tagify.removeAllTags.bind(tagify))

// // Chainable event listeners
// tagify.on('add', onAddTag)
//       .on('remove', onRemoveTag)
//       .on('input', onInput)
//       .on('edit', onTagEdit)
//       .on('invalid', onInvalidTag)
//       .on('click', onTagClick)
//       .on('focus', onTagifyFocusBlur)
//       .on('blur', onTagifyFocusBlur)
//       .on('dropdown:hide dropdown:show', e => console.log(e.type))
//       .on('dropdown:select', onDropdownSelect)

// var mockAjax = (function mockAjax(){
//     var timeout;
//     return function(duration){
//         clearTimeout(timeout); // abort last request
//         return new Promise(function(resolve, reject){
//             timeout = setTimeout(resolve, duration || 700, whitelist)
//         })
//     }
// })()

// // tag added callback
// function onAddTag(e){
//     console.log("onAddTag: ", e.detail);
//     console.log("original input value: ", inputElm.value)
//     tagify.off('add', onAddTag) // exmaple of removing a custom Tagify event
// }

// // tag remvoed callback
// function onRemoveTag(e){
//     console.log("onRemoveTag:", e.detail, "tagify instance value:", tagify.value)
// }

// // on character(s) added/removed (user is typing/deleting)
// function onInput(e){
//     console.log("onInput: ", e.detail);
//     tagify.settings.whitelist.length = 0; // reset current whitelist
//     tagify.loading(true) // show the loader animation

//     // get new whitelist from a delayed mocked request (Promise)
//     mockAjax()
//         .then(function(result){
//             // replace tagify "whitelist" array values with new values
//             // and add back the ones already choses as Tags
//             tagify.settings.whitelist.push(...result, ...tagify.value)

//             tagify
//               .loading(false)
//               // render the suggestions dropdown.
//               .dropdown.show.call(tagify, e.detail.value);
//         })
//         .catch(err => tagify.dropdown.hide.call(tagify))
// }

// function onTagEdit(e){
//     console.log("onTagEdit: ", e.detail);
// }

// // invalid tag added callback
// function onInvalidTag(e){
//     console.log("onInvalidTag: ", e.detail);
// }

// // invalid tag added callback
// function onTagClick(e){
//     console.log(e.detail);
//     console.log("onTagClick: ", e.detail);
// }

// function onTagifyFocusBlur(e){
//     console.log(e.type, "event fired")
// }

// function onDropdownSelect(e){
//     console.log("onDropdownSelect: ", e.detail)
// }
let called_inputs = [];
Hooks.tag = {
  mounted() {
    // children[1] is the first input, which gets cannabilized by tagify. A second, hidden input with an identical id is added, which we then change the value of to send data to and from liveview while maintaining valid form_for support
    const form_id = this.el.children[1].id
    called_inputs = called_inputs.concat(form_id)
    const input = document.getElementById(form_id);
    const input2 = document.getElementById(form_id.replace("case-form_", '') + "-datalist");
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

Hooks.select = {
  initSelect(classname) {
    new SlimSelect({
      select: classname
    })
  },
  mounted() {
    this.initSelect(".motherboard_support-select");
    this.initSelect(".psu_support-select");
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

