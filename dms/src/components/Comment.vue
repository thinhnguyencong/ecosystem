<template>
    <div class="comment-widgets m-b-20">
        <div v-for="(comment, index) in comments" :key="index" class="d-flex flex-row comment-row">
            <div class="p-2"><span class="round"><img src="https://www.pngitem.com/pimgs/m/421-4212341_default-avatar-svg-hd-png-download.png" alt="user" width="50"></span></div>
            <div class="p-2 comment-text w-100">
                <h5 class="d-inline">{{ comment.name }}</h5> &nbsp; &nbsp; &nbsp;<small class="date">{{customTime(comment.createdAt)}}</small>
                <p class="m-b-5 m-t-10">{{comment.content}}</p>
                <a v-if="comment.attachments.length" href="#" @click="handleShow(comment)">{{ comment.attachments.length }} Attachment(s)</a>
                <div v-show="comment.isActive">
                    
                    <div class="list-group">
                            <a v-for="(attachment, index) in comment.attachments" @click="openModal(attachment.id)" href="#" class="list-group-item list-group-item-action">
                                {{ (index+1)+". " }}{{attachment.name}}
                            </a>
                    </div>

                </div>
            </div>
        </div>
    </div>
    
</template>
<script>
import $ from 'jquery' 

export default {
    props: {
        commentsProp: Array,
    },
    data() {
        return {
            comments: [],
        }
    },
    methods: {
        openModal(id) {
            $("#attach-"+id).modal('toggle');
        },
        customTime(time) {
            return dayjs(time).fromNow();
        },
        handleShow(comment) {
            comment.isActive = !comment.isActive;
        },
        sortComment(comments) {
            if (comments.length == 1 || comments.length == 0) {
                return comments;
            }
            return comments.sort((a, b) => b.createdAt - a.createdAt);
        },
    },
    created() {
        // this.$set(this, "file", )
    },
    mounted() {
        console.log("MOUNTTTTTTTTTTTTTT");
        
        this.$set(this, "comments", this.sortComment(this.commentsProp.map(x => ({ ...x, isActive: false }))));
    },
    watch: {
        commentsProp: function (newVal, oldVal) {
            this.$set(this, "comments", this.sortComment(newVal.map(x => ({ ...x, isActive: false }))));
        },
    },
}
</script>
<style scoped>


.comment-widgets .comment-row:hover {
    background: rgba(0, 0, 0, 0.02);
}

.comment-widgets .comment-row {
    border-bottom: 1px solid rgba(120, 130, 140, 0.13);
}
.comment-text:hover{
    visibility: hidden;
}
.comment-text:hover{
    visibility: visible;
}

.label {
    padding: 3px 10px;
    line-height: 13px;
    color: #ffffff;
    font-weight: 400;
    border-radius: 4px;
    font-size: 75%;
}

.round img {
    border-radius: 100%;
}

.label-info {
    background-color: #1976d2;
}

.label-success {
    background-color: green;
}

.label-danger {
    background-color: #ef5350;
}

.action-icons a {
    padding-left: 7px;
    vertical-align: middle;
    color: #99abb4;
}

.action-icons a:hover {
    color: #1976d2;
}

.mt-100 {
    margin-top: 100px
}

.mb-100 {
    margin-bottom: 100px
}
</style>