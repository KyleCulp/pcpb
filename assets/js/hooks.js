import SlimSelect from 'slim-select'

export let Hooks = {}
Hooks.select = {
  mounted() {
    console.log("xd")
    new SlimSelect({
      select: '.slim-select'
    })
  },

}
