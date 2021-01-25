import Sortable from 'sortablejs';

export default {

  mounted() {
    const hook = this;

    var sortable = Sortable.create(this.el, {
      animation: 0,
      delay: 50,
      delayOnTouchOnly: true,
      group: 'shared',
      draggable: '.draggable',
      ghostClass: 'sortable-ghost',
      onEnd: function (evt) {
        // const children = this.el.children;
        // var itemEl = evt.item;
        // let images = [];
        // for (const child in children) {
        //   if (typeof children[child] == 'object') {
        //     images.push(children[child].id)
        //   }
        // }
        console.log(evt)
        // Give the server an in-order list of image id's for the server
        // to internally sort the image structs
        hook.pushEventTo('#' + this.el.id, 'imagechange', {
          image_id: evt.item.id,
          old_index: evt.oldIndex,
          new_index: evt.newIndex
        });
      },
      onSort: function (evt) {
        // same properties as onEnd
        var itemEl = evt.item;
      },
    });
  },
  updated() {

  },
  destroyed() {

  }

};
