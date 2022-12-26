<template>
    <div :id="id" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>{{id}}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary">Save changes</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
            </div>
        </div>
    </div>
</template>
<script>
import $ from 'jquery' 
export default {
    data() {
        return {
            id: null
        }
    },
    created() {
        this.id = this.$route.params.id
        console.log("this.$route.params.id", this.$route.params.id);
        if(this.$route.params.id) {
            $("#"+ this.$route.params.id).modal({ show : true });
        }
    },
    watch: {
        '$route.params.id': {
            handler() {
                console.log("abc");
                console.log("this.$route.params.id", this.$route.params.id);
                this.id = this.$route.params.id
                $("#"+ this.id).modal({ show : true });
            },
            immediate: true
        } 
    }
}
</script>