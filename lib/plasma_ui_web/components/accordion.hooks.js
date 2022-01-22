const Accordion = {
  mounted() {
    const content = this.el.querySelector('.content')
    const trigger = this.el.querySelector('.trigger')
    const toggle = (e) => {
      e.preventDefault()
      e.stopImmediatePropagation()
      const expanded = this.el.classList.contains('expanded')
      if (!expanded) content.classList.remove('hidden')
      else setTimeout(() => content.classList.add('hidden'), 300)
      setTimeout(() => this.el.classList.toggle('expanded'), 50)
      setTimeout(() => {
        trigger.scrollIntoView({
          behavior: 'smooth',
          block: 'start',
          inline: 'nearest'
        })
      }, 300)
    }
    this.el.addEventListener('toggle', toggle)
    trigger.addEventListener('keyup', (e) =>
      e.keyCode === 32 ? trigger.click() : 0
    )
  }
}

export { Accordion }
