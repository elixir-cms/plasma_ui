import '../css/app.scss'
import '@fortawesome/fontawesome-free/css/all.min.css'
import '@fortawesome/fontawesome-free/js/all.min.js'
import 'phoenix_html'
import Alpine from 'alpinejs'
import flatpickr from 'flatpickr'
import { LiveSocket } from 'phoenix_live_view'
import topbar from 'topbar'
import { Socket } from 'phoenix'

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: '#29d' }, shadowColor: 'rgba(0, 0, 0, .3)' })
window.addEventListener('phx:page-loading-start', (info) => topbar.show())
window.addEventListener('phx:page-loading-stop', (info) => topbar.hide())

// CSRF token
const _csrf_token = document
      .querySelector("meta[name='csrf-token']")
      .getAttribute('content')

// LiveView
let hooks = {}
hooks.Alter = {
  mounted() {
    this.handleEvent('scrollToTop', () =>
      window.scrollTo({ top: 0, behavior: 'smooth' })
    )
  }
}
hooks.DatePicker = {
  mounted() {
    const picker = this.el.querySelector('.flatpickr')
    const sibling = this.el.querySelector('.sibling')
    const clickPicker = () => picker.click()
    const pushValue = () =>
          this.pushEvent('date_picker_changed', {
            field_name: sibling.id,
            field_type: 'naive_datetime',
            value: picker.value
          })
    flatpickr(picker, {
      enableTime: true,
      dateFormat: 'Y-m-d H:i',
      defaultDate: picker.getAttribute('default-date')
    })
    pushValue()
    sibling.addEventListener('focus', clickPicker)
    sibling.addEventListener('click', clickPicker)
    picker.addEventListener('change', pushValue)
  }
}
hooks.ToggleSwitch = {
  mounted() {
    const toggle = this.el.querySelector('[type="checkbox"]')
    this.el.querySelector('[tabindex="0"]').addEventListener('keyup', (e) => {
      if (e.keyCode == 32) e.target.click()
    })
    toggle.addEventListener('change', () => {
      this.pushEvent('toggle_switch_changed', {
        field_name: toggle.id,
        field_type: 'boolean',
        value: toggle.checked
      })
    })
  }
}
let liveSocket = new LiveSocket('/live', Socket, {
  params: { _csrf_token },
  dom: {
    onBeforeElUpdated(from, to) {
      if (from.__x) Alpine.clone(from.__x, to)
    }
  },
  hooks
})
liveSocket.connect()
window.liveSocket = liveSocket
