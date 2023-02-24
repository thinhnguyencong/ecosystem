<template>
        <textarea placeholder="Write your comment..."
            class="mention form-control shadow-none border-0" autofocus="true">
        </textarea>

</template>
<script>

export default {
    created() {
        this.$parent.$on('clear-content', this.clearContent);
    },
  mounted() {
    let app = this
    window.$('textarea.mention').mentionsInput({
        onDataRequest: async function (mode, query, callback) {
            console.log("abcbcbcbcbcb", query);
            console.log(app.users);
            if(!app.users.length) {
                console.log("call API");
                await app.initData()
            }
            let data = app.users
            data = _.filter(data, function (item) { return item.name.toLowerCase().indexOf(query.toLowerCase()) > -1 });

            callback.call(this, data);
        } ,
        templates: {
            mentionItemSyntax: window._.template('@[<%= value %>](<%= type %>:<%= id %>)')
        },
        minChars: 1, //Minimum chars to fire the event
        onCaret: true
    });
  },
  data () {
    return {
      users: [],
    }
  },

  methods: {
    initData() {
        let data =  [
            { id: 1, name: 'Kenneth Auchenberg', 'type': 'contact' },
            { id: 2, name: 'Jon Froda', 'type': 'contact' },
            { id: 3, name: 'Anders Pollas', 'type': 'contact' },
            { id: 4, name: 'Kasper Hulthin', 'type': 'contact' },
            { id: 5, name: 'Andreas Haugstrup', 'type': 'contact' },
            { id: 6, name: 'Pete Lacey', 'type': 'contact' },
            { id: 7, name: 'kenneth@auchenberg.dk', 'type': 'contact' },
            { id: 8, name: 'Pete Awesome Lacey', 'type': 'contact' },
            { id: 9, name: 'Kenneth Hulthin', 'type': 'contact' }
        ]
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                this.users = data
            }, 300)
        }) 
    }

  },
}
</script>


<style>
textarea.form-control:focus {
    background-color: transparent;
}
</style>