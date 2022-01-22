const ToggleSwitch = {
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

export { ToggleSwitch }
