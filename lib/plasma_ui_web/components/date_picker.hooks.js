import flatpickr from 'flatpickr'

const DatePicker = {
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

export { DatePicker }
