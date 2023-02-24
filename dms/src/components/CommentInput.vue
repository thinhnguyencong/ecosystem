<template>
    <textarea v-model="content" placeholder="Write your comment..." class="mention form-control shadow-none border-0" focus="true">
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
                if (!app.users.length) {
                    console.log("call API");
                    await app.initData()
                }
                let data = app.users
                data = _.filter(data, function (item) { return item.name.toLowerCase().indexOf(query.toLowerCase()) > -1 });
                callback.call(this, data);

            },
            minChars: 1, //Minimum chars to fire the event
            templates: {
                mentionItemSyntax: _.template('@[<%= value %>]'),
            },
            onCaret: true
        });
    },
    data() {
        return {
            content: "",
            users: [],
        }
    },

    methods: {
        initData() {
            let data = [
                { id: 1, name: 'Kenneth Auchenberg' },
                { id: 2, name: 'Jon Froda' },
                { id: 3, name: 'Anders Pollas' },
                { id: 4, name: 'Kasper Hulthin' },
                { id: 5, name: 'Andreas Haugstrup' },
                { id: 6, name: 'Pete Lacey' },
                { id: 7, name: 'kenneth@auchenberg.dk' },
                { id: 8, name: 'Pete Awesome Lacey' },
                { id: 9, name: 'Kenneth Hulthin' }
            ]
            return new Promise((resolve, reject) => {
                setTimeout(() => {
                    this.users = data
                }, 500)
            })
        },
        clearContent(value) {
            this.content = ""
        }

    },
}
</script>

<style>
textarea.form-control:focus {
    background-color: transparent;
}

textarea {
    border: none;
    overflow-y: scroll;
    max-height: 4rem !important;
    resize: none;
    /* Remove this if you want the user to resize the textarea */
}
</style>