module.exports = {
  purge: {
    mode: 'all',
    preserveHtmlElements: false,
    content: [
      '../lib/**/*.ex',
      '../lib/**/*.leex',
      '../lib/**/*.eex',
      './js/**/*.js'
    ]
  },
  theme: {}
}
