const Alter = {
  mounted() {
    this.el.addEventListener('opened', () => {
      document.getElementById('new_field_field_name').focus()
    })
  }
}

export { Alter }
