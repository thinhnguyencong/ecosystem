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
        async initData() {
            if(!this.adminState.users.length) {
                await this.$store.dispatch("admin/getAllUsers")
            }
            this.users = this.adminState.users.map((user, index) => ({id: user._id, name: user.name.trim()}))
        },
        clearContent(value) {
            this.content = ""
        },

    },
    computed: {
        adminState() {return this.$store.state.admin}
    }
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