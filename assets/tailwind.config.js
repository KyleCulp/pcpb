module.exports = {
  future: {
    // removeDeprecatedGapUtilities: true,
    // purgeLayersByDefault: true,
  },
  purge: [
    '../lib/**/*.ex',
    '../lib/**/*.leex',
    '../lib/**/*.eex',
    './js/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        pcpbblue: "#3A93FF",
        pcpbblack: "#252525"
      },
      gridColumn: {
        'span-30': 'span 30 / span 30',
        'span-31': 'span 31 / span 31',
        'span-32': 'span 32 / span 32',
      },
      gridRow: {
        'span-10': 'span 10 / span 10',
        'span-11': 'span 11 / span 11',
      },
      gridTemplateColumns: {
       '24': 'repeat(24, minmax(0, 1fr))',
      },
      gridTemplateRows: {
       '12': 'repeat(12, minmax(0, 1fr))',
      }
    },

  },
  variants: {},
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
