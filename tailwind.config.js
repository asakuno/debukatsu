module.exports = {
  mode: 'jit',
  purge: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        accent: '#ff00aa',
        original: '#ffcc66'
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [require("daisyui")],
}