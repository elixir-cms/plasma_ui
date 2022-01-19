// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import '../css/app.scss'

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import 'phoenix_html'
import { Socket } from 'phoenix'
import topbar from 'topbar'
import { LiveSocket } from 'phoenix_live_view'
import Alpine from 'alpinejs'
import '@fortawesome/fontawesome-free/js/all.min.js'
import '@fortawesome/fontawesome-free/css/all.min.css'

let csrfToken = document
    .querySelector("meta[name='csrf-token']")
    .getAttribute('content')
let Hooks = {}
Hooks.scrollToTop = {}
Hooks.Alter = {
  mounted() {
    this.handleEvent('scrollToTop', () =>
      window.scrollTo({ top: 0, behavior: 'smooth' })
    )
  }
}
let liveSocket = new LiveSocket('/live', Socket, {
  params: { _csrf_token: csrfToken },
  dom: {
    onBeforeElUpdated(from, to) {
      if (from.__x) {
        Alpine.clone(from.__x, to)
      }
    }
  },
  hooks: Hooks
})

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: '#29d' }, shadowColor: 'rgba(0, 0, 0, .3)' })
window.addEventListener('phx:page-loading-start', (info) => topbar.show())
window.addEventListener('phx:page-loading-stop', (info) => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

// tailwind toggle-switch
window.addEventListener('DOMContentLoaded', function () {
  for (let tabindex of document.querySelectorAll(
    '.toggle-switch [tabindex="0"]'
  )) {
    tabindex.addEventListener('keyup', (e) => {
      if (e.keyCode == 32) e.target.click()
    })
  }
  for (let toggle of document.querySelectorAll(
    '.toggle-switch input[type="checkbox"]'
  )) {
    toggle.addEventListener('change', () => {
      toggle.dispatchEvent(
        new CustomEvent('new-value', {
          detail: {
            id: toggle.id,
            value: toggle.checked
          }
        })
      )
    })
  }
})
