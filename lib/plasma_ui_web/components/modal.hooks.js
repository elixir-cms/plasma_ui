const Modal = {
  mounted() {
    const wrapper = this.el.querySelector('.wrapper')
    const open = () => {
      wrapper.classList.remove('hidden')
      wrapper.classList.add('flex')
      window.addEventListener('keyup', handleKeyup)
      setTimeout(() => {
        this.el.classList.add('active')
        wrapper.querySelector('.content').scrollIntoView({
          behavior: 'smooth',
          block: 'center',
          inline: 'nearest'
        })
      }, 50)
    }
    const close = () => {
      window.removeEventListener('keyup', handleKeyup)
      this.el.classList.remove('active')
      setTimeout(() => {
        wrapper.classList.remove('flex')
        wrapper.classList.add('hidden')
      }, 300)
    }
    this.el.addEventListener('open', open)
    this.el.addEventListener('close', close)
    const handleKeyup = (e) => {
      if (e.keyCode === 27) close()
    }
  }
}

export { Modal }
