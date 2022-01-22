import '../css/app.scss'
import '@fortawesome/fontawesome-free/css/all.min.css'
import '@fortawesome/fontawesome-free/js/all.min.js'
import 'phoenix_html'
import hooks from './_hooks'
import { LiveSocket } from 'phoenix_live_view'
import topbar from 'topbar'
import { Socket } from 'phoenix'

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: '#31708f' }, shadowColor: 'rgba(0, 0, 0, .3)' })
window.addEventListener('phx:page-loading-start', () => topbar.show())
window.addEventListener('phx:page-loading-stop', () => topbar.hide())

// CSRF token
const _csrf_token = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute('content')

// LiveView
let liveSocket = new LiveSocket('/live', Socket, {
  params: { _csrf_token },
  hooks
})
liveSocket.connect()
window.liveSocket = liveSocket
